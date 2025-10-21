from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from sqlalchemy import Boolean
from decimal import Decimal
from datetime import datetime, date
from pathlib import Path
from dotenv import load_dotenv
import os
import re

# ✅ Cloudinary
import cloudinary
import cloudinary.uploader
from cloudinary.utils import cloudinary_url
import os
import sendgrid
from sendgrid.helpers.mail import Mail

# ✅ Load .env for local development
load_dotenv()


SENDGRID_API_KEY = os.getenv("SENDGRID_API_KEY")
sg = sendgrid.SendGridAPIClient(api_key=SENDGRID_API_KEY)

# ✅ App Configuration
app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv("SECRET_KEY", "fallback-secret-key")

# ✅ Detect environment & pick DB URL
if os.environ.get("RAILWAY_ENVIRONMENT"):
    db_url = os.getenv("DATABASE_URL")  # Railway internal DB
else:
    db_url = os.getenv("DATABASE_PUBLIC_URL")  # Local/public DB

# ✅ Fallback to SQLite if nothing found
if not db_url:
    db_url = "sqlite:///local.db"
    print("💾 Using local SQLite database for development.")
else:
    # Fix old Heroku-style format
    if db_url.startswith("postgres://"):
        db_url = db_url.replace("postgres://", "postgresql://", 1)

    # Force SSL for PostgreSQL if not present
    if "sslmode" not in db_url and db_url.startswith("postgresql://"):
        db_url += "?sslmode=require"

    print(f"🐘 Using PostgreSQL database: {db_url.split('@')[-1]}")  # hides password

# ✅ Database config
app.config['SQLALCHEMY_DATABASE_URI'] = db_url
app.config['SESSION_TYPE'] = 'filesystem'
app.config['SESSION_PERMANENT'] = False

# ✅ Initialize DB + Migrations
db = SQLAlchemy(app)
from flask_migrate import Migrate
migrate = Migrate(app, db)

# ✅ Cloudinary Config (just use CLOUDINARY_URL)
cloudinary.config(
    secure=True
)

# ✅ Create tables if they don’t exist
with app.app_context():
    try:
        db.create_all()
        print("✅ Tables checked/created.")
    except Exception as e:
        print("❌ Error creating tables:", e)

# --------------------------
# MODELS
# --------------------------

class Category(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)
    products = db.relationship('Product', backref='category', lazy=True)
    image = db.Column(db.String(255))

class Visit(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ip = db.Column(db.String(100))
    date = db.Column(db.Date, default=date.today) 
    user_agent = db.Column(db.String(500))
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
    
class PromoBanner(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100))
    subtitle = db.Column(db.String(255))
    image = db.Column(db.String(255))
    status = db.Column(db.String(10), default='Active')  # 'Active' or 'Inactive'
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class OpticianMessage(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sender_id = db.Column(db.String(100), nullable=False)  # Use session ID or user ID
    sender_name = db.Column(db.String(100))  # <-- new!
    role = db.Column(db.String(20))  # 'user' or 'admin'
    message = db.Column(db.Text, nullable=False)
    seen = db.Column(db.Boolean, default=False)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

class Coupon(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(50), unique=True, nullable=False)
    discount_type = db.Column(db.String(10), default="percent")  # 'percent' or 'flat'
    discount_value = db.Column(db.Float, nullable=False)
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
class Order(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(120))
    address = db.Column(db.Text, nullable=False)

    # 👇 Totals
    product_total = db.Column(db.Float, default=0.0)  # 🆕 Products only
    delivery_fee = db.Column(db.Float, default=0.0)
    total = db.Column(db.Float)  # Grand total (products + delivery)
    
    # ✅ Add these two new fields:
    coupon_code = db.Column(db.String(50), nullable=True)
    discount = db.Column(db.Float, default=0.0)


    # 🆕 Tracking number
    tracking_number = db.Column(db.String(50), unique=True, nullable=False)

    # 🆕 Order Status
    status = db.Column(db.String(20), default="Pending")
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    # 🔗 Relationships
    items = db.relationship(
        'OrderItem',
        backref='order',
        lazy=True,
        cascade="all, delete-orphan"
    )

class OrderItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    product_name = db.Column(db.String(120), nullable=False)
    price = db.Column(db.Float, nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    product_image = db.Column(db.String(255))  # optional, for image path

    # ✅ Cascade delete
    order_id = db.Column(
        db.Integer,
        db.ForeignKey("order.id", ondelete="CASCADE"),
        nullable=False
    )

class Product(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), nullable=False)
    price = db.Column(db.Float, nullable=False)
    before_price = db.Column(db.Float, nullable=True)  # Optional old price
    today_price = db.Column(db.Float, nullable=True)
    description = db.Column(db.Text, nullable=True)
    is_soldout = db.Column(db.Boolean, default=False)

    image = db.Column(db.String(200), nullable=False)
    category_id = db.Column(db.Integer, db.ForeignKey('category.id'), nullable=True)

    # ✅ Optional product video (Cloudinary URL)
    video_url = db.Column(db.String(255), nullable=True)

    # ✅ Product Images
    images = db.relationship(
        'ProductImage',
        backref='product',
        lazy=True
    )

    # ✅ Customer Reviews (fixed backref conflict)
    reviews = db.relationship(
        'Review',
        back_populates='product',
        lazy=True,
        cascade="all, delete-orphan"
    )
    
class ProductImage(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(255), nullable=False)
    order = db.Column(db.Integer, default=0)
    product_id = db.Column(db.Integer, db.ForeignKey('product.id'))

class Review(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    product_id = db.Column(db.Integer, db.ForeignKey('product.id'), nullable=False)
    user_name = db.Column(db.String(100), default="Anonymous")  # 🆕 Add this
    rating = db.Column(db.Integer, nullable=False)  # 1–5 stars
    comment = db.Column(db.Text, nullable=True)  # 🆕 rename review → comment
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    product = db.relationship("Product", back_populates="reviews")
    
class Setting(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    # 🔤 Basic Website Info
    website_name = db.Column(db.String(100), default="My Website")
    logo = db.Column(db.String(120))  # Logo filename
    line_banner_text = db.Column(db.String(255))
    background_image = db.Column(db.String(200)) 
    hero_banner = db.Column(db.String(255))  # Hero banner filename
    about_image = db.Column(db.String(500))
    perfume_image = db.Column(db.String(500))
    perfume_video = db.Column(db.String(500))


    # ⏱️ Product Visibility Scheduling
    product_visibility_start = db.Column(db.DateTime)
    product_visibility_end = db.Column(db.DateTime)
    timer_enabled = db.Column(Boolean, default=False)
    coming_soon_message = db.Column(db.Text, default="🚀 Get ready! A fresh collection of products will be available soon.")

    # 🚚 Delivery Settings
    free_delivery_threshold = db.Column(db.Float, default=3000.0)  # e.g. Rs. 1000 above = free delivery
    delivery_fee = db.Column(db.Float, default=200.0)  # standard delivery charge
    
        # 🛠 Maintenance Mode
    maintenance_mode = db.Column(Boolean, default=False)
    maintenance_message = db.Column(db.Text, default="🛠️ Our website is currently under maintenance. Please check back soon.")

# --------------------------
# ROUTES
# --------------------------

# 🏠 Home Page
@app.route('/')
def index():
    category_id = request.args.get('category_id', type=int)  # ✅ force integer
    categories = Category.query.all()
    setting = Setting.query.first()
    promo_banners = PromoBanner.query.filter_by(status='Active').all()
    products = []

    now = datetime.now()

    if setting and setting.timer_enabled and setting.product_visibility_start:
        start = setting.product_visibility_start
        end = setting.product_visibility_end

        if now >= start and (not end or now <= end):
            if category_id:
                products = Product.query.filter_by(category_id=category_id).all()
            else:
                products = Product.query.all()
        else:
            products = []
    else:
        if category_id:
            products = Product.query.filter_by(category_id=category_id).all()
        else:
            products = Product.query.all()

    return render_template(
        'index.html',
        products=products,
        categories=categories,
        setting=setting,
        promo_banners=promo_banners,
        selected_category=category_id
    )

@app.before_request
def track_visits():
    # Skip admin pages
    if request.path.startswith("/admin"):
        return

    ip = request.remote_addr
    user_agent = request.headers.get('User-Agent', '')

    # Detect if it's a mobile device
    is_mobile = re.search(r"Mobile|Android|iPhone|iPad", user_agent, re.I)
    if not is_mobile:
        return  # Only count mobile devices

    today = date.today()

    # Only count if this IP + user_agent combo hasn't visited today
    existing_visit = Visit.query.filter_by(ip=ip, user_agent=user_agent, date=today).first()

    if not existing_visit:
        new_visit = Visit(ip=ip, date=today, user_agent=user_agent)
        db.session.add(new_visit)
        db.session.commit()

@app.after_request
def add_header(response):
    response.cache_control.max_age = 31536000  # 1 year
    return response

@app.route('/admin/visits_data')
def visits_data():
    today_count = Visit.query.filter(Visit.date == date.today()).count()
    total_count = Visit.query.count()
    return jsonify({
        'today_visits': today_count,
        'total_visits': total_count
    })

# 🔍 Search Products
@app.route('/search')
def search():
    query = request.args.get('q', '')
    categories = Category.query.all()
    products = Product.query.filter(Product.name.ilike(f"%{query}%")).all()
    return render_template('index.html', products=products, categories=categories, search_query=query)

# 🛠️ Admin Dashboard

from flask import session, request, redirect, url_for, flash, render_template

# 🧑‍💼 Admin Login
@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():
    # Redirect if already logged in
    if session.get('admin_logged_in'):
        return redirect(url_for('admin_dashboard'))

    # Fetch website settings for logo & name display
    setting = Setting.query.first()

    if request.method == 'POST':
        username = request.form.get('username', '').strip()
        password = request.form.get('password', '').strip()

        # Secure fixed credentials (can be moved to env later)
        ADMIN_USERNAME = 'Auriellebyshsa.'
        ADMIN_PASSWORD = 'Shsa1122'

        if username == ADMIN_USERNAME and password == ADMIN_PASSWORD:
            session['admin_logged_in'] = True
            flash("✅ Welcome back, Admin!", "success")
            return redirect(url_for('admin_dashboard'))
        else:
            flash("❌ Invalid credentials. Please try again.", "danger")
            return redirect(url_for('admin_login'))

    # Render login page with setting
    return render_template('admin_login.html', setting=setting)

# 🔒 Admin Logout
@app.route('/admin/logout')
def admin_logout():
    session.pop('admin_logged_in', None)
    flash("🔒 Logged out.", "info")
    return redirect(url_for('admin_login'))

# 🛡️ Protect Admin Routes
@app.before_request
def protect_admin():
    # Skip protection for login/logout/static
    if request.path.startswith('/static'):
        return
    if request.path in ['/admin/login', '/admin/logout', '/favicon.ico']:
        return

    # Protect all other admin routes
    if request.path.startswith('/admin') and not session.get('admin_logged_in'):
        flash("🔐 Please log in as admin.", "warning")
        return redirect(url_for('admin_login'))

@app.route('/admin', methods=['GET', 'POST'])
def admin_dashboard():
    if not session.get('admin_logged_in'):
        flash("🔐 Admin login required", "warning")
        return redirect(url_for('admin_login'))

    # 🔹 Existing dashboard data
    categories = Category.query.all()
    products = Product.query.all()
    orders = Order.query.order_by(Order.created_at.desc()).all()
    promo_banners = PromoBanner.query.order_by(PromoBanner.id.desc()).all()
    setting = Setting.query.first()

    # 🔹 Coupon list (new)
    coupons = Coupon.query.order_by(Coupon.id.desc()).all()

    # 🔹 Unread Optician messages
    unread_users = db.session.query(OpticianMessage.sender_id).filter(
        OpticianMessage.seen == False,
        OpticianMessage.role == 'user'
    ).distinct().all()
    unread_count = len(unread_users)

    # 🔹 Visits stats
    today = datetime.utcnow().date()
    today_visits = Visit.query.filter(Visit.timestamp >= today).count()
    total_visits = Visit.query.count()

    # ===============================
    # 🔸 Product Add Logic
    # ===============================
    if request.method == 'POST' and 'add_product' in request.form:
        name = request.form.get('name')
        description = request.form.get('description')
        category_id = request.form.get('category_id')
        image_file = request.files.get('image')
        gallery_files = request.files.getlist('gallery_images')
        today_price = request.form.get('today_price')
        before_price = request.form.get('before_price')

        try:
            today_price_val = float(today_price) if today_price else None
            before_price_val = float(before_price) if before_price else None
        except ValueError:
            flash("⚠️ Please enter valid numbers for prices.", "danger")
            return redirect(url_for('admin_dashboard'))

        if today_price_val is None:
            flash("⚠️ Today Price is required!", "danger")
            return redirect(url_for('admin_dashboard'))

        if not image_file or image_file.filename == '':
            flash("❌ Please upload a main image.", "danger")
            return redirect(url_for('admin_dashboard'))

        # ✅ Upload main image to Cloudinary
        upload_result = cloudinary.uploader.upload(
            image_file,
            folder="products",
            public_id=secure_filename(image_file.filename).rsplit('.', 1)[0],
            overwrite=True,
            resource_type="image"
        )
        image_url = upload_result["secure_url"]

        # ✅ Save product
        new_product = Product(
            name=name,
            description=description,
            today_price=today_price_val,
            before_price=before_price_val,
            price=today_price_val,
            image=image_url,
            category_id=category_id
        )
        db.session.add(new_product)
        db.session.commit()

        # ✅ Upload gallery images
        for file in gallery_files:
            if file and file.filename:
                gallery_upload = cloudinary.uploader.upload(
                    file,
                    folder="products/gallery",
                    public_id=secure_filename(file.filename).rsplit('.', 1)[0],
                    overwrite=True,
                    resource_type="image"
                )
                gallery_url = gallery_upload["secure_url"]

                db.session.add(ProductImage(
                    product_id=new_product.id,
                    filename=gallery_url
                ))

        db.session.commit()
        flash("✅ Product and gallery images added successfully!", "success")
        return redirect(url_for('admin_dashboard'))

    # ===============================
    # 🎟️ Coupon Management Logic
    # ===============================
    if request.method == 'POST' and 'add_coupon' in request.form:
        code = request.form.get('code', '').upper().strip()
        discount_type = request.form.get('discount_type', 'percent')
        discount_value = request.form.get('discount_value', 0)
        is_active = True if request.form.get('is_active') == 'on' else False

        # Validate input
        if not code or not discount_value:
            flash("⚠️ Please fill in all coupon fields.", "danger")
            return redirect(url_for('admin_dashboard'))

        try:
            discount_value = float(discount_value)
        except ValueError:
            flash("⚠️ Invalid discount value.", "danger")
            return redirect(url_for('admin_dashboard'))

        existing = Coupon.query.filter_by(code=code).first()
        if existing:
            flash("⚠️ Coupon code already exists!", "danger")
            return redirect(url_for('admin_dashboard'))

        new_coupon = Coupon(
            code=code,
            discount_type=discount_type,
            discount_value=discount_value,
            is_active=is_active
        )
        db.session.add(new_coupon)
        db.session.commit()
        flash(f"🎟️ Coupon '{code}' added successfully!", "success")
        return redirect(url_for('admin_dashboard'))

    if request.method == 'POST' and 'toggle_coupon' in request.form:
        coupon_id = request.form.get('coupon_id')
        coupon = Coupon.query.get(coupon_id)
        if coupon:
            coupon.is_active = not coupon.is_active
            db.session.commit()
            flash(f"🔄 Coupon '{coupon.code}' status updated!", "info")
        return redirect(url_for('admin_dashboard'))

    if request.method == 'POST' and 'delete_coupon' in request.form:
        coupon_id = request.form.get('coupon_id')
        coupon = Coupon.query.get(coupon_id)
        if coupon:
            db.session.delete(coupon)
            db.session.commit()
            flash(f"🗑️ Coupon '{coupon.code}' deleted.", "danger")
        return redirect(url_for('admin_dashboard'))

    # ===============================
    # 🔹 Render dashboard
    # ===============================
    return render_template(
        'admin_dashboard.html',
        categories=categories,
        products=products,
        orders=orders,
        setting=setting,
        promo_banners=promo_banners,
        coupons=coupons,
        unread_count=unread_count,
        today_visits=today_visits,
        total_visits=total_visits
    )

# --------------------------
# 📸 Promo Banner Management (Cloudinary)
# --------------------------

@app.route('/admin/add-banner', methods=['POST'])
def add_promo_banner():
    title = request.form['title']
    subtitle = request.form['subtitle']
    status = request.form['status'].capitalize()  # ✅ Normalize to "Active" or "Inactive"
    file = request.files['image']

    if file:
        # ✅ Upload banner to Cloudinary
        upload_result = cloudinary.uploader.upload(
            file,
            folder="banners",
            public_id=secure_filename(file.filename).rsplit('.', 1)[0],
            overwrite=True,
            resource_type="image"
        )
        image_url = upload_result["secure_url"]

        banner = PromoBanner(title=title, subtitle=subtitle, status=status, image=image_url)
        db.session.add(banner)
        db.session.commit()
        flash("✅ Promo Banner added!", "success")

    return redirect(url_for('admin_dashboard'))


@app.route('/admin/promo-banners', methods=['GET', 'POST'])
def manage_promo_banners():
    promo_banners = PromoBanner.query.all()
    return render_template('manage_promo_banners.html', promo_banners=promo_banners)


@app.route('/admin/edit-promo/<int:banner_id>', methods=['GET', 'POST'])
def edit_promo_banner(banner_id):
    banner = PromoBanner.query.get_or_404(banner_id)
    if request.method == 'POST':
        banner.title = request.form['title']
        banner.subtitle = request.form['subtitle']
        banner.status = request.form['status'].capitalize()

        # ✅ Update image if a new one is uploaded
        image = request.files.get('image')
        if image and image.filename != '':
            upload_result = cloudinary.uploader.upload(
                image,
                folder="banners",
                public_id=secure_filename(image.filename).rsplit('.', 1)[0],
                overwrite=True,
                resource_type="image"
            )
            banner.image = upload_result["secure_url"]

        db.session.commit()
        flash("✅ Promo banner updated!", "success")
        return redirect(url_for('admin_dashboard'))  

    return render_template('edit_promo_banner.html', banner=banner)


@app.route('/admin/delete-promo/<int:banner_id>')
def delete_promo_banner(banner_id):
    banner = PromoBanner.query.get_or_404(banner_id)
    db.session.delete(banner)
    db.session.commit()
    flash("🗑️ Promo banner deleted!", "success")
    return redirect(url_for('admin_dashboard'))


# --------------------------
# 🖼 Hero & Background Images (Cloudinary)
# --------------------------

@app.route('/admin/delete_hero_banner', methods=['POST'])
def delete_hero_banner():
    setting = Setting.query.first()
    if setting and setting.hero_banner:
        # ✅ Just clear Cloudinary URL from DB
        setting.hero_banner = None
        db.session.commit()
        flash("🗑️ Hero banner deleted.", "success")
    return redirect(url_for('admin_settings'))


@app.route('/admin/delete_background_image', methods=['POST'])
def delete_background_image():
    setting = Setting.query.first()
    if setting and setting.background_image:
        # ✅ Just clear Cloudinary URL from DB
        setting.background_image = None
        db.session.commit()
        flash("🗑️ Background image deleted.", "success")
    return redirect(url_for('admin_settings'))

from flask import Flask, render_template, request, redirect, url_for, flash
from werkzeug.utils import secure_filename
import cloudinary.uploader

@app.route('/admin/settings', methods=['GET', 'POST'])
def admin_settings():
    setting = Setting.query.first()

    # ✅ Create a setting row if none exists
    if not setting:
        setting = Setting()
        db.session.add(setting)
        db.session.commit()

    if request.method == 'POST':
        # ✅ Update line banner text
        line_banner_text = request.form.get('line_banner_text')
        if line_banner_text:
            setting.line_banner_text = line_banner_text

        # ✅ Handle Hero Banner Upload (Cloudinary)
        if 'hero_banner' in request.files:
            file = request.files['hero_banner']
            if file and file.filename.strip():
                upload_result = cloudinary.uploader.upload(
                    file,
                    folder="bin_ahmed/banners",
                    resource_type="image"
                )
                setting.hero_banner = upload_result.get("secure_url")
                flash("✅ Hero banner updated!", "success")

        # ✅ Handle Background Image Upload (Cloudinary)
        if 'background_image' in request.files:
            bg_file = request.files['background_image']
            if bg_file and bg_file.filename.strip():
                upload_result = cloudinary.uploader.upload(
                    bg_file,
                    folder="bin_ahmed/backgrounds",
                    resource_type="image"
                )
                setting.background_image = upload_result.get("secure_url")
                flash("✅ Background image updated!", "success")

        # ✅ Handle About Page Picture Upload (Cloudinary)
        if 'about_image' in request.files:
            about_file = request.files['about_image']
            if about_file and about_file.filename.strip():
                upload_result = cloudinary.uploader.upload(
                    about_file,
                    folder="bin_ahmed/about",
                    resource_type="image"
                )
                setting.about_image = upload_result.get("secure_url")
                flash("✅ About page image updated!", "success")

        # ✅ Handle "Know Your Perfume" Image Upload (Cloudinary)
        if 'perfume_image' in request.files:
            perfume_img = request.files['perfume_image']
            if perfume_img and perfume_img.filename.strip():
                upload_result = cloudinary.uploader.upload(
                    perfume_img,
                    folder="bin_ahmed/know_your_perfume",
                    resource_type="image"
                )
                setting.perfume_image = upload_result.get("secure_url")
                flash("✅ Perfume info image updated!", "success")

        # ✅ Handle "Know Your Perfume" Video Upload (Cloudinary)
        if 'perfume_video' in request.files:
            perfume_vid = request.files['perfume_video']
            if perfume_vid and perfume_vid.filename.strip():
                upload_result = cloudinary.uploader.upload(
                    perfume_vid,
                    folder="bin_ahmed/know_your_perfume",
                    resource_type="video"
                )
                setting.perfume_video = upload_result.get("secure_url")
                flash("🎥 Perfume info video uploaded!", "success")

        # ✅ Save all updates
        db.session.commit()
        flash("✅ Settings updated successfully!", "success")
        return redirect(url_for('admin_settings'))

    return render_template('admin_settings.html', setting=setting)

@app.route('/product/<int:product_id>')
def product_detail(product_id):
    # 🔎 Get product or return 404
    product = Product.query.get_or_404(product_id)

    # ⚙️ Load site settings (if available)
    setting = Setting.query.first()

    # 🖼️ Load gallery images (keep order)
    product_images = ProductImage.query.filter_by(product_id=product.id).order_by(ProductImage.id.asc()).all()

    # 💬 Load product reviews (latest first)
    reviews = Review.query.filter_by(product_id=product.id).order_by(Review.created_at.desc()).all()

    return render_template(
        "product_detail.html",
        product=product,
        product_images=product_images,
        reviews=reviews,
        setting=setting
    )

@app.route('/delete_order/<int:order_id>', methods=['POST'])
def delete_order(order_id):
    order = Order.query.get_or_404(order_id)
    db.session.delete(order)
    db.session.commit()
    flash("🗑️ Order deleted successfully!", "success")
    return redirect(url_for('admin_dashboard'))

import cloudinary.uploader

@app.route('/admin/update-site-info', methods=['POST'])
def update_site_info():
    setting = Setting.query.first()
    if not setting:
        setting = Setting()

    # 📛 Website name
    setting.website_name = request.form.get('website_name')

    # ✅ Timer enabled toggle
    setting.timer_enabled = 'timer_enabled' in request.form

    # 📝 Coming Soon Message
    setting.coming_soon_message = request.form.get('coming_soon_message')

    # 🖼️ Logo upload (Cloudinary instead of static/uploads)
    if 'logo' in request.files:
        logo_file = request.files['logo']
        if logo_file and logo_file.filename != '':
            try:
                upload_result = cloudinary.uploader.upload(
                    logo_file,
                    folder="site_assets",  # optional folder in your Cloudinary account
                    resource_type="image"
                )
                # store secure Cloudinary URL instead of local filename
                setting.logo = upload_result.get("secure_url")
            except Exception as e:
                flash(f"❌ Logo upload failed: {str(e)}", "danger")

    # 🕒 Timer: Product visibility window
    start_time_str = request.form.get('product_visibility_start')
    end_time_str = request.form.get('product_visibility_end')

    from datetime import datetime
    if start_time_str:
        try:
            setting.product_visibility_start = datetime.strptime(start_time_str, '%Y-%m-%dT%H:%M')
        except ValueError:
            flash("⚠️ Invalid start time format.", "warning")

    if end_time_str:
        try:
            setting.product_visibility_end = datetime.strptime(end_time_str, '%Y-%m-%dT%H:%M')
        except ValueError:
            flash("⚠️ Invalid end time format.", "warning")

    db.session.add(setting)
    db.session.commit()
    flash("✅ Site info updated!", "success")
    return redirect(url_for('admin_dashboard'))

import cloudinary.uploader

@app.route('/upload-hero-banner', methods=['POST'])
def upload_hero_banner():
    if 'hero_banner' not in request.files:
        flash('⚠️ No file part in the form.', 'warning')
        return redirect(url_for('admin_dashboard'))

    file = request.files['hero_banner']
    if file.filename == '':
        flash('⚠️ No selected file.', 'warning')
        return redirect(url_for('admin_dashboard'))

    if file:
        # 🚀 Upload directly to Cloudinary
        upload_result = cloudinary.uploader.upload(
            file,
            folder="hero_banners",  # optional: organize files
            resource_type="image"
        )

        # ✅ Get secure Cloudinary URL
        image_url = upload_result.get("secure_url")

        # Save to DB
        setting = Setting.query.first()
        if not setting:
            setting = Setting()
            db.session.add(setting)

        setting.hero_banner = image_url  # store Cloudinary URL instead of filename
        db.session.commit()

        flash('✅ Hero banner uploaded successfully!', 'success')
        return redirect(url_for('admin_dashboard'))
    
@app.route('/make_products_visible', methods=['POST'])
def make_products_visible():
    setting = Setting.query.first()
    if setting:
        setting.timer_enabled = False
        db.session.commit()
    return '', 204  # No Content    
    
import cloudinary.uploader

# ➕ Add Category
@app.route('/add-category', methods=['POST'])
def add_category():
    name = request.form['category_name'].strip().lower()
    image_file = request.files.get('image')

    # ✅ Check if category name already exists (case-insensitive)
    existing_cat = Category.query.filter(db.func.lower(Category.name) == name).first()
    if existing_cat:
        flash('⚠️ Category already exists.', 'warning')
        return redirect(url_for('admin_dashboard'))

    image_url = None
    if image_file and image_file.filename.strip() != "":
        # 🚀 Upload to Cloudinary
        result = cloudinary.uploader.upload(image_file, folder="categories")
        image_url = result.get("secure_url")

    # ✅ Save new category
    new_cat = Category(name=name, image=image_url)
    db.session.add(new_cat)
    db.session.commit()
    flash('✅ Category added', 'success')
    return redirect(url_for('admin_dashboard'))


# 🗑️ Delete Category
@app.route('/delete_category/<int:category_id>')
def delete_category(category_id):
    category = Category.query.get_or_404(category_id)
    if category.products:
        flash("⚠️ Cannot delete category with products!", "warning")
        return redirect(url_for('admin_dashboard'))

    db.session.delete(category)
    db.session.commit()
    flash("🗑️ Category deleted!", "success")
    return redirect(url_for('admin_dashboard'))

# 🛍️ View Products by Category
@app.route('/category/<int:category_id>')
def filter_category(category_id):
    category = Category.query.get_or_404(category_id)
    products = Product.query.filter_by(category_id=category_id).all()
    categories = Category.query.all()
    
    return render_template(
        'index.html',   # or 'category_products.html' if you have a separate template
        products=products,
        categories=categories,
        selected_category=category
    )

# ✏️ Edit Category
@app.route('/edit_category/<int:category_id>', methods=['POST'])
def edit_category(category_id):
    category = Category.query.get_or_404(category_id)

    # ✅ Update name
    new_name = request.form.get('name', '').strip()
    if new_name:
        category.name = new_name

    # ✅ Handle image update
    image_file = request.files.get('image')
    if image_file and image_file.filename.strip() != "":
        # 🚀 Upload to Cloudinary
        result = cloudinary.uploader.upload(image_file, folder="categories")
        image_url = result.get("secure_url")
        category.image = image_url  # Replace old image with Cloudinary URL

    db.session.commit()
    flash("✅ Category updated!", "success")
    return redirect(url_for('admin_dashboard'))

import cloudinary.uploader

# 🗑️ Delete Product
@app.route('/delete_product/<int:product_id>')
def delete_product(product_id):
    product = Product.query.get_or_404(product_id)
    try:
        # 🚀 If image exists, delete from Cloudinary
        if product.image:
            try:
                public_id = product.image.split("/")[-1].split(".")[0]  # crude way
                cloudinary.uploader.destroy(public_id)
            except Exception:
                pass

        # 🚀 Also delete gallery images
        for gimg in product.images:
            if gimg.filename:
                try:
                    public_id = gimg.filename.split("/")[-1].split(".")[0]
                    cloudinary.uploader.destroy(public_id)
                except Exception:
                    pass
            db.session.delete(gimg)

        db.session.delete(product)
        db.session.commit()
        flash("🗑️ Product deleted!", "success")
    except Exception as e:
        flash(f"❌ Failed to delete product. {str(e)}", "danger")
    return redirect(url_for('admin_dashboard'))


# ✏️ Edit Product
@app.route('/edit_product/<int:product_id>', methods=['POST'])
def edit_product(product_id):
    product = Product.query.get_or_404(product_id)

    # ✅ Update basic fields
    product.name = request.form.get('name', product.name)

    today_price = float(request.form.get('today_price') or product.today_price or 0)
    before_price = float(request.form.get('before_price') or product.before_price or 0)
    product.today_price = today_price
    product.before_price = before_price
    product.price = today_price
    product.description = request.form.get('description', product.description)
    product.category_id = request.form.get('category_id', product.category_id)

    # ✅ Main image upload to Cloudinary
    image_file = request.files.get('image')
    if image_file and image_file.filename:
        try:
            # Delete old image from Cloudinary
            if product.image:
                public_id = product.image.split("/")[-1].split(".")[0]
                cloudinary.uploader.destroy(public_id)
        except Exception as e:
            print(f"❌ Failed to delete old image: {e}")

        result = cloudinary.uploader.upload(image_file, folder="products", resource_type="image")
        product.image = result.get("secure_url")

    # 🎥 Optional: Product video upload to Cloudinary
    video_file = request.files.get('video')
    if video_file and video_file.filename:
        try:
            # Delete old video from Cloudinary (if any)
            if product.video_url:
                try:
                    public_id = product.video_url.split("/")[-1].split(".")[0]
                    cloudinary.uploader.destroy(public_id, resource_type="video")
                except Exception as e:
                    print(f"❌ Failed to delete old video: {e}")

            v_result = cloudinary.uploader.upload(
                video_file,
                folder="products/videos",
                resource_type="video"
            )
            product.video_url = v_result.get("secure_url")
        except Exception as e:
            print(f"❌ Video upload failed: {e}")
            flash("⚠️ Video upload failed. Please try again.", "warning")

    # ✅ Gallery images
    gallery_files = request.files.getlist('gallery_images')
    if gallery_files and gallery_files[0].filename:
        for gfile in gallery_files:
            try:
                result = cloudinary.uploader.upload(gfile, folder="products/gallery", resource_type="image")
                new_img = ProductImage(filename=result.get("secure_url"), product_id=product.id)
                db.session.add(new_img)
            except Exception as e:
                print(f"❌ Gallery upload failed: {e}")

    db.session.commit()
    flash("✅ Product updated successfully!", "success")
    return redirect(url_for('admin_dashboard'))

# 📦 Existing Products
@app.route('/admin/existing-products')
def existing_products():
    if not session.get('admin_logged_in'):
        flash("Unauthorized access", "danger")
        return redirect(url_for('admin_login'))

    products = Product.query.all()
    categories = Category.query.all()
    return render_template('existing_products.html', products=products, categories=categories)


# ➕ Add Product
@app.route('/admin/add-product', methods=['GET', 'POST'])
def add_product():
    categories = Category.query.all()

    if request.method == 'POST':
        name = request.form['name']
        before_price = request.form.get('before_price') or None
        today_price = request.form.get('today_price')
        description = request.form.get('description')
        category_id = request.form.get('category_id')

        # 🚨 Validate required fields
        if not name or not today_price or not category_id:
            flash("⚠️ Name, Price, and Category are required.", "warning")
            return redirect(request.url)

        # 🚀 Upload main image to Cloudinary
        image_file = request.files.get('image')
        if not image_file or image_file.filename == "":
            flash("⚠️ Main product image is required.", "warning")
            return redirect(request.url)

        result = cloudinary.uploader.upload(image_file, folder="products", resource_type="image")
        main_image_url = result.get("secure_url")

        # 🎥 Optional: Upload video to Cloudinary
        video_file = request.files.get('video')
        video_url = None
        if video_file and video_file.filename != "":
            try:
                v_result = cloudinary.uploader.upload(
                    video_file,
                    folder="products/videos",
                    resource_type="video"  # 👈 important for video
                )
                video_url = v_result.get("secure_url")
            except Exception as e:
                print(f"❌ Video upload failed: {e}")
                flash("⚠️ Video upload failed. Please try again.", "warning")

        # 🛍 Save Product
        product = Product(
            name=name,
            before_price=float(before_price) if before_price else None,
            today_price=float(today_price),
            price=float(today_price),   # keep consistent
            description=description,
            category_id=int(category_id),
            image=main_image_url,
            video_url=video_url   # ✅ save video if uploaded
        )
        db.session.add(product)
        db.session.commit()

        # 🚀 Handle gallery images
        gallery_files = request.files.getlist('gallery_images')
        if gallery_files and gallery_files[0].filename != "":
            for gfile in gallery_files:
                try:
                    g_result = cloudinary.uploader.upload(
                        gfile,
                        folder="products/gallery",
                        resource_type="image"
                    )
                    db.session.add(ProductImage(product_id=product.id, filename=g_result.get("secure_url")))
                except Exception as e:
                    print(f"❌ Gallery upload failed: {e}")

        db.session.commit()

        flash("✅ Product added successfully!", "success")
        return redirect(url_for('admin_dashboard'))

    return render_template('add_product.html', categories=categories)

@app.route('/delete_gallery_image/<int:image_id>')
def delete_gallery_image(image_id):
    img = ProductImage.query.get_or_404(image_id)
    try:
        # 🚀 Delete from Cloudinary if file exists
        if img.filename:
            try:
                public_id = img.filename.split("/")[-1].split(".")[0]
                cloudinary.uploader.destroy(public_id, resource_type="image")
            except Exception as e:
                print(f"❌ Failed to delete gallery image from Cloudinary: {e}")

        # 🚀 Remove from database
        db.session.delete(img)
        db.session.commit()
        flash("🗑️ Gallery image deleted!", "success")
    except Exception as e:
        flash(f"❌ Failed to delete gallery image. {str(e)}", "danger")

    return redirect(url_for('existing_products'))

# -------------------------------
# ➕ Add to Cart
# -------------------------------
@app.route('/add_to_cart/<int:product_id>', methods=['POST'])
def add_to_cart(product_id):
    product = Product.query.get_or_404(product_id)
    lens_id = request.form.get('lens_category_id') or 'none'

    # ✅ Use composite key if lenses are selected
    cart = session.get('cart', {})
    cart_key = f"{product_id}-{lens_id}"

    # ✅ Add or increment quantity
    cart[cart_key] = cart.get(cart_key, 0) + 1
    session['cart'] = cart

    flash(f"✅ {product.name} added to cart.", "success")
    return redirect(url_for('cart'))

# -------------------------------
# 🛒 View Cart
# -------------------------------
@app.route('/cart')
def cart():
    cart = session.get('cart', {})
    items = []
    total = Decimal('0.00')

    for key, qty in cart.items():
        try:
            product_id = int(key.split('-')[0])  # handle lens composite keys
            product = Product.query.get(product_id)

            if product:
                # ✅ Prefer today_price, fallback to price
                product_price = Decimal(str(product.today_price or product.price))
                subtotal = product_price * qty

                items.append({
                    'key': key,
                    'product': product,
                    'qty': qty,
                    'subtotal': subtotal
                })
                total += subtotal
        except Exception as e:
            print(f"Cart item error: {e}")
            continue

    # ✅ Fetch delivery settings
    setting = Setting.query.first()
    delivery_fee = Decimal(str(setting.delivery_fee)) if setting and setting.delivery_fee else Decimal("0.00")
    free_delivery_threshold = Decimal(str(setting.free_delivery_threshold)) if setting and setting.free_delivery_threshold else Decimal("0.00")

    # ✅ Apply free delivery rule
    if total >= free_delivery_threshold:
        delivery_fee = Decimal("0.00")

    grand_total = total + delivery_fee

    return render_template(
        'cart.html',
        products=items,
        delivery_fee=delivery_fee,
        total=total,
        grand_total=grand_total,
        setting=setting
    )

# -------------------------------
# 🗑️ Remove Item from Cart
# -------------------------------
@app.route('/remove_from_cart/<cart_key>', methods=['POST', 'GET'])
def remove_from_cart(cart_key):
    cart = session.get('cart', {})

    if cart_key in cart:
        cart.pop(cart_key)
        if cart:
            session['cart'] = cart
        else:
            session.pop('cart', None)

        flash("🗑️ Product removed from cart.", "info")
    else:
        flash("⚠️ Item not found in cart.", "warning")

    return redirect(request.referrer or url_for('cart'))

# -------------------------------
# ✏️ Update Quantity
# -------------------------------
@app.route('/update_cart', methods=['POST'])
def update_cart():
    if 'cart' not in session or not session['cart']:
        flash("⚠️ Your cart is empty.", "warning")
        return redirect(url_for('cart'))

    updated_cart = {}

    for key, qty in request.form.items():
        try:
            qty = int(qty)
            if qty > 0:
                updated_cart[key] = qty  # ✅ update qty
        except ValueError:
            continue  # ignore invalid qty inputs

    session['cart'] = updated_cart

    if not session['cart']:
        flash("🛒 Your cart is now empty.", "info")
    else:
        flash("✅ Cart updated!", "success")

    return redirect(url_for('cart'))

# --------------------------
# CHECKOUT ROUTES
# -------------------------

from decimal import Decimal
from werkzeug.utils import secure_filename
import cloudinary.uploader
import random, string
from datetime import datetime
import sendgrid
from sendgrid.helpers.mail import Mail
import os

# ✅ Setup SendGrid client
SENDGRID_API_KEY = os.getenv("SENDGRID_API_KEY")
sg = sendgrid.SendGridAPIClient(api_key=SENDGRID_API_KEY)

# 🔹 Utility to generate tracking numbers
def generate_tracking_number():
    return datetime.utcnow().strftime("%Y%m%d") + "-" + ''.join(random.choices(string.digits, k=5))

# 🔹 Utility: Send Email via SendGrid
def send_email(to_email, subject, html_content):
    message = Mail(
        from_email="no-reply@bin-ahmed.store",  # ⚠️ must be verified in SendGrid
        to_emails=to_email,
        subject=subject,
        html_content=html_content
    )
    try:
        response = sg.send(message)
        print("✅ Email sent:", response.status_code)
        return True
    except Exception as e:
        print(f"❌ SendGrid error: {e}")
        return False

from decimal import Decimal
from flask import jsonify

@app.route('/checkout', methods=['GET', 'POST'])
def checkout():
    cart = session.get('cart', {})
    if not cart:
        flash("⚠️ Your cart is empty!", "warning")
        return redirect(url_for('index'))

    products = []
    product_total = Decimal('0.00')

    # 🔹 Calculate product subtotal
    for key, qty in cart.items():
        try:
            product_id = int(key.split('-')[0])  # supports lens_id
            product = Product.query.get(product_id)

            if product:
                price = Decimal(str(product.today_price or product.price))
                subtotal = price * qty
                products.append({'product': product, 'qty': qty, 'subtotal': subtotal})
                product_total += subtotal
        except Exception as e:
            print(f"Checkout cart error: {e}")
            continue

    # 🔹 Delivery fee logic
    setting = Setting.query.first()
    delivery_fee = Decimal(str(setting.delivery_fee)) if setting and setting.delivery_fee else Decimal('0.00')
    free_threshold = Decimal(str(setting.free_delivery_threshold)) if setting and setting.free_delivery_threshold else Decimal('0.00')
    if product_total >= free_threshold:
        delivery_fee = Decimal('0.00')

    discount_amount = Decimal('0.00')
    applied_coupon = None

    # 🔹 Coupon check (from POST or Session)
    if request.method == 'POST' and 'apply_coupon' in request.form:
        coupon_code = request.form.get('coupon_code', '').upper().strip()
        coupon = Coupon.query.filter_by(code=coupon_code, is_active=True).first()

        if coupon:
            session['coupon_code'] = coupon.code
            flash(f"🎟️ Coupon '{coupon.code}' applied successfully!", "success")
        else:
            session.pop('coupon_code', None)
            flash("❌ Invalid or expired coupon code.", "danger")

        return redirect(url_for('checkout'))

    # 🔹 If coupon exists in session, apply it
    if 'coupon_code' in session:
        coupon = Coupon.query.filter_by(code=session['coupon_code'], is_active=True).first()
        if coupon:
            applied_coupon = coupon.code
            if coupon.discount_type == 'percent':
                discount_amount = (product_total * Decimal(str(coupon.discount_value))) / 100
            else:
                discount_amount = Decimal(str(coupon.discount_value))

    # 🔹 Calculate grand total after discount
    grand_total = (product_total + delivery_fee) - discount_amount
    if grand_total < 0:
        grand_total = Decimal('0.00')

    # 🔹 Final checkout submission (placing order)
    if request.method == 'POST' and 'place_order' in request.form:
        name = request.form['name']
        customer_email = request.form['email']
        phone = request.form['phone']
        address = request.form['address']

        tracking_number = generate_tracking_number()

        order = Order(
            name=name,
            phone=phone,
            email=customer_email,
            address=address,
            product_total=float(product_total),
            delivery_fee=float(delivery_fee),
            total=float(grand_total),
            tracking_number=tracking_number,
            status="Pending",
            coupon_code=applied_coupon,
            discount=float(discount_amount)
        )
        db.session.add(order)
        db.session.flush()

        # 🧾 Save order items
        for item in products:
            db.session.add(OrderItem(
                product_name=item['product'].name,
                price=float(item['product'].today_price or item['product'].price),
                product_image=item['product'].image or "https://via.placeholder.com/100",
                quantity=item['qty'],
                order_id=order.id
            ))

        db.session.commit()
        session.pop('cart', None)
        session.pop('coupon_code', None)

        # ✅ Prepare logo URL
        logo_url = None
        if setting and setting.logo:
            logo_url = setting.logo if setting.logo.startswith("http") else url_for('static', filename='uploads/' + setting.logo, _external=True)

        # ✅ Send confirmation emails
        try:
            customer_html = render_template(
                'emails/customer_confirmation.html',
                customer_name=name,
                order_items=products,
                total_amount=grand_total,
                delivery_fee=delivery_fee,
                discount=discount_amount,
                product_total=product_total,
                setting=setting,
                tracking_number=tracking_number,
                coupon_code=applied_coupon,
                logo_url=logo_url
            )
            send_email(
                to_email=customer_email,
                subject=f"🛍️ Your Order Confirmation - {setting.website_name if setting else 'Bin Ahmed'}",
                html_content=customer_html
            )

            admin_html = render_template(
                'emails/admin_notification.html',
                customer_name=name,
                customer_email=customer_email,
                phone=phone,
                address=address,
                order_items=products,
                total_amount=grand_total,
                delivery_fee=delivery_fee,
                discount=discount_amount,
                product_total=product_total,
                setting=setting,
                tracking_number=tracking_number,
                coupon_code=applied_coupon,
                logo_url=logo_url
            )
            send_email(
                to_email="BinAhmedandco@gmail.com",
                subject=f"📦 New Order from {name}",
                html_content=admin_html
            )
        except Exception as e:
            print(f"❌ Email Error: {e}")

        flash(f"🎉 Order placed successfully! Your tracking number is {tracking_number}", "success")
        return redirect(url_for('track_order'))

    # 🧮 Render checkout page
    return render_template(
        'checkout.html',
        products=products,
        total=product_total,
        grand_total=grand_total,
        delivery_fee=delivery_fee,
        discount=discount_amount,
        applied_coupon=applied_coupon,
        setting=setting
    )

from decimal import Decimal

@app.route("/buy-now/<int:product_id>", methods=["POST"])
def buy_now(product_id):
    """Direct-buy: instantly opens checkout for one product only."""
    product = Product.query.get_or_404(product_id)

    # 🔒 Prevent checkout for sold-out items
    if getattr(product, "is_soldout", False):
        flash("This product is currently sold out.", "warning")
        return redirect(url_for("product_detail", product_id=product.id))

    # 🛒 Build a temporary one-item cart inside session
    session["cart"] = {
        f"{product.id}-0": 1   # format matches your checkout parser (product_id + lens_id)
    }

    # 🧮 (Optional) store the product’s latest price
    session["instant_price"] = str(product.today_price or product.price)

    # 🚀 Go straight to checkout
    return redirect(url_for("checkout"))

@app.route('/admin/manage-categories', methods=['GET', 'POST'])
def manage_categories():
    if not session.get('admin_logged_in'):  # ✅ Ensure admin is logged in
        flash("Unauthorized access", "danger")
        return redirect(url_for('admin_login'))

    categories = Category.query.all()
    return render_template('manage_categories.html', categories=categories)

@app.route('/update_delivery_settings', methods=['POST'])
def update_delivery_settings():
    delivery_fee = request.form.get('delivery_fee', type=float)
    free_delivery_threshold = request.form.get('free_delivery_threshold', type=float)

    setting = Setting.query.first()
    if not setting:
        setting = Setting()

    setting.delivery_fee = delivery_fee
    setting.free_delivery_threshold = free_delivery_threshold

    db.session.add(setting)
    db.session.commit()

    flash("🚚 Delivery settings updated successfully!", "success")
    return redirect(url_for('admin_dashboard'))

@app.route('/admin/update_order_status/<int:order_id>', methods=['POST'])
def update_order_status(order_id):
    order = Order.query.get_or_404(order_id)
    new_status = request.form.get('status')
    if new_status in ['Pending', 'Cancelled', 'Delivered', 'Processing', 'Shipped']:
        order.status = new_status
        db.session.commit()
        flash(f"✅ Order status updated to {new_status}", "success")
    return redirect(url_for('admin_dashboard'))

@app.before_request
def assign_chat_session():
    if 'chat_id' not in session:
        import uuid
        session['chat_id'] = str(uuid.uuid4())  # Persistent per-user ID

from flask import request, jsonify

# 📩 Get all optician messages for frontend chat box
@app.route('/optician/messages')
def get_optician_messages():
    chat_id = session.get('chat_id')
    msgs = OpticianMessage.query.filter_by(sender_id=chat_id).order_by(OpticianMessage.timestamp.asc()).all()
    return jsonify([{
        'role': m.role,
        'message': m.message,
        'timestamp': m.timestamp.strftime('%d %b %I:%M %p')
    } for m in msgs])

# ✉️ User sends a message to the optician
@app.route('/optician/send', methods=['POST'])
def send_optician_message():
    data = request.get_json()
    chat_id = session.get('chat_id')

    # Fallback protection
    if not chat_id:
        import uuid
        chat_id = str(uuid.uuid4())
        session['chat_id'] = chat_id

    # Check if name was already saved
    name_already_saved = db.session.query(OpticianMessage.sender_name)\
        .filter(OpticianMessage.sender_id == chat_id, OpticianMessage.sender_name.isnot(None))\
        .first()

    # Save the name only once per user
    sender_name = data.get('name') if not name_already_saved else None

    msg = OpticianMessage(
        sender_id=chat_id,
        sender_name=sender_name,
        role='user',
        message=data['message']
    )
    db.session.add(msg)
    db.session.commit()
    return '', 204

@app.route('/admin/optician-inbox')
def admin_optician_inbox():
    users = db.session.query(
        OpticianMessage.sender_id,
        db.func.max(OpticianMessage.timestamp).label('last_msg_time')
    ).group_by(OpticianMessage.sender_id).order_by(db.desc('last_msg_time')).all()

    messages_by_user = {}
    for u in users:
        # ✅ Get the latest message for timestamp & preview
        latest_msg = OpticianMessage.query.filter_by(sender_id=u.sender_id).order_by(OpticianMessage.timestamp.desc()).first()

        # ✅ Get the first message that has a sender_name (not null)
        name_msg = OpticianMessage.query.filter(
            OpticianMessage.sender_id == u.sender_id,
            OpticianMessage.sender_name.isnot(None)
        ).order_by(OpticianMessage.id.asc()).first()

        # ✅ Attach the name to latest_msg (for display in inbox)
        if name_msg:
            latest_msg.sender_name = name_msg.sender_name

        messages_by_user[u.sender_id] = latest_msg

    return render_template('admin_optician_inbox.html', users=users, messages_by_user=messages_by_user)

# 🧑‍⚕️ Admin/Optician sees chat and unread count
@app.route('/admin/optician-chat/<sender_id>')
def admin_optician_chat(sender_id):
    messages = OpticianMessage.query.filter_by(sender_id=sender_id).order_by(OpticianMessage.timestamp.asc()).all()

    # ✅ Mark user messages as seen
    for msg in messages:
        if msg.role == 'user' and not msg.seen:
            msg.seen = True
    db.session.commit()

    # ✅ Get the first message that contains a sender_name
    name_msg = OpticianMessage.query.filter(
        OpticianMessage.sender_id == sender_id,
        OpticianMessage.sender_name.isnot(None)
    ).order_by(OpticianMessage.id.asc()).first()

    user_name = name_msg.sender_name if name_msg else None

    return render_template('admin_optician_chat.html', messages=messages, sender_id=sender_id, user_name=user_name)

# 🧑‍⚕️ Admin replies to user
@app.route('/optician/reply/<sender_id>', methods=['POST'])
def reply_as_admin(sender_id):
    data = request.get_json()
    msg = OpticianMessage(
        sender_id=sender_id,
        role='admin',
        message=data['message']
    )
    db.session.add(msg)
    db.session.commit()
    return '', 204

@app.route('/admin/orders', methods=["GET", "POST"])
def admin_orders():
    # 🛡️ Verify admin session
    if not session.get('admin_logged_in'):
        flash("Unauthorized access", "danger")
        return redirect(url_for('admin_login'))

    # ⚙️ POST: Update order status
    if request.method == "POST":
        order_id = request.form.get("order_id")
        new_status = request.form.get("status", "").strip().lower()

        if order_id and new_status:
            order = Order.query.get(order_id)
            if order:
                old_status = order.status
                order.status = new_status.capitalize()
                db.session.commit()

                flash(f"✅ Order #{order.id} status updated to {order.status}", "success")

                # 🧩 Email notification setup
                try:
                    setting = Setting.query.first()
                    logo_url = (
                        setting.logo if setting and setting.logo and setting.logo.startswith("http")
                        else url_for('static', filename=f"uploads/{setting.logo}", _external=True)
                        if setting and setting.logo else None
                    )

                    if getattr(order, "email", None):
                        email = order.email.strip()
                        print(f"📧 Triggering status '{new_status}' email for {email}")

                        # 🚚 Shipped email
                        if new_status == "shipped":
                            subject = f"📦 Your Order #{order.tracking_number or order.id} Has Been Shipped!"
                            html_content = render_template(
                                "emails/order_shipped.html",
                                order=order,
                                setting=setting,
                                logo_url=logo_url,
                            )
                            send_email(email, subject, html_content)
                            print(f"✅ Shipped email sent to {email}")

                        # ✅ Delivered email
                        elif new_status == "delivered":
                            subject = f"✅ Your Order #{order.tracking_number or order.id} Has Been Delivered!"
                            html_content = render_template(
                                "emails/order_delivered.html",
                                order=order,
                                setting=setting,
                                logo_url=logo_url,
                            )
                            send_email(email, subject, html_content)
                            print(f"✅ Delivered email sent to {email}")

                        else:
                            print(f"ℹ️ No email needed for status '{new_status}'")

                    else:
                        print(f"⚠️ Order #{order.id} has no email field")

                except Exception as e:
                    print(f"❌ Email sending error for order #{order.id}: {e}")

        return redirect(url_for("admin_orders"))

    # 🧾 GET: Show all orders
    orders = Order.query.order_by(Order.created_at.desc()).all()
    return render_template("admin_orders.html", orders=orders)

@app.before_request
def check_maintenance_mode():
    if request.path.startswith("/admin"):  
        return  # ✅ Allow admin access even during maintenance
    
    setting = Setting.query.first()
    if setting and setting.maintenance_mode:
        return render_template("maintenance.html", message=setting.maintenance_message), 503

@app.route('/admin/toggle-maintenance', methods=['POST'])
def toggle_maintenance():
    # 🔑 Password check
    password = request.form.get('password', '').strip()
    if password != "591200":
        flash("❌ Invalid password! You are not allowed to toggle maintenance mode.", "danger")
        return redirect(url_for('admin_settings'))

    setting = Setting.query.first()
    if not setting:
        setting = Setting()
        db.session.add(setting)

    setting.maintenance_mode = 'maintenance_mode' in request.form
    setting.maintenance_message = request.form.get('maintenance_message', setting.maintenance_message)
    db.session.commit()
    flash("🛠 Maintenance mode updated!", "success")
    return redirect(url_for('admin_settings'))

# =========================
# ⭐ Add Product Review
# =========================
@app.route('/product/<int:product_id>/add_review', methods=['POST'])
def add_review(product_id):
    product = Product.query.get_or_404(product_id)

    rating = int(request.form.get('rating', 0))
    comment = request.form.get('comment', '').strip()  # ✅ match template field name
    user_name = request.form.get('user_name', '').strip() or "Anonymous"

    if rating < 1 or rating > 5:
        flash("⚠️ Please select a rating between 1 and 5 stars.", "danger")
        return redirect(url_for('product_detail', product_id=product_id))

    new_review = Review(
        product_id=product.id,
        rating=rating,
        comment=comment,
        user_name=user_name,
        created_at=datetime.utcnow()
    )

    db.session.add(new_review)
    db.session.commit()

    flash("✅ Thank you for your review!", "success")
    return redirect(url_for('product_detail', product_id=product_id))

@app.route('/reviews')
def all_reviews():
    reviews = Review.query.order_by(Review.created_at.desc()).all()
    return render_template("all_reviews.html", reviews=reviews)

@app.route('/apply_coupon/<code>')
def apply_coupon_ajax(code):
    from decimal import Decimal
    cart = session.get('cart', {})
    product_total = Decimal('0.00')

    for key, qty in cart.items():
        product = Product.query.get(int(key.split('-')[0]))
        if product:
            product_total += Decimal(str(product.today_price or product.price)) * qty

    coupon = Coupon.query.filter_by(code=code.upper(), is_active=True).first()
    if not coupon:
        return jsonify({'valid': False})

    if coupon.discount_type == 'percent':
        discount = (product_total * Decimal(str(coupon.discount_value))) / 100
    else:
        discount = Decimal(str(coupon.discount_value))

    new_total = product_total - discount
    session['coupon_code'] = coupon.code
    session['discount'] = float(discount)
    return jsonify({'valid': True, 'code': coupon.code, 'discount': float(discount), 'new_total': float(new_total)})


@app.route('/remove_coupon')
def remove_coupon_ajax():
    session.pop('coupon_code', None)
    session.pop('discount', None)

    cart = session.get('cart', {})
    from decimal import Decimal
    product_total = Decimal('0.00')

    for key, qty in cart.items():
        product = Product.query.get(int(key.split('-')[0]))
        if product:
            product_total += Decimal(str(product.today_price or product.price)) * qty

    return jsonify({'removed': True, 'new_total': float(product_total)})

@app.route('/about')
def about():
    setting = Setting.query.first()  # fetch logo, about_image, website_name, etc.
    return render_template('about.html', setting=setting)

@app.route('/delete_about_image', methods=['POST'])
def delete_about_image():
    setting = Setting.query.first()
    if setting and setting.about_image:
        # Delete from Cloudinary if desired
        try:
            public_id = setting.about_image.split('/')[-1].split('.')[0]
            cloudinary.uploader.destroy(f"bin_ahmed/about/{public_id}")
        except Exception as e:
            print("Cloudinary deletion skipped:", e)

        setting.about_image = None
        db.session.commit()
        flash("🗑️ About page image removed successfully!", "success")
    else:
        flash("⚠️ No About Page Image found to delete.", "warning")

    return redirect(url_for('admin_settings'))

@app.route('/admin/coupons', methods=['GET', 'POST'])
def admin_coupons():
    coupons = Coupon.query.order_by(Coupon.id.desc()).all()

    # 🧾 Add New Coupon
    if request.method == 'POST' and 'add_coupon' in request.form:
        code = request.form.get('code').strip().upper()
        discount_type = request.form.get('discount_type')
        discount_value = float(request.form.get('discount_value', 0))
        is_active = 'is_active' in request.form

        new_coupon = Coupon(
            code=code,
            discount_type=discount_type,
            discount_value=discount_value,
            is_active=is_active
        )
        db.session.add(new_coupon)
        db.session.commit()
        flash("🎟 Coupon added successfully!", "success")
        return redirect(url_for('admin_coupons'))

    # 🔄 Toggle Coupon Status
    if request.method == 'POST' and 'toggle_coupon' in request.form:
        coupon_id = request.form.get('coupon_id')
        coupon = Coupon.query.get(coupon_id)
        if coupon:
            coupon.is_active = not coupon.is_active
            db.session.commit()
            flash("🔄 Coupon status updated!", "info")
        return redirect(url_for('admin_coupons'))

    # 🗑️ Delete Coupon
    if request.method == 'POST' and 'delete_coupon' in request.form:
        coupon_id = request.form.get('coupon_id')
        coupon = Coupon.query.get(coupon_id)
        if coupon:
            db.session.delete(coupon)
            db.session.commit()
            flash("🗑️ Coupon deleted successfully!", "danger")
        return redirect(url_for('admin_coupons'))

    return render_template('admin_coupons.html', coupons=coupons)

@app.route('/know-your-perfume')
def know_your_perfume():
    setting = Setting.query.first()
    return render_template('know_your_perfume.html', setting=setting)

# ✅ Delete Perfume Image
@app.route('/delete_perfume_image', methods=['POST'])
def delete_perfume_image():
    setting = Setting.query.first()
    if setting and setting.perfume_image:
        setting.perfume_image = None
        db.session.commit()
        flash("🗑️ Perfume image deleted successfully!", "success")
    return redirect(url_for('admin_settings'))

# ✅ Delete Perfume Video
@app.route('/delete_perfume_video', methods=['POST'])
def delete_perfume_video():
    setting = Setting.query.first()
    if setting and setting.perfume_video:
        setting.perfume_video = None
        db.session.commit()
        flash("🗑️ Perfume video deleted successfully!", "success")
    return redirect(url_for('admin_settings'))

from datetime import datetime  # ⬅️ add this import at the top of app.py

@app.route('/admin/invoice/<int:order_id>')
def admin_invoice(order_id):
    order = Order.query.get_or_404(order_id)
    setting = Setting.query.first()
    return render_template('admin_invoice.html', order=order, setting=setting, datetime=datetime)

@app.route("/refund-policy")
def refund_policy():
    setting = Setting.query.first()  # if you use site settings (logo, name, etc.)
    return render_template("refund_policy.html", setting=setting)

@app.route("/social")
def social():
    return render_template("social.html", setting=Setting.query.first())

@app.route('/track_order', methods=['GET', 'POST'])
def track_order():
    order = None
    if request.method == 'POST':
        tracking_number = request.form.get('tracking_number').strip()
        order = Order.query.filter_by(tracking_number=tracking_number).first()
        if not order:
            flash("❌ Invalid tracking number.", "danger")
    
    return render_template('track_order.html', order=order)

@app.route('/admin/toggle_soldout/<int:product_id>', methods=['POST'])
def toggle_soldout(product_id):
    # 🔒 Admin authentication check
    if not session.get('admin_logged_in'):
        flash("Unauthorized access", "danger")
        return redirect(url_for('admin_login'))

    product = Product.query.get_or_404(product_id)
    product.is_soldout = not product.is_soldout  # toggle true/false
    db.session.commit()

    status = "Sold Out" if product.is_soldout else "Available"
    flash(f"Product '{product.name}' marked as {status}.", "success")
    return redirect(request.referrer or url_for('admin_dashboard'))

from datetime import datetime

@app.context_processor
def inject_now():
    return {'now': datetime.utcnow}

# --------------------------
# ✅ INIT + DB Creation
# --------------------------

from pathlib import Path
from dotenv import load_dotenv
import cloudinary
import cloudinary.uploader
import cloudinary.api

load_dotenv()

# ✅ Configure Cloudinary (from .env)
cloudinary.config(
    cloud_name=os.getenv("CLOUDINARY_CLOUD_NAME"),
    api_key=os.getenv("CLOUDINARY_API_KEY"),
    api_secret=os.getenv("CLOUDINARY_API_SECRET")
)

with app.app_context():
    try:
        db.create_all()
        print("✅ Tables checked/created.")
    except Exception as e:
        print("❌ Table creation failed:", e)

# ✅ Only run this locally (Railway uses Gunicorn)
if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8080))
    app.run(debug=True, host="0.0.0.0", port=port)