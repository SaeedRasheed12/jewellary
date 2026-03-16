--
-- PostgreSQL database dump
--

\restrict IBXD3tPtqHg72Wi04Is9AfdKuO7eoUiEIMSDShaeaXjoOL1xgiYJKz7GAtVrg5K

-- Dumped from database version 17.6 (Debian 17.6-2.pgdg13+1)
-- Dumped by pg_dump version 17.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    image character varying(255)
);


--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: coupon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    discount_type character varying(10),
    discount_value double precision NOT NULL,
    is_active boolean,
    created_at timestamp without time zone
);


--
-- Name: coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_id_seq OWNED BY public.coupon.id;


--
-- Name: inventory_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_item (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    image character varying(500),
    price double precision NOT NULL,
    notes text,
    added_on timestamp without time zone,
    stock integer,
    packaging_cost double precision,
    product_cost double precision,
    selling_cost double precision,
    supplier_name character varying(150),
    supplier_address character varying(255),
    supplier_contact character varying(50)
);


--
-- Name: inventory_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_item_id_seq OWNED BY public.inventory_item.id;


--
-- Name: optician_message; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.optician_message (
    id integer NOT NULL,
    sender_id character varying(100) NOT NULL,
    sender_name character varying(100),
    role character varying(20),
    message text NOT NULL,
    seen boolean,
    "timestamp" timestamp without time zone
);


--
-- Name: optician_message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.optician_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: optician_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.optician_message_id_seq OWNED BY public.optician_message.id;


--
-- Name: order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    email character varying(120),
    address text NOT NULL,
    product_total double precision,
    delivery_fee double precision,
    total double precision,
    coupon_code character varying(50),
    discount double precision,
    tracking_number character varying(50) NOT NULL,
    status character varying(20),
    created_at timestamp without time zone,
    city character varying(100),
    color character varying(50),
    size character varying(50)
);


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- Name: order_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_item (
    id integer NOT NULL,
    product_name character varying(120) NOT NULL,
    price double precision NOT NULL,
    quantity integer NOT NULL,
    product_image character varying(255),
    order_id integer NOT NULL,
    color character varying(50),
    size character varying(50)
);


--
-- Name: order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_item_id_seq OWNED BY public.order_item.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    price double precision NOT NULL,
    before_price double precision,
    today_price double precision,
    description text,
    image character varying(200) NOT NULL,
    category_id integer,
    video_url character varying(255),
    is_soldout boolean,
    color character varying(100),
    size character varying(100)
);


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: product_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_image (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    "order" integer,
    product_id integer
);


--
-- Name: product_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_image_id_seq OWNED BY public.product_image.id;


--
-- Name: promo_banner; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promo_banner (
    id integer NOT NULL,
    title character varying(100),
    subtitle character varying(255),
    image character varying(255),
    status character varying(10),
    created_at timestamp without time zone
);


--
-- Name: promo_banner_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.promo_banner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: promo_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.promo_banner_id_seq OWNED BY public.promo_banner.id;


--
-- Name: review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review (
    id integer NOT NULL,
    product_id integer NOT NULL,
    user_name character varying(100),
    rating integer NOT NULL,
    comment text,
    created_at timestamp without time zone
);


--
-- Name: review_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.review_id_seq OWNED BY public.review.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.setting (
    id integer NOT NULL,
    website_name character varying(100),
    logo character varying(120),
    line_banner_text character varying(255),
    background_image character varying(200),
    hero_banner character varying(255),
    about_image character varying(500),
    perfume_image character varying(500),
    perfume_video character varying(500),
    product_visibility_start timestamp without time zone,
    product_visibility_end timestamp without time zone,
    timer_enabled boolean,
    coming_soon_message text,
    free_delivery_threshold double precision,
    delivery_fee double precision,
    maintenance_mode boolean,
    maintenance_message text,
    hero_video character varying(500)
);


--
-- Name: setting_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.setting_id_seq OWNED BY public.setting.id;


--
-- Name: visit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.visit (
    id integer NOT NULL,
    ip character varying(45),
    date date,
    user_agent text,
    "timestamp" timestamp without time zone,
    device character varying(20)
);


--
-- Name: visit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.visit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.visit_id_seq OWNED BY public.visit.id;


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: coupon id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon ALTER COLUMN id SET DEFAULT nextval('public.coupon_id_seq'::regclass);


--
-- Name: inventory_item id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item ALTER COLUMN id SET DEFAULT nextval('public.inventory_item_id_seq'::regclass);


--
-- Name: optician_message id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.optician_message ALTER COLUMN id SET DEFAULT nextval('public.optician_message_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: order_item id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item ALTER COLUMN id SET DEFAULT nextval('public.order_item_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_image id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image ALTER COLUMN id SET DEFAULT nextval('public.product_image_id_seq'::regclass);


--
-- Name: promo_banner id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promo_banner ALTER COLUMN id SET DEFAULT nextval('public.promo_banner_id_seq'::regclass);


--
-- Name: review id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review ALTER COLUMN id SET DEFAULT nextval('public.review_id_seq'::regclass);


--
-- Name: setting id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting ALTER COLUMN id SET DEFAULT nextval('public.setting_id_seq'::regclass);


--
-- Name: visit id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visit ALTER COLUMN id SET DEFAULT nextval('public.visit_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alembic_version (version_num) FROM stdin;
8b5cb195ab29
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category (id, name, image) FROM stdin;
6	rings	https://res.cloudinary.com/dqsfxl599/image/upload/v1761743545/categories/dpikukcwpl2yvgfm5tz5.png
7	studs | earrings	https://res.cloudinary.com/dqsfxl599/image/upload/v1761743592/categories/aifsxhiiwek73jt78knq.png
8	pendant necklace	https://res.cloudinary.com/dqsfxl599/image/upload/v1761743649/categories/p3scewlw96ief8ucdqcr.png
9	bracelet	https://res.cloudinary.com/dqsfxl599/image/upload/v1761743679/categories/ozoztsjkwgt9l2pj2agj.png
10	jewellery set	https://res.cloudinary.com/dqsfxl599/image/upload/v1761825601/categories/vacv9t8ynio9fcdi64i2.jpg
\.


--
-- Data for Name: coupon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon (id, code, discount_type, discount_value, is_active, created_at) FROM stdin;
8	SAEED	flat	100	t	2025-10-30 23:50:30.012016
\.


--
-- Data for Name: inventory_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_item (id, name, image, price, notes, added_on, stock, packaging_cost, product_cost, selling_cost, supplier_name, supplier_address, supplier_contact) FROM stdin;
4	Gold Ring Set	https://res.cloudinary.com/dqsfxl599/image/upload/v1761752417/inventory_items/B0B802B2-5952-47E6-90CE-54A2AA578BD6.png	645.71	MP: 969/-	2025-10-29 15:40:18.131787	\N	\N	\N	\N	\N	\N	\N
5	Heart Charm Jewelry Set (Black & White)	https://res.cloudinary.com/dqsfxl599/image/upload/v1761752489/inventory_items/IMG_2150.jpg	415.71	Sp: 625/- 	2025-10-29 15:41:30.083409	\N	\N	\N	\N	\N	\N	\N
6	Stainless Golden Bracelet carlier style	https://res.cloudinary.com/dqsfxl599/image/upload/v1761752557/inventory_items/IMG_2122.jpg	365.71	Sp: 549/- 	2025-10-29 15:42:38.167246	\N	\N	\N	\N	\N	\N	\N
7	Black Flower Necklace	https://res.cloudinary.com/dqsfxl599/image/upload/v1761752620/inventory_items/IMG_2152.jpg	415.71	Sp: 625/- 	2025-10-29 15:43:40.79293	\N	\N	\N	\N	\N	\N	\N
9	Moon & Star Bracelet 	https://res.cloudinary.com/dqsfxl599/image/upload/v1761752892/inventory_items/IMG_2154.jpg	465.71	Sp: 699/-	2025-10-29 15:48:13.189916	\N	\N	\N	\N	\N	\N	\N
10	Carlier nail bracelet	https://res.cloudinary.com/dqsfxl599/image/upload/v1761752958/inventory_items/IMG_2116.jpg	385.71	Sp: 579/- 	2025-10-29 15:49:19.361646	\N	\N	\N	\N	\N	\N	\N
11	Butterfly Stud Earrings	https://res.cloudinary.com/dqsfxl599/image/upload/v1761753012/inventory_items/IMG_2138.jpg	435.71	Sp: 654/- 	2025-10-29 15:50:13.901634	\N	\N	\N	\N	\N	\N	\N
12	Starfish Stud Earrings	https://res.cloudinary.com/dqsfxl599/image/upload/v1761753067/inventory_items/IMG_2137.jpg	335	Sp: 504/-	2025-10-29 15:51:08.562035	\N	\N	\N	\N	\N	\N	\N
13	Heart necklace (golden) 	https://res.cloudinary.com/dqsfxl599/image/upload/v1761753184/inventory_items/3221EFDE-BB19-471F-8CEB-609EB54AF31C.png	335.71	Sp: 504/-	2025-10-29 15:53:05.274047	\N	\N	\N	\N	\N	\N	\N
14	Heart Earrings	https://res.cloudinary.com/dqsfxl599/image/upload/v1761753251/inventory_items/IMG_2126.jpg	435.71	Sp: 654/- 	2025-10-29 15:54:12.098649	\N	\N	\N	\N	\N	\N	\N
15	Single line heart necklace (golden)	https://res.cloudinary.com/dqsfxl599/image/upload/v1761753651/inventory_items/IMG_2134.jpg	335.71	Sp: 504/-	2025-10-29 16:00:52.32772	\N	\N	\N	\N	\N	\N	\N
16	Whole Rose Flower Necklace (Golden)	https://res.cloudinary.com/dqsfxl599/image/upload/v1761753744/inventory_items/IMG_2132.jpg	455.71	Sp: 684/-	2025-10-29 16:02:25.281377	\N	\N	\N	\N	\N	\N	\N
17	Shiny Heart Necklace	https://res.cloudinary.com/dqsfxl599/image/upload/v1761754118/inventory_items/IMG_2140.jpg	555.71	Sp: 844/-	2025-10-29 16:08:39.474549	\N	\N	\N	\N	\N	\N	\N
18	Rose Flower Necklace (silver) 	https://res.cloudinary.com/dqsfxl599/image/upload/v1761754318/inventory_items/IMG_2147.jpg	597	Sp: 594/-	2025-10-29 16:11:59.431586	2	106	290	\N	\N	\N	\N
19	Shiny Heart Necklace	https://res.cloudinary.com/dqsfxl599/image/upload/v1761754398/inventory_items/IMG_2130.jpg	489	Sp: 489/- 	2025-10-29 16:13:19.074403	2	100	220	6	\N	\N	\N
\.


--
-- Data for Name: optician_message; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.optician_message (id, sender_id, sender_name, role, message, seen, "timestamp") FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."order" (id, name, phone, email, address, product_total, delivery_fee, total, coupon_code, discount, tracking_number, status, created_at, city, color, size) FROM stdin;
10	Kamran Gul	03009342540	kamrangulkhas@gmail.com	Gulstan E Johar Block 9 Near PIA society Bhittaibad Street no 16 Near Al Madina madical store 	1992	150	2142	\N	0	20251030-48510	Delivered	2025-10-30 18:06:03.09273	Karachi	\N	\N
15	Chandra Khatri	03199261408	vasudevkhatri1971@gmail.com	H No.652 first floor PIB Colony	507	150	657	\N	0	20251117-56930	Delivered	2025-11-17 12:37:19.19962	Karachi	\N	\N
14	Chandra Khatri 	03199261408	vasudevkhatri1971@gmail.com	H No.652 first floor PIB colony	579	150	729	\N	0	20251117-92251	Delivered	2025-11-17 12:35:55.199652	Karachi	\N	\N
\.


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_item (id, product_name, price, quantity, product_image, order_id, color, size) FROM stdin;
10	Butterfly stud earrings 	656	1	https://res.cloudinary.com/dqsfxl599/image/upload/v1761826343/products/kueiei8cykxaiqjrqrp2.jpg	10	\N	\N
11	Shiny heart necklace	489	1	https://res.cloudinary.com/dqsfxl599/image/upload/v1761823587/products/zqhos8lfoeboq1m60fci.jpg	10	\N	\N
12	Shiny heart necklace (silver) 	847	1	https://res.cloudinary.com/dqsfxl599/image/upload/v1761823936/products/d9pbj6s3uedomzjotuax.jpg	10	\N	\N
16	Nail bracelet 	579	1	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824677/products/yzxzb9oekhau3rvfthix.jpg	14	Glossy Gold Finish	none
17	Tiny heart necklace (golden) 	507	1	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824454/products/tltkykfk8j0uoycyetfj.jpg	15	Golden Shine	none
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product (id, name, price, before_price, today_price, description, image, category_id, video_url, is_soldout, color, size) FROM stdin;
8	Shiny heart necklace (silver) 	847	0	847	“Shiny Heart Necklace — by Aurielle 💛✨”\r\nBecause love deserves to shine brighter.\r\nCrafted from High-Quality Stainless Steel, coated in lustrous gold plating for a luxurious glow that lasts forever.\r\n💫 Tarnish-free, waterproof, and hypoallergenic — made for everyday sparkle.\r\n\r\n💖 Details:\r\n• Material: Premium Stainless Steel (Guaranteed)\r\n• Style: Delicate Luxury Necklace\r\n• Shine that stays — no fade, no rust.	https://res.cloudinary.com/dqsfxl599/image/upload/v1761823936/products/d9pbj6s3uedomzjotuax.jpg	8	https://res.cloudinary.com/dqsfxl599/video/upload/v1761825227/products/videos/iucjdw1l364ae1umvci4.mov	f	Silver with Crystal-Studded Heart	
5	Flower necklace	489	0	489	Golden Rose Pendant — by Aurielle 🌹✨”\r\nA symbol of elegance that never fades.\r\nCrafted from Premium Stainless Steel — tarnish-free, waterproof, and hypoallergenic.\r\n✨ High-quality golden finish that stays radiant wear after wear.\r\nPerfect for every outfit — from coffee runs to candlelight dinners.\r\n\r\n💫 Details:\r\n• Material: 100% Stainless Steel (Guaranteed)\r\n• Style: Minimal luxury pendant\r\n• Long-lasting shine — no rust, no green marks.	https://res.cloudinary.com/dqsfxl599/image/upload/v1761823587/products/zqhos8lfoeboq1m60fci.jpg	8	\N	f	Glossy Gold with Pearl-white base	
12	Tiny heart necklace (golden) 	507	0	507	“Tiny Heart Necklace — by Aurielle ✨”\r\nDelicate, graceful, and forever timeless.\r\nCrafted from High-Quality Stainless Steel, coated in luxury gold plating for a soft radiant glow.\r\nWaterproof, tarnish-free, and hypoallergenic — made to stay beautiful with every wear. 💫\r\n\r\n💎 Details:\r\n• Material: Premium Stainless Steel (Guaranteed)\r\n• Style: Minimal Beaded Chain with Heart Charm\r\n• Long-lasting polish | Skin-safe | Everyday luxury	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824454/products/tltkykfk8j0uoycyetfj.jpg	8	https://res.cloudinary.com/dqsfxl599/video/upload/v1761825281/products/videos/sriwzo94mhbe01itecuf.mov	t	Golden Shine	
15	Moon and star bracelet 	699	0	699	“Moon & Star Bracelet — by Aurielle ✨”\r\nFor the ones who shine even in the darkest night.\r\nCrafted from Premium Stainless Steel, with a delicate gold finish that captures the glow of the moon and stars.\r\nWaterproof, tarnish-free, and hypoallergenic — made for your everyday sparkle. 💫\r\n\r\n💎 Details:\r\n• Material: 100% Stainless Steel (Guaranteed)\r\n• Style: Celestial Charm Bracelet (Moon, Star & Disc)\r\n• Long-lasting | Skin-safe | Fade-free	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824778/products/uo0rxuadn8hnhyl5x6vo.jpg	9	\N	f	Golden Shine	
14	Nail bracelet 	579	0	579	“Golden Nail Bracelet — by Aurielle ⚡”\r\nA symbol of strength, elegance, and individuality.\r\nCrafted from High-Quality Stainless Steel with luxury gold plating, inspired by the iconic Cartier nail design.\r\nTarnish-free, waterproof, and hypoallergenic — made for those who wear confidence like jewelry. 💪💎\r\n\r\n💖 Details:\r\n• Material: 100% Premium Stainless Steel (Guaranteed)\r\n• Style: Nail-Shaped Bangle\r\n• Durable | Fade-Free | Skin-Safe	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824677/products/yzxzb9oekhau3rvfthix.jpg	9	\N	t	Glossy Gold Finish	
13	Starfish pearl earrings 	508	0	508	“Starfish Pearl Earrings — by Aurielle 🌊✨”\r\nA touch of the ocean, a hint of elegance.\r\nCrafted from Premium Stainless Steel with delicate gold plating, featuring a soft pearl accent that catches every ray of light.\r\nLightweight, waterproof, and hypoallergenic — made for the modern muse. 💫\r\n\r\n💎 Details:\r\n• Material: 100% Stainless Steel (Guaranteed)\r\n• Style: Starfish Drop Studs\r\n• Tarnish-Free | Waterproof | Skin-Safe	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824570/products/u6gvul0bj8qbxjizn5cg.jpg	7	\N	f	Gold with White Pearl	
10	Single line heart necklace (glossy silver)	508	0	508	“Single Line Heart Necklace — by Aurielle 🤍”\r\nA piece that speaks simplicity, yet shines with emotion.\r\nCrafted from High-Quality Stainless Steel, finished in elegant silver for timeless radiance.\r\nTarnish-free, waterproof, and hypoallergenic — made to last as long as your love. 💫\r\n\r\n💎 Details:\r\n• Material: Premium Stainless Steel (Guaranteed)\r\n• Style: Minimal Open Heart Necklace\r\n• Fade-Free | Skin-Safe | Everyday Luxury\r\n\r\nFor hearts that stay genuine — always shining, never fading. 🤍	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824207/products/uumrl27mcwl8ttz1ilaj.jpg	8	\N	f	Glossy Silver	
7	Shiny heart necklace (Golden) 	848	0	848	“Shiny Heart Necklace — by Aurielle 💛✨”\r\nBecause love deserves to shine brighter.\r\nCrafted from High-Quality Stainless Steel, coated in lustrous gold plating for a luxurious glow that lasts forever.\r\n💫 Tarnish-free, waterproof, and hypoallergenic — made for everyday sparkle.\r\n\r\n💖 Details:\r\n• Material: Premium Stainless Steel (Guaranteed)\r\n• Style: Delicate Luxury Necklace\r\n• Shine that stays — no fade, no rust.	https://res.cloudinary.com/dqsfxl599/image/upload/v1761823872/products/wheykviuiynjjjhphsen.jpg	8	https://res.cloudinary.com/dqsfxl599/video/upload/v1761825166/products/videos/ueu0stp6uwqdtdfa3g6y.mov	f	Golden with Crystal-Studded Heart	
11	Heart earrings 	657	0	657	“Golden Heart Earrings — by Aurielle ✨”\r\nWhere minimal design meets timeless love.\r\nCrafted from High-Quality Stainless Steel, coated in luxury gold plating that stays radiant — wear after wear.\r\nLightweight, elegant, and made to last — just like your glow. 🌸\r\n\r\n💫 Details:\r\n• Material: Premium Stainless Steel (Guaranteed)\r\n• Style: Open Heart Studs\r\n• Tarnish-Free | Waterproof | Hypoallergenic\r\n\r\nSimple. Elegant. Everlasting. 💖\r\n#AurielleBySHSA #GoldenHearts #LuxuryEarrings #TimelessGlow #StainlessSteelJewelry	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824344/products/dfzgeeo7qcarbeie8isc.jpg	7	https://res.cloudinary.com/dqsfxl599/video/upload/v1761825086/products/videos/xmho2nothusqqnnlwdse.mov	f	Glossy Gold	
19	Heart charm jewellery set (pearl white) 	627	0	627	“Heart Charm Jewelry Set — by Aurielle 💕”\r\nWhere love meets elegance.\r\nA complete 3-piece set featuring earrings, ring, and pendant necklace, crafted from High-Quality Stainless Steel and coated in luxury gold plating for a lasting glow.\r\nAvailable in two timeless shades — Pearl White 🤍 — made to complement every mood and moment.\r\n\r\n💫 Details:\r\n• Material: 100% Stainless Steel (Guaranteed)\r\n• Includes: Necklace, Ring, and Earrings\r\n• Tarnish-Free | Waterproof | Hypoallergenic	https://res.cloudinary.com/dqsfxl599/image/upload/v1761825786/products/upla565phmwokoi1wkj8.jpg	10	\N	f	White with Gold Frame	
16	Black clover necklace 	627	0	627	“Black Clover Necklace — by Aurielle ✨”\r\nA symbol of elegance and quiet confidence.\r\nCrafted from High-Quality Stainless Steel with jet-black clover charms, framed in a soft golden edge — the perfect balance of bold and graceful.\r\nTarnish-free, waterproof, and hypoallergenic — made to last as beautifully as you. 💫\r\n\r\n💎 Details:\r\n• Material: Premium Stainless Steel (Guaranteed)\r\n• Style: Y-Shaped Clover Necklace\r\n• Skin-safe | Long-lasting shine | Elegant finish	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824928/products/qxiocvuxxllx8tjof4ik.jpg	8	https://res.cloudinary.com/dqsfxl599/video/upload/v1761824930/products/videos/aewcedhnvlhfikigv1do.mov	f	Gold with Black Clover Accents	
9	Rose flower necklace 	688	0	688	“Golden Rose Necklace — by Aurielle ✨”\r\nA timeless rose that never fades.\r\nCrafted from Premium Stainless Steel, designed to keep its golden glow forever.\r\nElegant, bold, and made for the ones who bloom with grace. 🌸\r\n\r\n💫 Details:\r\n• Material: 100% Stainless Steel (Guaranteed)\r\n• Style: Minimal Rose Pendant\r\n• Tarnish-Free | Waterproof | Hypoallergenic	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824085/products/rxhuqq5s5vrgygq8rbti.jpg	8	https://res.cloudinary.com/dqsfxl599/video/upload/v1761825024/products/videos/apng6ffereyzwhtlx8ah.mov	f	Glossy Gold Finish	
17	Stainless golden bracelet carlier style	549	0	549	Golden Love Bracelet — by Aurielle ✨”\r\nWhere elegance meets strength.\r\nInspired by the timeless Cartier style, this bracelet embodies everlasting sophistication.\r\nMade from High-Quality Stainless Steel with a luxury gold finish and delicate crystal studs, it’s tarnish-free, waterproof, and hypoallergenic.\r\n\r\n💎 Details:\r\n• Material: Premium Stainless Steel (Guaranteed)\r\n• Style: Love-Inspired Screw Bangle with Crystals\r\n• Durable | Fade-Free | Everyday Luxury	https://res.cloudinary.com/dqsfxl599/image/upload/v1761825462/products/ctaizapzq4aenzbxgaot.jpg	9	\N	t	Classic Gold	
18	Heart charm jewellery set 	627	0	627	“Heart Charm Jewelry Set — by Aurielle 💕”\r\nWhere love meets elegance.\r\nA complete 3-piece set featuring earrings, ring, and pendant necklace, crafted from High-Quality Stainless Steel and coated in luxury gold plating for a lasting glow.\r\nAvailable in two timeless shades — Midnight Black 🖤 — made to complement every mood and moment.\r\n\r\n💫 Details:\r\n• Material: 100% Stainless Steel (Guaranteed)\r\n• Includes: Necklace, Ring, and Earrings\r\n• Tarnish-Free | Waterproof | Hypoallergenic	https://res.cloudinary.com/dqsfxl599/image/upload/v1761825677/products/w41gf0ornio6lfm0eqmf.jpg	10	https://res.cloudinary.com/dqsfxl599/video/upload/v1761825678/products/videos/rcowq7gzpdbrypb5aeas.mov	f	Black with Gold Frame	
6	Rose flower necklace. (Silver) 	597	0	597	“Silver Rose Necklace — by Aurielle 🌸”\r\nSimplicity that speaks elegance.\r\nCrafted from High-Quality Stainless Steel, fully tarnish-free, waterproof, and hypoallergenic.\r\nIts soft silver tone complements every outfit — from casual chic to night-out glam.\r\n\r\n💫 Details:\r\n• Material: 100% Premium Stainless Steel (Guaranteed)\r\n• Style: Minimal Rose Pendant\r\n• Fade-free | Skin-safe | Long-lasting polish	https://res.cloudinary.com/dqsfxl599/image/upload/v1761823759/products/k762zyaacgcdf8lufa55.jpg	8	https://res.cloudinary.com/dqsfxl599/video/upload/v1761825336/products/videos/sbanaorfpymnlbqp1sp4.mov	f	Elegant Silver with Pearl-White Shine	
21	Butterfly stud earrings 	656	0	656	“Golden Butterfly Studs — by Aurielle ✨”\r\nDelicate, graceful, and full of meaning — a symbol of freedom and transformation.\r\nCrafted from High-Quality Stainless Steel with a luxury gold finish, designed to shine effortlessly with every outfit.\r\nLightweight, tarnish-free, and hypoallergenic — made for all-day comfort and glow. 💛\r\n\r\n💫 Details:\r\n• Material: 100% Stainless Steel (Guaranteed)\r\n• Style: Butterfly Stud Earrings\r\n• Fade-Free | Skin-Safe | Everyday Luxury	https://res.cloudinary.com/dqsfxl599/image/upload/v1761826343/products/kueiei8cykxaiqjrqrp2.jpg	7	\N	f	Glossy Gold	
20	Premium luxury ring set (3 in 1) 	969	0	969	“3-in-1 Ring Set — by Aurielle ✨”\r\nTriple the shine, endless elegance.\r\nThis stunning set features three interlocking rings, each crafted from Premium Stainless Steel with a mix of gold, crystal, and Roman design bands — creating a perfect blend of sophistication and strength.\r\nWear them together or style separately — either way, you’ll glow with every move. 💫\r\n\r\n💎 Details:\r\n• Material: High-Quality Stainless Steel (Guaranteed)\r\n• Colors: Gold | Silver | Crystal-Studded\r\n• Style: Interchangeable 3-in-1 Luxury Ring Set\r\n• Tarnish-Free | Waterproof | Hypoallergenic	https://res.cloudinary.com/dqsfxl599/image/upload/v1761825924/products/zxq5rqt7gtsyav820d0j.jpg	6	https://res.cloudinary.com/dqsfxl599/video/upload/v1761826185/products/videos/akximbehvligoq5qfxwq.mov	f	Gold \\ Silver\\ Crystal-Studded	6 , 7 , 8 , 9
\.


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_image (id, filename, "order", product_id) FROM stdin;
3	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824087/products/gallery/z2hojdnh7lasbnafsmvo.jpg	0	9
4	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824345/products/gallery/mcfxbozrbpj5oxioikdz.jpg	0	11
5	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824571/products/gallery/njiyrfsfbogvpduvcbmt.jpg	0	13
6	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824678/products/gallery/wp9m9v3fxl1mrqepkxbr.jpg	0	14
7	https://res.cloudinary.com/dqsfxl599/image/upload/v1761824779/products/gallery/nc8rxomw3xy5tpq4bdzf.jpg	0	15
8	https://res.cloudinary.com/dqsfxl599/image/upload/v1761825463/products/gallery/anhb39fqi8hbtaarjajf.jpg	0	17
9	https://res.cloudinary.com/dqsfxl599/image/upload/v1761825930/products/gallery/kpvi5ieogtgzuqsv7dyy.jpg	0	20
10	https://res.cloudinary.com/dqsfxl599/image/upload/v1761826344/products/gallery/vd6w42kj7zu0pym6vphg.jpg	0	21
\.


--
-- Data for Name: promo_banner; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promo_banner (id, title, subtitle, image, status, created_at) FROM stdin;
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.review (id, product_id, user_name, rating, comment, created_at) FROM stdin;
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.setting (id, website_name, logo, line_banner_text, background_image, hero_banner, about_image, perfume_image, perfume_video, product_visibility_start, product_visibility_end, timer_enabled, coming_soon_message, free_delivery_threshold, delivery_fee, maintenance_mode, maintenance_message, hero_video) FROM stdin;
1	AURIELLE	https://res.cloudinary.com/dqsfxl599/image/upload/v1761088864/site_assets/r2ntfd7vvkmtnw994elz.jpg	“Made to glow with you.” 💜	\N	\N	\N	\N	\N	\N	\N	f	🚀 Get ready! A fresh collection of products will be available soon.	3000	250	f	🛠️ Our website is currently under maintenance. Please check back soon.	https://res.cloudinary.com/dqsfxl599/video/upload/v1761733642/Aurielle/hero_videos/l2y5rtxsjjstw6bbebov.mp4
\.


--
-- Data for Name: visit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.visit (id, ip, date, user_agent, "timestamp", device) FROM stdin;
1	100.64.0.2	2025-10-19	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-19 21:48:40.620293	\N
2	100.64.0.3	2025-10-19	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-19 22:00:51.401382	\N
3	100.64.0.4	2025-10-19	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-19 22:01:52.286595	\N
4	100.64.0.3	2025-10-19	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-10-19 23:44:33.719982	\N
5	100.64.0.2	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-20 00:04:42.267316	\N
6	100.64.0.4	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-20 00:05:53.575533	\N
7	100.64.0.3	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-20 00:13:21.564489	\N
8	100.64.0.5	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 02:47:28.0454	\N
9	100.64.0.6	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 02:47:28.439263	\N
10	100.64.0.7	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 02:47:58.041381	\N
11	100.64.0.9	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 02:48:43.822781	\N
12	100.64.0.10	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 04:32:18.584526	\N
13	100.64.0.10	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 04:32:18.584424	\N
14	100.64.0.12	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 05:04:58.762037	\N
15	100.64.0.13	2025-10-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-20 05:05:07.258704	\N
16	100.64.0.2	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-20 08:55:28.725721	\N
17	100.64.0.8	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-20 09:28:23.690289	\N
18	100.64.0.11	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-20 10:27:22.206787	\N
19	100.64.0.3	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-20 11:28:12.002176	\N
20	100.64.0.5	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-20 12:00:07.137161	\N
21	100.64.0.5	2025-10-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-20 14:52:39.512092	\N
22	100.64.0.4	2025-10-21	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-21 09:45:20.66591	\N
23	100.64.0.3	2025-10-21	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-21 15:46:21.12249	\N
24	100.64.0.2	2025-10-21	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-21 20:48:19.038852	\N
25	100.64.0.4	2025-10-22	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-22 01:30:51.84112	\N
26	100.64.0.2	2025-10-22	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-22 01:49:59.181066	\N
27	100.64.0.6	2025-10-22	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-10-22 01:50:00.585289	\N
28	100.64.0.2	2025-10-22	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-22 05:35:24.112825	\N
29	100.64.0.6	2025-10-22	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-22 12:11:55.504196	\N
30	100.64.0.7	2025-10-22	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	2025-10-22 17:51:56.28498	\N
31	100.64.0.2	2025-10-23	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-23 19:44:41.555581	\N
32	100.64.0.4	2025-10-23	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-23 21:27:11.166576	\N
33	100.64.0.4	2025-10-24	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-24 15:38:39.952226	\N
34	100.64.0.6	2025-10-24	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-24 17:25:56.485695	\N
35	100.64.0.5	2025-10-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-26 00:52:19.159122	\N
36	100.64.0.2	2025-10-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-26 14:29:46.372391	\N
37	100.64.0.6	2025-10-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-26 19:26:24.902246	\N
38	100.64.0.2	2025-10-27	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-27 13:58:42.390731	\N
244	100.64.0.6	2025-11-01	MobileSafari/8615.8.1.10.2 CFNetwork/1410.1 Darwin/22.6.0	2025-11-01 18:14:12.960004	\N
39	100.64.0.6	2025-10-27	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-10-27 13:58:47.156167	\N
40	100.64.0.4	2025-10-27	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-27 14:03:53.041351	\N
41	100.64.0.5	2025-10-27	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-27 14:06:45.786852	\N
42	100.64.0.5	2025-10-27	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-27 16:13:00.381444	\N
43	100.64.0.2	2025-10-27	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-27 17:14:10.42076	\N
44	100.64.0.2	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-28 00:39:50.923543	\N
45	100.64.0.3	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-28 06:05:50.916509	\N
46	100.64.0.4	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-28 13:08:48.321463	\N
47	100.64.0.6	2025-10-28	Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA468058) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.1109.98 Mobile Safari/537.3	2025-10-28 23:01:43.652281	\N
48	100.64.0.13	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.156 Mobile/15E148 Safari/604.1	2025-10-28 23:03:23.721274	\N
49	100.64.0.14	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.156 Mobile/15E148 Safari/604.1	2025-10-28 23:03:39.876045	\N
50	100.64.0.17	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 16_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1	2025-10-28 23:09:54.412329	\N
51	100.64.0.3	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-28 23:22:34.399707	\N
52	127.0.0.1	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36	2025-10-28 23:23:30.217446	\N
53	100.64.0.7	2025-10-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-28 23:42:23.129163	\N
54	100.64.0.3	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-29 00:01:18.099176	\N
55	100.64.0.2	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-29 00:01:37.603338	\N
56	100.64.0.4	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1	2025-10-29 00:21:38.249413	\N
57	100.64.0.3	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 00:29:06.783558	\N
58	100.64.0.4	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 00:29:18.160578	\N
59	100.64.0.6	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Mobile/15E148 Safari/604.1	2025-10-29 00:30:52.731494	\N
60	100.64.0.5	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-10-29 00:43:00.315529	\N
61	100.64.0.5	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-29 00:43:41.349161	\N
62	100.64.0.4	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-29 01:15:08.844323	\N
63	100.64.0.7	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-29 01:20:13.010444	\N
64	100.64.0.4	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-29 01:45:03.86134	\N
65	100.64.0.2	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-29 01:47:22.546299	\N
66	100.64.0.3	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-29 02:17:09.709488	\N
67	100.64.0.11	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 03:15:21.962112	\N
68	100.64.0.12	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 03:15:25.305246	\N
69	100.64.0.15	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 04:09:02.383676	\N
70	100.64.0.16	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 04:09:02.686911	\N
71	100.64.0.6	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 04:09:06.983336	\N
72	100.64.0.2	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36	2025-10-29 04:12:12.324137	\N
73	100.64.0.3	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36	2025-10-29 04:12:13.698398	\N
74	100.64.0.2	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-29 05:24:06.581071	\N
75	100.64.0.8	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 05:24:14.871146	\N
76	100.64.0.17	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 05:24:15.331209	\N
77	100.64.0.18	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 05:24:15.486685	\N
78	100.64.0.19	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 07:51:24.615426	\N
79	100.64.0.4	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/391.0.820341064 Mobile/15E148 Safari/604.1	2025-10-29 07:58:54.620321	\N
80	100.64.0.5	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-29 08:51:48.981741	\N
81	100.64.0.7	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-29 09:24:28.035613	\N
82	100.64.0.11	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-29 09:46:16.694897	\N
245	100.64.0.3	2025-11-01	MobileSafari/8615.8.1.10.2 CFNetwork/1410.1 Darwin/22.6.0	2025-11-01 18:14:13.578464	\N
83	100.64.0.13	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 09:46:50.262934	\N
84	100.64.0.2	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 26_1_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/391.0.820341064 Mobile/15E148 Safari/604.1	2025-10-29 09:47:07.295726	\N
85	100.64.0.14	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 09:47:59.080144	\N
87	100.64.0.15	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 09:47:59.598028	\N
88	100.64.0.19	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 09:54:19.878895	\N
86	100.64.0.6	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 09:47:59.527981	\N
89	100.64.0.20	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 09:54:28.811303	\N
90	100.64.0.3	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 26_1_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/391.0.820341064 Mobile/15E148 Safari/604.1	2025-10-29 10:14:45.083953	\N
91	100.64.0.4	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 10:15:09.401082	\N
92	100.64.0.5	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-29 10:15:10.114053	\N
93	100.64.0.8	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-29 10:27:43.43204	\N
94	100.64.0.12	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 12_4 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.79 Mobile/16G77 Safari/602.1	2025-10-29 10:29:57.151796	\N
95	100.64.0.12	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-29 10:54:21.520802	\N
96	100.64.0.8	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 11:33:58.224291	\N
97	100.64.0.10	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 11:33:58.368546	\N
98	100.64.0.13	2025-10-29	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-29 11:34:02.02821	\N
99	100.64.0.20	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-29 12:03:43.50368	\N
100	100.64.0.5	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-29 13:01:46.815382	\N
101	100.64.0.12	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-29 13:01:52.324827	\N
102	100.64.0.12	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-29 13:02:45.870022	\N
103	100.64.0.5	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-29 13:15:17.820289	\N
104	100.64.0.12	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-10-29 13:15:19.221909	\N
105	100.64.0.4	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-10-29 13:15:19.692195	\N
106	100.64.0.4	2025-10-29	Mozilla/5.0 (Linux; Android 12; Infinix X6817) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Mobile Safari/537.36	2025-10-29 13:15:37.782291	\N
107	100.64.0.3	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-29 13:22:43.847581	\N
108	100.64.0.3	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36	2025-10-29 13:22:51.206299	\N
109	100.64.0.16	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Mobile Safari/537.36	2025-10-29 13:22:56.16254	\N
110	100.64.0.21	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Brave/1 Mobile/15E148 Safari/604.1	2025-10-29 13:26:06.02704	\N
111	100.64.0.2	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-29 14:26:55.5601	\N
112	100.64.0.7	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-10-29 14:28:28.612816	\N
113	100.64.0.5	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-29 15:01:07.26191	\N
114	100.64.0.12	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-29 15:03:39.681335	\N
115	100.64.0.2	2025-10-29	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36	2025-10-29 16:01:46.443396	\N
116	100.64.0.29	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-29 20:51:38.255134	\N
117	100.64.0.13	2025-10-29	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-29 22:16:16.516034	\N
118	100.64.0.20	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-30 01:24:51.375574	\N
119	100.64.0.22	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-30 03:35:37.217835	\N
120	100.64.0.5	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-30 07:16:03.004971	\N
121	100.64.0.4	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-30 07:16:07.900793	\N
122	100.64.0.11	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 07:16:09.121991	\N
123	100.64.0.16	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 07:16:09.61248	\N
124	100.64.0.14	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 07:16:09.633376	\N
125	100.64.0.2	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-30 07:37:15.414571	\N
126	100.64.0.2	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-30 08:11:30.998579	\N
127	100.64.0.4	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-30 08:27:11.266655	\N
128	100.64.0.11	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-30 08:28:25.913309	\N
136	100.64.0.5	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-30 12:03:39.460708	\N
161	100.64.0.4	2025-10-30	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.116 Mobile Safari/537.36 Instagram 403.0.0.49.74 Android (34/14; 320dpi; 720x1440; realme; RMX3930; RE6054; ums9230_latte; en_PK; 810081491; IABMV/1)	2025-10-30 16:07:10.058883	\N
129	100.64.0.12	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-30 08:31:00.013392	\N
130	100.64.0.5	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-30 09:13:05.104471	\N
131	100.64.0.12	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-30 10:34:18.645263	\N
138	100.64.0.10	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 12:06:56.496278	\N
139	100.64.0.3	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 12:06:56.593685	\N
140	100.64.0.5	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-30 12:09:31.813834	\N
141	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1	2025-10-30 12:37:35.219791	\N
147	100.64.0.12	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1	2025-10-30 13:26:09.597253	\N
151	100.64.0.15	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-30 15:01:50.731362	\N
164	100.64.0.12	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605) NW/3	2025-10-30 16:53:58.900267	\N
165	100.64.0.2	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605)	2025-10-30 16:55:43.317054	\N
132	100.64.0.12	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-30 11:17:20.608879	\N
134	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-30 11:34:21.314746	\N
149	100.64.0.26	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 13:36:29.214385	\N
162	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22E252 Instagram 403.0.0.28.80 (iPhone13,4; iOS 18_4_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605)	2025-10-30 16:15:39.518968	\N
169	100.64.0.5	2025-10-30	Mozilla/5.0 (Linux; Android 13; TECNO KJ5 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 320dpi; 720x1532; TECNO; TECNO KJ5; TECNO-KJ5; mt6768; en_US; 813748055; IABMV/1) NV/1	2025-10-30 18:36:22.217255	\N
133	100.64.0.2	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-30 11:26:57.490913	\N
135	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-30 11:49:06.512868	\N
137	100.64.0.30	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 12:06:55.895056	\N
142	100.64.0.2	2025-10-30	Mozilla/5.0 (Linux; Android 8.1.0; SAMSUNG SM-G610F Build/M1AJQ) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/7.2 Chrome/59.0.3071.125 Mobile Safari/537.36	2025-10-30 12:38:25.560647	\N
153	100.64.0.5	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605) NW/3	2025-10-30 15:21:09.724405	\N
156	100.64.0.12	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [FBAN/FBIOS;FBAV/530.0.0.35.103;FBBV/810373925;FBDV/iPhone14,3;FBMD/iPhone;FBSN/iOS;FBSV/26.1;FBSS/3;FBCR/;FBID/phone;FBLC/en_GB;FBOP/80]	2025-10-30 15:53:41.70331	\N
158	100.64.0.4	2025-10-30	Mozilla/5.0 (Linux; Android 14; 24116RACCG Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.97 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/531.0.0.47.109;]	2025-10-30 15:54:02.788667	\N
160	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A355 Instagram 403.0.0.28.80 (iPhone15,3; iOS 26_0_1; en_GB; en-GB; scale=3.00; 1290x2796; IABMV/1; 808786605)	2025-10-30 16:03:16.665597	\N
163	100.64.0.4	2025-10-30	Mozilla/5.0 (Linux; Android 16; Pixel 7 Pro Build/BP3A.251005.004.B1; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (36/16; 420dpi; 1080x2340; Google/google; Pixel 7 Pro; cheetah; cheetah; en_US; 813748055; IABMV/1)	2025-10-30 16:23:16.185277	\N
143	100.64.0.2	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-30 12:39:07.574465	\N
144	100.64.0.12	2025-10-30	Mozilla/5.0 (Linux; Android 8.1.0; SAMSUNG SM-G610F Build/M1AJQ) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/7.2 Chrome/59.0.3071.125 Mobile Safari/537.36	2025-10-30 12:42:27.406288	\N
145	100.64.0.12	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-30 12:43:38.747292	\N
146	100.64.0.2	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	2025-10-30 12:44:05.838092	\N
150	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-10-30 14:21:27.786662	\N
155	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605) NW/3	2025-10-30 15:41:16.076355	\N
157	100.64.0.2	2025-10-30	Mozilla/5.0 (Linux; Android 14; 24116RACCG Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.97 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/531.0.0.47.109;]	2025-10-30 15:53:45.953381	\N
159	100.64.0.2	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A355 Instagram 403.0.0.28.80 (iPhone15,3; iOS 26_0_1; en_GB; en-GB; scale=3.00; 1290x2796; IABMV/1; 808786605)	2025-10-30 16:03:01.442515	\N
168	100.64.0.5	2025-10-30	Mozilla/5.0 (Linux; Android 13; TECNO KJ5 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 320dpi; 720x1532; TECNO; TECNO KJ5; TECNO-KJ5; mt6768; en_US; 813748055; IABMV/1)	2025-10-30 18:36:03.712314	\N
148	100.64.0.5	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-30 13:35:56.020551	\N
152	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605)	2025-10-30 15:09:55.266305	\N
154	100.64.0.2	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605) NW/3	2025-10-30 15:23:30.154275	\N
166	100.64.0.4	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22C154 Instagram 403.0.0.28.80 (iPhone14,5; iOS 18_2; en_GB; en-GB; scale=3.00; 1170x2532; IABMV/1; 808786605)	2025-10-30 17:50:55.688445	\N
167	100.64.0.12	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/20H364 Instagram 404.0.0.27.81 (iPhone10,2; iOS 16_7_12; en_GB; en-GB; scale=3.00; 1242x2208; IABMV/1; 812595035)	2025-10-30 18:21:06.233556	\N
170	100.64.0.8	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-30 22:15:47.493119	\N
171	100.64.0.10	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/392.0.823086651 Mobile/15E148 Safari/604.1	2025-10-30 22:25:32.97928	\N
172	100.64.0.2	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/392.0.823086651 Mobile/15E148 Safari/604.1	2025-10-30 22:26:45.463303	\N
173	100.64.0.12	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/392.0.823086651 Mobile/15E148 Safari/604.1	2025-10-30 22:27:43.985829	\N
174	100.64.0.6	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 22:27:44.372156	\N
175	100.64.0.13	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 22:31:49.285236	\N
176	100.64.0.9	2025-10-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-10-30 22:31:49.808021	\N
177	100.64.0.15	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/392.0.823086651 Mobile/15E148 Safari/604.1	2025-10-30 22:35:42.346664	\N
178	100.64.0.4	2025-10-30	Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36	2025-10-30 22:48:26.556945	\N
179	100.64.0.4	2025-10-30	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-30 23:11:11.070185	\N
180	100.64.0.5	2025-10-30	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-30 23:11:21.062952	\N
181	100.64.0.6	2025-10-30	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-10-30 23:11:26.06455	\N
182	100.64.0.8	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-30 23:53:07.58453	\N
183	100.64.0.8	2025-10-30	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-30 23:53:07.585798	\N
184	100.64.0.3	2025-10-31	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-10-31 00:12:05.798908	\N
185	100.64.0.3	2025-10-31	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-10-31 00:12:57.05974	\N
186	100.64.0.5	2025-10-31	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-10-31 00:12:58.391139	\N
187	100.64.0.4	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/392.0.823086651 Mobile/15E148 Safari/604.1	2025-10-31 00:27:35.283634	\N
188	100.64.0.6	2025-10-31	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-31 00:46:51.616103	\N
189	100.64.0.8	2025-10-31	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-31 00:48:02.842428	\N
190	100.64.0.3	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-31 01:27:51.610008	\N
191	100.64.0.7	2025-10-31	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Mobile Safari/537.36	2025-10-31 01:46:14.63028	\N
192	100.64.0.6	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1	2025-10-31 01:46:18.808009	\N
193	100.64.0.11	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/392.0.823086651 Mobile/15E148 Safari/604.1	2025-10-31 01:55:01.321296	\N
194	100.64.0.6	2025-10-31	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-31 02:01:15.94149	\N
195	100.64.0.7	2025-10-31	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-10-31 02:41:17.99756	\N
196	100.64.0.7	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1 OPT/6.1.4	2025-10-31 03:49:39.877254	\N
197	100.64.0.12	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1	2025-10-31 04:02:06.38836	\N
198	100.64.0.12	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	2025-10-31 05:39:24.146882	\N
199	100.64.0.18	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-31 08:11:54.992909	\N
200	100.64.0.5	2025-10-31	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-10-31 08:47:08.532315	\N
202	100.64.0.19	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-31 12:04:21.885824	\N
201	100.64.0.7	2025-10-31	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 813747959; IABMV/1)	2025-10-31 10:53:38.591271	\N
203	100.64.0.7	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-10-31 13:12:54.206502	\N
204	100.64.0.16	2025-10-31	Mozilla/5.0 (Linux; Android 10; M2006C3MNG Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/87.0.4280.101 Mobile Safari/537.36 musical_ly_2023102050 JsSdk/1.0 NetType/4G Channel/googleplay AppName/musical_ly app_version/31.2.5 ByteLocale/ru-RU ByteFullLocale/ru-RU Region/US Spark/1.4.0.8-bugfix AppVersion/31.2.5 BytedanceWebview/d8a21c6	2025-10-31 13:13:28.825786	\N
207	100.64.0.6	2025-10-31	Mozilla/5.0 (Linux; Android 14; Infinix X6532 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (34/14; 320dpi; 720x1440; INFINIX/Infinix; Infinix X6532; Infinix-X6532; mt6768; en_US; 813747930; IABMV/1)	2025-10-31 13:28:36.198614	\N
208	100.64.0.7	2025-10-31	Mozilla/5.0 (Linux; Android 13; SM-A127F Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 300dpi; 720x1529; samsung; SM-A127F; a12s; exynos850; en_GB; 813748137; IABMV/1)	2025-10-31 13:45:10.364244	\N
209	100.64.0.6	2025-10-31	Mozilla/5.0 (Linux; Android 13; SM-A127F Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 300dpi; 720x1529; samsung; SM-A127F; a12s; exynos850; en_GB; 813748137; IABMV/1)	2025-10-31 13:45:34.91023	\N
210	100.64.0.11	2025-10-31	Mozilla/5.0 (Linux; Android 11; TECNO KG5k Build/RP1A.201005.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 320dpi; 720x1456; TECNO MOBILE LIMITED/TECNO; TECNO KG5k; TECNO-KG5k; KG5k; en_US; 813748055; IABMV/1)	2025-10-31 14:12:16.41445	\N
205	100.64.0.7	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 26_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari/604.1 musical_ly_41.9.0 BytedanceWebview/d8a21c6	2025-10-31 13:13:35.47056	\N
206	100.64.0.7	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605)	2025-10-31 13:22:41.025505	\N
211	100.64.0.11	2025-10-31	Mozilla/5.0 (Linux; Android 11; TECNO KG5k Build/RP1A.201005.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 320dpi; 720x1456; TECNO MOBILE LIMITED/TECNO; TECNO KG5k; TECNO-KG5k; KG5k; en_US; 813748055; IABMV/1) NV/1	2025-10-31 14:12:44.243608	\N
212	100.64.0.9	2025-10-31	Mozilla/5.0 (Linux; Android 15; SM-A336E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (35/15; 420dpi; 1080x2400; samsung; SM-A336E; a33x; s5e8825; en_GB; 813748055; IABMV/1)	2025-10-31 16:11:38.684237	\N
213	100.64.0.9	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-10-31 16:45:58.747646	\N
214	100.64.0.7	2025-10-31	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-10-31 18:31:10.515594	\N
215	100.64.0.9	2025-10-31	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36	2025-10-31 19:02:13.036663	\N
216	100.64.0.21	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-31 20:17:07.436931	\N
217	100.64.0.3	2025-10-31	Mozilla/5.0 (Linux; Android 15; V2419 Build/AP3A.240905.015.A2_NN; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (35/15; 300dpi; 720x1608; vivo; V2419; V2419; ums9230_6h10; en_PK; 813748055; IABMV/1)	2025-10-31 21:37:02.533632	\N
218	100.64.0.6	2025-10-31	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-10-31 22:14:50.552251	\N
219	100.64.0.6	2025-11-01	Mozilla/5.0 (Linux; Android 16; Pixel 7 Pro Build/BP3A.251005.004.B1; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (36/16; 420dpi; 1080x2340; Google/google; Pixel 7 Pro; cheetah; cheetah; en_US; 813748055; IABMV/1)	2025-11-01 02:01:13.478635	\N
220	100.64.0.9	2025-11-01	Mozilla/5.0 (Linux; Android 16; Pixel 7 Pro Build/BP3A.251005.004.B1; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (36/16; 420dpi; 1080x2340; Google/google; Pixel 7 Pro; cheetah; cheetah; en_US; 813748055; IABMV/1)	2025-11-01 02:09:43.529693	\N
221	100.64.0.3	2025-11-01	Mozilla/5.0 (Linux; Android 16; Pixel 7 Pro Build/BP3A.251005.004.B1; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (36/16; 420dpi; 1080x2340; Google/google; Pixel 7 Pro; cheetah; cheetah; en_US; 813748055; IABMV/1)	2025-11-01 02:09:51.113731	\N
222	100.64.0.2	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	2025-11-01 03:22:59.698619	\N
223	100.64.0.2	2025-11-01	Mozilla/5.0 (Linux; Android 12; Infinix X6817 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/105.0.5195.136 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (31/12; 320dpi; 720x1472; INFINIX/Infinix; Infinix X6817; Infinix-X6817; mt6769; en_US; 813748018)	2025-11-01 07:31:39.762577	\N
224	100.64.0.6	2025-11-01	Mozilla/5.0 (Linux; Android 12; Infinix X6817 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/105.0.5195.136 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (31/12; 320dpi; 720x1472; INFINIX/Infinix; Infinix X6817; Infinix-X6817; mt6769; en_US; 813748018)	2025-11-01 07:32:12.787747	\N
225	100.64.0.23	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-01 07:51:53.819537	\N
226	100.64.0.3	2025-11-01	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Mobile Safari/537.36	2025-11-01 10:37:40.800655	\N
227	100.64.0.23	2025-11-01	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-11-01 10:47:45.203082	\N
228	100.64.0.9	2025-11-01	Mozilla/5.0 (Linux; Android 10; M2006C3MG Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.98 Mobile Safari/537.36 Instagram 403.0.0.49.74 Android (29/10; 320dpi; 720x1449; Xiaomi/Redmi; M2006C3MG; angelica; mt6765; en_US; 810081411; IABMV/1)	2025-11-01 11:07:52.005689	\N
229	100.64.0.2	2025-11-01	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	2025-11-01 11:09:00.497549	\N
230	100.64.0.2	2025-11-01	Mozilla/5.0 (Linux; Android 10; M2006C3MG Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.98 Mobile Safari/537.36 Instagram 403.0.0.49.74 Android (29/10; 320dpi; 720x1449; Xiaomi/Redmi; M2006C3MG; angelica; mt6765; en_US; 810081411; IABMV/1)	2025-11-01 11:09:20.466434	\N
231	100.64.0.18	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-01 11:28:39.019156	\N
232	100.64.0.20	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-01 11:55:37.921167	\N
233	100.64.0.3	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 15_8_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.6.7 Mobile/15E148 Safari/604.1	2025-11-01 11:58:24.175527	\N
234	100.64.0.9	2025-11-01	Mozilla/5.0 (Linux; Android 15; en; TECNO CM6 Build/SP1A.210812.016) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 HiBrowser/v2.25.4.3;lang=en;nation=PK;locale=en_US UWS/ Mobile Safari/537.36	2025-11-01 14:52:56.676826	\N
235	100.64.0.2	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1 Mobile/15E148 Safari/604.1	2025-11-01 15:09:04.060283	\N
236	100.64.0.9	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1 Mobile/15E148 Safari/604.1	2025-11-01 15:12:13.871167	\N
237	100.64.0.3	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1 Mobile/15E148 Safari/604.1	2025-11-01 15:13:00.615424	\N
238	100.64.0.6	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1 Mobile/15E148 Safari/604.1	2025-11-01 15:15:21.504005	\N
239	100.64.0.6	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/21B101 Instagram 401.0.0.37.85 (iPhone12,1; iOS 17_1_2; en_US; en; scale=2.00; 828x1792; IABMV/1; 802977049)	2025-11-01 17:18:25.617762	\N
240	100.64.0.3	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605)	2025-11-01 17:25:30.03464	\N
241	100.64.0.9	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 17_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1	2025-11-01 17:32:56.455234	\N
247	100.64.0.24	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-01 19:55:17.673586	\N
251	100.64.0.18	2025-11-01	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-11-01 23:49:40.617259	\N
253	100.64.0.24	2025-11-01	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-11-01 23:50:04.48254	\N
258	100.64.0.11	2025-11-02	Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36	2025-11-02 02:59:16.020547	\N
259	100.64.0.27	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-02 12:05:06.582377	\N
267	100.64.0.20	2025-11-02	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Mobile Safari/537.3	2025-11-02 16:44:36.881253	\N
268	100.64.0.19	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 17_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Mobile/15E148 Safari/604.	2025-11-02 16:44:36.98364	\N
275	100.64.0.2	2025-11-02	Mozilla/5.0 (Linux; Android 13; TECNO KJ5 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 320dpi; 720x1532; TECNO; TECNO KJ5; TECNO-KJ5; mt6768; en_US; 813748055; IABMV/1)	2025-11-02 20:02:36.828606	\N
242	100.64.0.3	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1	2025-11-01 18:14:09.14086	\N
250	100.64.0.3	2025-11-01	Mozilla/5.0 (Linux; Android 13; 2201117TG Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 440dpi; 1080x2177; Xiaomi/Redmi; 2201117TG; spes; qcom; en_GB; 813748141; IABMV/1)	2025-11-01 20:42:28.942028	\N
252	100.64.0.23	2025-11-01	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-11-01 23:49:52.703095	\N
254	100.64.0.9	2025-11-02	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Mobile Safari/537.36	2025-11-02 00:06:41.322254	\N
273	100.64.0.9	2025-11-02	Mozilla/5.0 (Linux; Android 13; TECNO KJ5 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 320dpi; 720x1532; TECNO; TECNO KJ5; TECNO-KJ5; mt6768; en_US; 813748055; IABMV/1)	2025-11-02 20:01:26.319783	\N
278	100.64.0.26	2025-11-03	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-03 03:05:38.78552	\N
243	100.64.0.2	2025-11-01	Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1	2025-11-01 18:14:10.409808	\N
246	100.64.0.2	2025-11-01	Mozilla/5.0 (Linux; Android 14; en; TECNO CK6n Build/SP1A.210812.016) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 HiBrowser/v2.25.4.3;lang=en;nation=PK;locale=en_US UWS/ Mobile Safari/537.36	2025-11-01 18:32:23.533108	\N
260	100.64.0.9	2025-11-02	Mozilla/5.0 (Linux; Android 12; Infinix X6817 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (31/12; 320dpi; 720x1472; INFINIX/Infinix; Infinix X6817; Infinix-X6817; mt6769; en_US; 813748018; IABMV/1)	2025-11-02 12:48:21.29563	\N
261	100.64.0.3	2025-11-02	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-11-02 12:48:58.2277	\N
272	100.64.0.9	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A355 Instagram 404.0.0.27.81 (iPhone15,3; iOS 26_0_1; en_GB; en-GB; scale=3.00; 1290x2796; IABMV/1; 812595035)	2025-11-02 19:28:56.082272	\N
276	100.64.0.9	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 808786605)	2025-11-02 21:02:51.2537	\N
248	100.64.0.2	2025-11-01	Mozilla/5.0 (Linux; Android 15; Redmi Note 12 Build/AQ3A.240829.003) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.6312.118 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.44.1-gn	2025-11-01 20:40:13.311381	\N
249	100.64.0.2	2025-11-01	Mozilla/5.0 (Linux; Android 13; 2201117TG Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 440dpi; 1080x2177; Xiaomi/Redmi; 2201117TG; spes; qcom; en_GB; 813748141; IABMV/1)	2025-11-01 20:41:40.032969	\N
255	100.64.0.26	2025-11-02	Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36	2025-11-02 01:19:06.358418	\N
256	100.64.0.14	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-02 01:32:32.834593	\N
257	100.64.0.22	2025-11-02	Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36	2025-11-02 02:21:19.343346	\N
262	100.64.0.25	2025-11-02	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-11-02 12:49:01.84096	\N
263	100.64.0.7	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-02 15:05:04.769774	\N
264	100.64.0.2	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 17_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1	2025-11-02 16:37:03.758911	\N
265	100.64.0.24	2025-11-02	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.	2025-11-02 16:44:30.848708	\N
266	100.64.0.21	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 16_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.2 Mobile/15E148 Safari/604.	2025-11-02 16:44:31.905745	\N
269	100.64.0.3	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	2025-11-02 18:05:16.101246	\N
270	100.64.0.9	2025-11-02	Mozilla/5.0 (Linux; Android 6.0.1; CPH1701 Build/MMB29M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/106.0.5249.126 Mobile Safari/537.36 Instagram 278.0.0.22.117 Android (23/6.0.1; 320dpi; 720x1280; OPPO; CPH1701; CPH1701; qcom; en_US; 471827227)	2025-11-02 18:18:11.986262	\N
271	100.64.0.2	2025-11-02	Mozilla/5.0 (Linux; Android 6.0.1; CPH1701 Build/MMB29M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/106.0.5249.126 Mobile Safari/537.36 Instagram 278.0.0.22.117 Android (23/6.0.1; 320dpi; 720x1280; OPPO; CPH1701; CPH1701; qcom; en_US; 471827227)	2025-11-02 18:19:50.799584	\N
274	100.64.0.9	2025-11-02	Mozilla/5.0 (Linux; Android 13; TECNO KJ5 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 320dpi; 720x1532; TECNO; TECNO KJ5; TECNO-KJ5; mt6768; en_US; 813748055; IABMV/1) NV/1	2025-11-02 20:01:58.680808	\N
277	100.64.0.9	2025-11-02	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-11-02 21:03:47.423387	\N
279	100.64.0.10	2025-11-03	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36	2025-11-03 07:24:07.391342	\N
280	100.64.0.23	2025-11-03	Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Brave/1 Mobile/15E148 Safari/604.1	2025-11-03 07:25:57.347452	\N
281	100.64.0.3	2025-11-03	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 813747959; IABMV/1)	2025-11-03 08:33:41.959107	\N
282	100.64.0.6	2025-11-03	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 813747959; IABMV/1)	2025-11-03 08:34:00.001938	\N
283	100.64.0.6	2025-11-03	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 813747959; IABMV/1) NV/5	2025-11-03 08:34:48.792731	\N
284	100.64.0.6	2025-11-03	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A355 Instagram 404.0.0.27.81 (iPhone15,4; iOS 26_0_1; en_US; en; scale=3.00; 1179x2556; IABMV/1; 812595035)	2025-11-03 09:24:46.158719	\N
285	100.64.0.3	2025-11-03	Mozilla/5.0 (Linux; Android 13; Infinix X6525 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 320dpi; 720x1436; INFINIX/Infinix; Infinix X6525; Infinix-X6525; X6525; en_US; 813748137; IABMV/1)	2025-11-03 16:48:25.011459	\N
286	100.64.0.3	2025-11-03	Mozilla/5.0 (Linux; Android 11; TECNO KG8 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 480dpi; 1080x2208; TECNO MOBILE LIMITED/TECNO; TECNO KG8; TECNO-KG8; mt6769; en_US; 813748055; IABMV/1)	2025-11-03 16:59:13.076641	\N
287	100.64.0.6	2025-11-03	Mozilla/5.0 (Linux; Android 11; TECNO KG8 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (30/11; 480dpi; 1080x2208; TECNO MOBILE LIMITED/TECNO; TECNO KG8; TECNO-KG8; mt6769; en_US; 813748055; IABMV/1) NV/1	2025-11-03 16:59:22.802633	\N
288	100.64.0.9	2025-11-03	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36	2025-11-03 17:03:59.487621	\N
289	100.64.0.6	2025-11-03	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	2025-11-03 17:28:47.519085	\N
290	100.64.0.9	2025-11-03	Mozilla/5.0 (Linux; Android 10; SM-N975F Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (29/10; 420dpi; 1080x2069; samsung; SM-N975F; d2s; exynos9825; en_GB; 813748141; IABMV/1)	2025-11-03 22:30:35.559169	\N
291	100.64.0.3	2025-11-03	Mozilla/5.0 (Linux; Android 10; SM-N975F Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (29/10; 420dpi; 1080x2069; samsung; SM-N975F; d2s; exynos9825; en_GB; 813748141; IABMV/1)	2025-11-03 22:31:07.157872	\N
292	100.64.0.30	2025-11-04	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-04 03:34:16.144443	\N
293	100.64.0.28	2025-11-04	Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_12 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1	2025-11-04 07:10:55.863427	\N
299	100.64.0.17	2025-11-05	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-05 06:33:03.703947	\N
294	100.64.0.3	2025-11-04	Mozilla/5.0 (Linux; Android 13; CPH2219 Build/TP1A.220905.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (33/13; 480dpi; 1080x2285; OPPO; CPH2219; OP4F11L1; qcom; en_PK; 813748055; IABMV/1)	2025-11-04 09:35:39.701142	\N
297	100.64.0.2	2025-11-04	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 404.0.0.27.81 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 812595035)	2025-11-04 19:23:38.710027	\N
306	100.64.0.9	2025-11-06	Mozilla/5.0 (Linux; Android 12; Infinix X6817 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (31/12; 320dpi; 720x1472; INFINIX/Infinix; Infinix X6817; Infinix-X6817; mt6769; en_US; 813748055; IABMV/1)	2025-11-06 11:56:30.801907	\N
310	100.64.0.31	2025-11-06	Mozilla/5.0 (Linux; Android 14; SM-A065F Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (34/14; 300dpi; 720x1467; samsung; SM-A065F; a06; mt6768; en_GB; 813748055; IABMV/1)	2025-11-06 17:49:57.529147	\N
327	100.64.0.9	2025-11-08	Mozilla/5.0 (Linux; Android 14; SM-A525F Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (34/14; 420dpi; 1080x2186; samsung; SM-A525F; a52q; qcom; en_GB; 818801753; IABMV/1)	2025-11-08 15:45:49.711109	\N
342	100.64.0.20	2025-11-09	Mozilla/5.0 (Linux; Android 9; SAMSUNG SM-G955F Build/PPR1.180610.011) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/9.4 Chrome/67.0.3396.87 Mobile Safari/537.36	2025-11-09 21:08:03.833117	\N
295	100.64.0.3	2025-11-04	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 404.0.0.27.81 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 812595035)	2025-11-04 10:00:32.278832	\N
296	100.64.0.4	2025-11-04	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-04 15:02:56.428431	\N
298	100.64.0.2	2025-11-05	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-05 03:26:17.131221	\N
303	100.64.0.16	2025-11-06	Instagram 403.0.0.28.80 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; 808786605) AppleWebKit/420+	2025-11-06 11:12:44.991908	\N
309	100.64.0.2	2025-11-06	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (34/14; 320dpi; 720x1440; realme; RMX3930; RE6054; ums9230_latte; en_PK; 813748055; IABMV/1)	2025-11-06 14:33:31.965424	\N
312	100.64.0.2	2025-11-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-11-07 12:18:29.157895	\N
313	100.64.0.31	2025-11-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-11-07 12:18:37.668259	\N
319	100.64.0.2	2025-11-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22G100 Instagram 405.1.0.27.75 (iPhone14,5; iOS 18_6_2; en_GB; en-GB; scale=3.00; 1170x2532; IABMV/1; 817093285)	2025-11-07 16:23:55.011687	\N
320	100.64.0.9	2025-11-07	Mozilla/5.0 (Linux; Android 12; Infinix X6817 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (31/12; 320dpi; 720x1472; INFINIX/Infinix; Infinix X6817; Infinix-X6817; mt6769; en_US; 818801753; IABMV/1)	2025-11-07 18:21:26.189469	\N
321	100.64.0.24	2025-11-08	Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3	2025-11-08 02:42:55.922565	\N
323	100.64.0.16	2025-11-08	Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA615981) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.3161.98 Mobile Safari/537.3	2025-11-08 02:42:55.939085	\N
325	100.64.0.6	2025-11-08	Mozilla/5.0 (Linux; Android 10; TECNO KD7 Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (29/10; 320dpi; 720x1424; TECNO MOBILE LIMITED/TECNO; TECNO KD7; TECNO-KD7; mt6765; en_US; 818801753; IABMV/1)	2025-11-08 08:42:52.363158	\N
335	100.64.0.28	2025-11-09	Instagram 404.0.0.27.81 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; 812595035) AppleWebKit/420+	2025-11-09 15:03:18.678346	\N
336	100.64.0.6	2025-11-09	Mozilla/5.0 (Linux; Android 12; vivo 1915 Build/SP1A.210812.003; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (31/12; 480dpi; 1080x2130; vivo; vivo 1915; 1915; mt6768; en_US; 818801737; IABMV/1)	2025-11-09 18:09:14.040051	\N
340	100.64.0.6	2025-11-09	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36	2025-11-09 18:32:27.959508	\N
300	100.64.0.28	2025-11-05	Mozilla/5.0 (iPod; U; CPU iPhone OS 2_2_1 like Mac OS X; en-us) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5H11a Safari/525.20	2025-11-05 11:17:44.299563	\N
307	100.64.0.9	2025-11-06	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-11-06 13:17:18.319184	\N
308	100.64.0.6	2025-11-06	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 818801656; IABMV/1)	2025-11-06 14:13:29.033292	\N
311	100.64.0.31	2025-11-07	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (34/14; 320dpi; 720x1440; realme; RMX3930; RE6054; ums9230_latte; en_PK; 813748055; IABMV/1)	2025-11-07 07:46:56.166354	\N
322	100.64.0.24	2025-11-08	Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3	2025-11-08 02:42:55.922523	\N
332	100.64.0.12	2025-11-09	Mozilla/5.0 (iPad; CPU OS 13_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/76.0.3809.81 Mobile/15E148 Safari/605.1	2025-11-09 13:08:26.55123	\N
338	100.64.0.9	2025-11-09	Mozilla/5.0 (Linux; Android 12; vivo 1915 Build/SP1A.210812.003; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (31/12; 480dpi; 1080x2130; vivo; vivo 1915; 1915; mt6768; en_US; 818801737; IABMV/1)	2025-11-09 18:16:54.020148	\N
301	100.64.0.3	2025-11-05	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1 OPT/6.1.7	2025-11-05 13:15:03.49969	\N
302	100.64.0.6	2025-11-06	Mozilla/5.0 (Linux; Android 12; Infinix X6817 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.56 Mobile Safari/537.36 Instagram 404.0.0.48.76 Android (31/12; 320dpi; 720x1472; INFINIX/Infinix; Infinix X6817; Infinix-X6817; mt6769; en_US; 813748055; IABMV/1)	2025-11-06 09:43:28.251868	\N
304	100.64.0.9	2025-11-06	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A341 Instagram 400.1.0.29.75 (iPhone15,2; iOS 26_0; en_GB; en-GB; scale=3.00; 1179x2556; IABMV/1; 799622199)	2025-11-06 11:26:15.748212	\N
305	100.64.0.9	2025-11-06	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B5059e Instagram 404.0.0.27.81 (iPhone14,3; iOS 26_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 812595035)	2025-11-06 11:40:49.153996	\N
315	100.64.0.6	2025-11-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22G100 Instagram 403.0.0.28.80 (iPhone11,2; iOS 18_6_2; en_GB; en-GB; scale=3.00; 1125x2436; IABMV/1; 808786605)	2025-11-07 15:03:32.390032	\N
317	100.64.0.3	2025-11-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22G100 Instagram 405.1.0.27.75 (iPhone14,5; iOS 18_6_2; en_GB; en-GB; scale=3.00; 1170x2532; IABMV/1; 817093285)	2025-11-07 16:20:42.358917	\N
318	100.64.0.6	2025-11-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22G100 Instagram 405.1.0.27.75 (iPhone14,5; iOS 18_6_2; en_GB; en-GB; scale=3.00; 1170x2532; IABMV/1; 817093285)	2025-11-07 16:23:08.81769	\N
324	100.64.0.23	2025-11-08	Mozilla/5.0 (iPhone13,2; U; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 Mobile/15E148 Safari/602.1	2025-11-08 02:44:14.054921	\N
326	100.64.0.9	2025-11-08	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-08 15:03:43.960222	\N
331	100.64.0.4	2025-11-09	Mozilla/5.0 (Linux; Android 6.0.1; Redmi 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36	2025-11-09 13:08:26.236681	\N
333	100.64.0.26	2025-11-09	Mozilla/5.0 (Linux; Android 8.0.0; LND-AL30) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.89 Mobile Safari/537.36	2025-11-09 14:23:42.106201	\N
334	100.64.0.11	2025-11-09	Mozilla/5.0 (Linux; Android 9; POT-LX1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.89 Mobile Safari/537.36	2025-11-09 14:23:52.657798	\N
337	100.64.0.6	2025-11-09	Mozilla/5.0 (Linux; Android 12; Infinix X6817 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (31/12; 320dpi; 720x1472; INFINIX/Infinix; Infinix X6817; Infinix-X6817; mt6769; en_US; 818801753; IABMV/1)	2025-11-09 18:15:09.974609	\N
339	100.64.0.3	2025-11-09	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-09 18:30:01.633683	\N
341	100.64.0.2	2025-11-09	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36	2025-11-09 18:32:38.016883	\N
343	100.64.0.28	2025-11-09	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-09 21:28:35.273746	\N
314	100.64.0.16	2025-11-07	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-07 15:03:06.857138	\N
316	100.64.0.23	2025-11-07	Mozilla/5.0 (Linux; Android 15; SM-A356E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 403.0.0.49.74 Android (35/15; 450dpi; 1080x2340; samsung; SM-A356E; a35x; s5e8835; en_IN; 810081257; IABMV/1)	2025-11-07 15:26:17.097452	\N
328	100.64.0.6	2025-11-08	Mozilla/5.0 (Linux; Android 14; SM-A525F Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (34/14; 420dpi; 1080x2186; samsung; SM-A525F; a52q; qcom; en_GB; 818801753; IABMV/1)	2025-11-08 15:46:04.197544	\N
329	100.64.0.9	2025-11-09	Mozilla/5.0 (Linux; Android 13; SM-A325F Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (33/13; 420dpi; 1080x2281; samsung; SM-A325F; a32; mt6769t; en_GB; 818801753; IABMV/1)	2025-11-09 12:38:13.83809	\N
330	100.64.0.31	2025-11-09	Mozilla/5.0 (Linux; Android 13; SM-A325F Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (33/13; 420dpi; 1080x2281; samsung; SM-A325F; a32; mt6769t; en_GB; 818801753; IABMV/1)	2025-11-09 12:38:52.171249	\N
344	100.64.0.15	2025-11-10	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-10 08:41:07.446879	\N
345	100.64.0.16	2025-11-10	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-10 08:41:08.447264	\N
346	100.64.0.4	2025-11-10	Mozilla/5.0 (Linux; Android 12; vivo 1915) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.7.2.0	2025-11-10 13:04:46.909449	\N
347	100.64.0.6	2025-11-10	Mozilla/5.0 (Linux; Android 12; vivo 1915) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.7.2.0	2025-11-10 13:05:35.706155	\N
348	100.64.0.3	2025-11-10	Mozilla/5.0 (Linux; Android 12; vivo 1915) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.7.2.0	2025-11-10 13:08:27.308926	\N
349	100.64.0.17	2025-11-10	Mozilla/5.0 (Linux; Android 10; TECNO KD7 Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (29/10; 320dpi; 720x1424; TECNO MOBILE LIMITED/TECNO; TECNO KD7; TECNO-KD7; mt6765; en_US; 818801753; IABMV/1)	2025-11-10 14:42:28.025895	\N
350	100.64.0.16	2025-11-10	Mozilla/5.0 (Linux; Android 10; TECNO KD7 Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (29/10; 320dpi; 720x1424; TECNO MOBILE LIMITED/TECNO; TECNO KD7; TECNO-KD7; mt6765; en_US; 818801753; IABMV/1)	2025-11-10 14:42:40.578958	\N
351	100.64.0.3	2025-11-10	Mozilla/5.0 (Linux; Android 12; vivo 1915) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.9.0.4	2025-11-10 15:07:59.31983	\N
352	100.64.0.5	2025-11-10	Mozilla/5.0 (Linux; Android 12; vivo 1915) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.9.0.4	2025-11-10 15:10:59.443435	\N
353	100.64.0.18	2025-11-10	Mozilla/5.0 (Linux; Android 12; vivo 1915) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.9.0.4	2025-11-10 15:13:08.731031	\N
354	100.64.0.22	2025-11-11	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-11 09:39:20.722751	\N
355	100.64.0.23	2025-11-11	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	2025-11-11 09:39:22.360289	\N
356	100.64.0.14	2025-11-11	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-11-11 12:15:31.443287	\N
357	100.64.0.8	2025-11-11	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-11-11 12:15:51.011261	\N
358	100.64.0.21	2025-11-11	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-11-11 23:21:17.762866	\N
359	100.64.0.25	2025-11-11	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-11-11 23:21:24.340763	\N
360	100.64.0.19	2025-11-12	Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36	2025-11-12 02:48:44.643765	\N
361	100.64.0.27	2025-11-12	Mozilla/5.0 (Linux; Android 9; REVVLRY) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36	2025-11-12 10:16:57.842075	\N
362	100.64.0.24	2025-11-12	Mozilla/5.0 (Linux; Android 8.1.0; Infinix X624B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Mobile Safari/537.36	2025-11-12 10:17:10.848578	\N
363	100.64.0.18	2025-11-12	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-11-12 11:33:39.610834	\N
364	100.64.0.16	2025-11-12	Mozilla/5.0 (Linux; U; Android 2.0; en-us; Milestone Build/ SHOLS_U2_01.03.1) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17	2025-11-12 19:16:05.687244	\N
365	100.64.0.2	2025-11-13	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-11-13 04:55:31.381474	\N
366	100.64.0.25	2025-11-13	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-13 06:17:09.496052	\N
367	100.64.0.10	2025-11-13	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-13 15:55:30.040386	\N
368	100.64.0.6	2025-11-13	Mozilla/5.0 (Linux; Android 6.0.1; CPH1701 Build/MMB29M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/106.0.5249.126 Mobile Safari/537.36 Instagram 278.0.0.22.117 Android (23/6.0.1; 320dpi; 720x1280; OPPO; CPH1701; CPH1701; qcom; en_US; 471827227)	2025-11-13 19:24:05.877386	\N
369	100.64.0.18	2025-11-13	Mozilla/5.0 (Linux; Android 6.0.1; CPH1701 Build/MMB29M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/106.0.5249.126 Mobile Safari/537.36 Instagram 278.0.0.22.117 Android (23/6.0.1; 320dpi; 720x1280; OPPO; CPH1701; CPH1701; qcom; en_US; 471827227)	2025-11-13 19:24:19.522646	\N
370	100.64.0.2	2025-11-13	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-11-13 21:59:07.768213	\N
371	100.64.0.31	2025-11-14	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-14 12:41:53.974624	\N
372	100.64.0.2	2025-11-14	Mozilla/5.0 (Linux; Android 12; M2102J20SG Build/SKQ1.211006.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/118.0.0.0 Mobile Safari/537.36 musical_ly_2023002030 JsSdk/1.0 NetType/WIFI Channel/googleplay AppName/musical_ly app_version/30.2.3 ByteLocale/ru-RU ByteFullLocale/ru-RU Region/US Spark/1.3.5.7-bugfix AppVersion/30.2.3 BytedanceWebview/d8a21c6	2025-11-14 13:21:38.348526	\N
375	100.64.0.14	2025-11-15	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-11-15 07:03:38.467894	\N
383	100.64.0.24	2025-11-15	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36 OPR/92.0.0.0	2025-11-15 16:31:55.007648	\N
395	100.64.0.16	2025-11-16	Mozilla/5.0 (Linux; Android 11; Infinix PR652B Build/RP1A.201005.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (30/11; 320dpi; 720x1432; Infinix; Infinix PR652B; Infinix-PR652B; PR652B; en_US; 822918285; IABMV/1)	2025-11-16 15:41:49.192187	\N
402	100.64.0.23	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 822918295; IABMV/1) NV/1	2025-11-17 12:30:14.516007	\N
404	100.64.0.16	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 822918295; IABMV/1)	2025-11-17 12:35:55.188611	\N
405	100.64.0.19	2025-11-17	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-11-17 12:37:08.640489	\N
406	100.64.0.28	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-A336E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.102 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 450dpi; 1080x2400; samsung; SM-A336E; a33x; s5e8825; en_GB; 822917882; IABMV/1)	2025-11-17 12:49:23.117626	\N
415	100.64.0.21	2025-11-19	Mozilla/5.0 (Linux; Android 10; Infinix X690B Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (29/10; 320dpi; 720x1464; INFINIX MOBILITY LIMITED/Infinix; Infinix X690B; Infinix-X690B; mt6768; en_US; 822918295; IABMV/1)	2025-11-19 13:05:42.43794	\N
416	100.64.0.11	2025-11-20	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-11-20 07:55:37.55688	\N
418	100.64.0.12	2025-11-22	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-11-22 19:03:06.002402	\N
421	100.64.0.10	2025-11-24	Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36	2025-11-24 15:35:30.113936	\N
373	100.64.0.5	2025-11-14	Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/21E236 Instagram 405.1.0.27.75 (iPhone14,3; iOS 17_4_1; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 817093285)	2025-11-14 19:04:20.595977	\N
378	100.64.0.6	2025-11-15	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23C5027f Instagram 406.1.0.48.76 (iPhone14,3; iOS 26_2; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 823565292)	2025-11-15 14:13:24.092959	\N
379	100.64.0.6	2025-11-15	Mozilla/5.0 (Linux; Android 10; Infinix X680B Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (29/10; 320dpi; 720x1480; INFINIX MOBILITY LIMITED/Infinix; Infinix X680B; Infinix-X680B; mt6762; en_US; 818801753; IABMV/1)	2025-11-15 15:54:33.027577	\N
382	100.64.0.4	2025-11-15	Mozilla/5.0 (Linux; Android 10; Infinix X680B Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (29/10; 320dpi; 720x1480; INFINIX MOBILITY LIMITED/Infinix; Infinix X680B; Infinix-X680B; mt6762; en_US; 818801753; IABMV/1) NV/1	2025-11-15 16:00:43.080419	\N
386	100.64.0.19	2025-11-16	Mozilla/5.0 (Linux; Android 14; TECNO KL6 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (34/14; 480dpi; 1080x2352; TECNO; TECNO KL6; TECNO-KL6; mt6768; en_US; 822918295; IABMV/1)	2025-11-16 02:27:45.254693	\N
392	100.64.0.18	2025-11-16	Mozilla/5.0 (Linux; Android 13; SM-A325F Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.102 Mobile Safari/537.36 Instagram 407.0.0.22.243 Android (33/13; 420dpi; 1080x2281; samsung; SM-A325F; a32; mt6769t; en_GB; 825756039; IABMV/1)	2025-11-16 13:50:44.610438	\N
374	100.64.0.4	2025-11-15	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23B85 Instagram 405.1.0.27.75 (iPhone15,2; iOS 26_1; en_GB; en-GB; scale=3.00; 1179x2556; IABMV/1; 817093285)	2025-11-15 03:08:29.803209	\N
376	100.64.0.5	2025-11-15	Mozilla/5.0 (Linux; Android 14; SM-A165F Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (34/14; 450dpi; 1080x2109; samsung; SM-A165F; a16; mt6789; en_US; 822918295; IABMV/1)	2025-11-15 12:40:10.931631	\N
380	100.64.0.18	2025-11-15	Mozilla/5.0 (Linux; Android 10; Infinix X680B Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (29/10; 320dpi; 720x1480; INFINIX MOBILITY LIMITED/Infinix; Infinix X680B; Infinix-X680B; mt6762; en_US; 818801753; IABMV/1)	2025-11-15 15:55:03.885133	\N
385	100.64.0.3	2025-11-16	Mozilla/5.0 (Linux; Android 14; TECNO KL6 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (34/14; 480dpi; 1080x2352; TECNO; TECNO KL6; TECNO-KL6; mt6768; en_US; 822918295; IABMV/1)	2025-11-16 02:27:28.41517	\N
387	100.64.0.20	2025-11-16	Mozilla/5.0 (Linux; Android 14; TECNO KL6 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (34/14; 480dpi; 1080x2352; TECNO; TECNO KL6; TECNO-KL6; mt6768; en_US; 822918295; IABMV/1)	2025-11-16 02:27:46.766801	\N
390	100.64.0.3	2025-11-16	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23C5027f Instagram 406.1.0.48.76 (iPhone14,3; iOS 26_2; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 823565292)	2025-11-16 13:04:02.711762	\N
394	100.64.0.19	2025-11-16	Mozilla/5.0 (Linux; Android 13; Infinix X6836 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (33/13; 480dpi; 1080x2232; INFINIX/Infinix; Infinix X6836; Infinix-X6836; mt6768; en_US; 822918295; IABMV/1) NV/1	2025-11-16 15:04:31.946286	\N
396	100.64.0.28	2025-11-16	Mozilla/5.0 (Linux; Android 11; Infinix PR652B Build/RP1A.201005.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.122 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (30/11; 320dpi; 720x1432; Infinix; Infinix PR652B; Infinix-PR652B; PR652B; en_US; 822918285; IABMV/1)	2025-11-16 15:42:28.075617	\N
399	100.64.0.21	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-A336E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.102 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 450dpi; 1080x2400; samsung; SM-A336E; a33x; s5e8825; en_GB; 822917882; IABMV/1)	2025-11-17 01:50:14.654239	\N
403	100.64.0.18	2025-11-17	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1	2025-11-17 12:34:02.465087	\N
409	100.64.0.6	2025-11-17	Mozilla/5.0 (Linux; Android 14; TECNO KL6 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (34/14; 480dpi; 1080x2352; TECNO; TECNO KL6; TECNO-KL6; mt6768; en_US; 822918295; IABMV/1)	2025-11-17 18:54:47.842567	\N
411	100.64.0.16	2025-11-17	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A355 Instagram 406.1.0.48.76 (iPhone12,1; iOS 26_0_1; en_GB; en-GB; scale=2.00; 828x1792; IABMV/1; 823565292)	2025-11-17 19:32:53.613162	\N
413	100.64.0.15	2025-11-18	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	2025-11-18 16:43:08.70033	\N
419	100.64.0.28	2025-11-23	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2025-11-23 00:35:51.012346	\N
377	100.64.0.4	2025-11-15	Mozilla/5.0 (iPhone; CPU iPhone OS 15_8_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/19H394 Instagram 406.1.0.48.76 (iPhone9,4; iOS 15_8_5; en_GB; en-GB; scale=3.00; 1242x2208; IABMV/1; 823565292)	2025-11-15 13:15:05.121568	\N
388	100.64.0.22	2025-11-16	Instagram 406.1.0.48.76 (iPhone9,4; iOS 15_8_5; en_GB; en-GB; scale=3.00; 1242x2208; 823565292) AppleWebKit/420+	2025-11-16 12:39:28.728225	\N
391	100.64.0.3	2025-11-16	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1	2025-11-16 13:06:51.22563	\N
407	100.64.0.25	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-A336E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.102 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 450dpi; 1080x2400; samsung; SM-A336E; a33x; s5e8825; en_GB; 822917882; IABMV/1)	2025-11-17 12:49:40.95001	\N
414	100.64.0.29	2025-11-19	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36	2025-11-19 01:12:30.82918	\N
417	100.64.0.3	2025-11-21	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A355 Instagram 407.0.0.31.80 (iPhone15,3; iOS 26_0_1; en_GB; en-GB; scale=3.00; 1290x2796; IABMV/1; 826175880)	2025-11-21 05:40:44.855126	\N
420	100.64.0.29	2025-11-23	Instagram 406.1.0.48.76 (iPhone14,3; iOS 26_2; en_GB; en-GB; scale=3.00; 1284x2778; 823565292) AppleWebKit/420+	2025-11-23 17:45:45.626908	\N
381	100.64.0.4	2025-11-15	Mozilla/5.0 (Linux; Android 10; Infinix X680B Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.91 Mobile Safari/537.36 Instagram 405.1.0.57.77 Android (29/10; 320dpi; 720x1480; INFINIX MOBILITY LIMITED/Infinix; Infinix X680B; Infinix-X680B; mt6762; en_US; 818801753; IABMV/1)	2025-11-15 15:58:37.278726	\N
384	100.64.0.18	2025-11-15	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-11-15 16:32:06.288478	\N
389	100.64.0.21	2025-11-16	Instagram 406.1.0.48.76 (iPhone9,4; iOS 15_8_5; en_GB; en-GB; scale=3.00; 1242x2208; 823565292) AppleWebKit/420+	2025-11-16 12:40:10.989866	\N
393	100.64.0.3	2025-11-16	Mozilla/5.0 (Linux; Android 13; Infinix X6836 Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (33/13; 480dpi; 1080x2232; INFINIX/Infinix; Infinix X6836; Infinix-X6836; mt6768; en_US; 822918295; IABMV/1)	2025-11-16 15:04:21.627139	\N
397	100.64.0.28	2025-11-16	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23A355 Instagram 406.1.0.48.76 (iPhone15,3; iOS 26_0_1; en_GB; en-GB; scale=3.00; 1290x2796; IABMV/1; 823565292)	2025-11-16 18:01:56.586256	\N
398	100.64.0.5	2025-11-16	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1	2025-11-16 18:41:20.312687	\N
400	100.64.0.21	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 822918295; IABMV/1)	2025-11-17 12:28:29.881932	\N
401	100.64.0.23	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 822918295; IABMV/1)	2025-11-17 12:28:49.513506	\N
408	100.64.0.22	2025-11-17	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 822918295; IABMV/1)	2025-11-17 12:58:05.633281	\N
410	100.64.0.6	2025-11-17	Mozilla/5.0 (Linux; Android 14; TECNO KL6 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.142 Mobile Safari/537.36 Instagram 406.0.0.58.159 Android (34/14; 480dpi; 1080x2352; TECNO; TECNO KL6; TECNO-KL6; mt6768; en_US; 822918295; IABMV/1) NV/5	2025-11-17 18:55:11.295994	\N
412	100.64.0.4	2025-11-18	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23C5027f Instagram 406.1.0.48.76 (iPhone14,3; iOS 26_2; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 823565292)	2025-11-18 12:16:53.872782	\N
422	100.64.0.14	2025-11-25	Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36	2025-11-25 11:16:03.582414	\N
423	100.64.0.18	2025-11-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	2025-11-26 01:54:02.850474	\N
424	100.64.0.3	2025-11-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148	2025-11-26 13:31:35.453832	\N
425	100.64.0.22	2025-11-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-11-26 23:16:37.947279	\N
426	100.64.0.29	2025-11-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-11-26 23:16:48.626758	\N
427	100.64.0.28	2025-11-26	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2025-11-26 23:16:49.240794	\N
428	100.64.0.16	2025-11-28	Mozilla/5.0 (Linux; Android 9; Redmi Note 6 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.143 Mobile Safari/537.36	2025-11-28 01:36:23.589441	\N
429	100.64.0.23	2025-11-28	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-11-28 09:51:21.94386	\N
430	100.64.0.2	2025-11-29	Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36	2025-11-29 19:42:26.577784	\N
431	100.64.0.6	2025-11-30	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.212 Mobile Safari/537.36 Instagram 408.0.0.51.78 Android (34/14; 320dpi; 720x1440; realme; RMX3930; RE6054; ums9230_latte; en_PK; 832162570; IABMV/1)	2025-11-30 07:55:05.396972	\N
432	100.64.0.18	2025-11-30	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.212 Mobile Safari/537.36 Instagram 408.0.0.51.78 Android (34/14; 320dpi; 720x1440; realme; RMX3930; RE6054; ums9230_latte; en_PK; 832162570; IABMV/1)	2025-11-30 07:55:24.984806	\N
433	100.64.0.4	2025-11-30	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.212 Mobile Safari/537.36 Instagram 408.0.0.51.78 Android (34/14; 320dpi; 720x1440; realme; RMX3930; RE6054; ums9230_latte; en_PK; 832162570; IABMV/1)	2025-11-30 07:55:57.154631	\N
434	100.64.0.21	2025-11-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2025-11-30 07:56:23.133414	\N
435	100.64.0.18	2025-11-30	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-11-30 07:56:30.649382	\N
436	100.64.0.16	2025-11-30	Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) CriOS/30.0.1599.12 Mobile/11A465 Safari/8536.25 (3B92C18B-D9DE-4CB7-A02A-22FD2AF17C8F)	2025-11-30 20:11:13.111532	\N
437	100.64.0.16	2025-11-30	Mozilla/5.0 (Linux; U; Android 1.5; de-de; Galaxy Build/CUPCAKE) AppleWebKit/528.5  (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1	2025-11-30 21:29:35.61895	\N
438	100.64.0.12	2025-12-04	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-12-04 02:36:59.557423	\N
439	100.64.0.29	2025-12-05	Mozilla/5.0 (Android 4.4.2; Tablet; rv:55.0) Gecko/55.0 Firefox/55.0	2025-12-05 00:26:59.311943	\N
440	100.64.0.16	2025-12-05	Mozilla/5.0 (Linux; Android 5.1.1; 5065N Build/LMY47V) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.95 Mobile Safari/537.36	2025-12-05 00:27:01.38096	\N
441	100.64.0.29	2025-12-05	Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543 Safari/419.3	2025-12-05 00:27:01.934281	\N
442	100.64.0.22	2025-12-05	Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_5 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8L1 Safari/6533.18.5	2025-12-05 00:27:03.623147	\N
443	100.64.0.21	2025-12-05	Mozilla/5.0 (Linux; U; Android 4.4.3; en-us; KFTHWA Build/KTU84M) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.68 like Chrome/39.0.2171.93 Safari/537.36	2025-12-05 00:27:06.473689	\N
444	100.64.0.22	2025-12-05	Mozilla/5.0 (Linux; Android 9; ELE-L09) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36	2025-12-05 02:31:39.050499	\N
445	100.64.0.10	2025-12-05	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-12-05 05:52:09.725877	\N
446	100.64.0.18	2025-12-05	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-12-05 21:03:46.678165	\N
447	100.64.0.29	2025-12-07	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.212 Mobile Safari/537.36 Instagram 408.0.0.51.78 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 832162521; IABMV/1)	2025-12-07 16:01:14.793948	\N
453	100.64.0.4	2025-12-09	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-09 21:09:35.236552	\N
454	100.64.0.5	2025-12-09	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-09 21:10:44.459839	\N
455	100.64.0.3	2025-12-09	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-09 21:12:45.199839	\N
456	100.64.0.18	2025-12-09	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-09 21:19:59.240397	\N
460	100.64.0.27	2025-12-13	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-13 18:07:34.397467	\N
462	100.64.0.3	2025-12-14	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.103 Mobile Safari/537.36 Instagram 409.0.0.48.170 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 839812174; IABMV/1)	2025-12-14 01:19:26.148752	\N
463	100.64.0.6	2025-12-14	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.103 Mobile Safari/537.36 Instagram 409.0.0.48.170 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 839812174; IABMV/1)	2025-12-14 01:19:48.692988	\N
464	100.64.0.18	2025-12-14	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.103 Mobile Safari/537.36 Instagram 409.0.0.48.170 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 839812174; IABMV/1)	2025-12-14 01:19:55.272337	\N
465	100.64.0.5	2025-12-14	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.103 Mobile Safari/537.36 Instagram 409.0.0.48.170 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 839812174; IABMV/1)	2025-12-14 01:20:12.785346	\N
448	100.64.0.22	2025-12-07	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.212 Mobile Safari/537.36 Instagram 408.0.0.51.78 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 832162521; IABMV/1)	2025-12-07 16:01:22.134474	\N
449	100.64.0.25	2025-12-07	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.212 Mobile Safari/537.36 Instagram 408.0.0.51.78 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 832162521; IABMV/1)	2025-12-07 16:01:27.816597	\N
450	100.64.0.16	2025-12-07	Mozilla/5.0 (Linux; Android 15; SM-G990E Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/142.0.7444.212 Mobile Safari/537.36 Instagram 408.0.0.51.78 Android (35/15; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 832162521; IABMV/1)	2025-12-07 16:01:31.877883	\N
451	100.64.0.7	2025-12-07	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-12-07 18:49:36.673624	\N
458	100.64.0.14	2025-12-10	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-10 17:32:29.281765	\N
452	100.64.0.17	2025-12-09	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-12-09 21:06:48.420855	\N
457	100.64.0.23	2025-12-10	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-10 05:59:37.41321	\N
461	100.64.0.6	2025-12-13	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.103 Mobile Safari/537.36 Instagram 409.0.0.48.170 Android (34/14; 320dpi; 720x1440; realme; RMX3930; RE6054; ums9230_latte; en_PK; 839812233; IABMV/1)	2025-12-13 20:03:39.085174	\N
459	100.64.0.28	2025-12-10	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2025-12-10 21:07:58.2305	\N
466	100.64.0.5	2025-12-14	Mozilla/5.0 (Linux; Android 11; TECNO LE6 Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.103 Mobile Safari/537.36 Instagram 409.0.0.48.170 Android (30/11; 320dpi; 720x1472; TECNO MOBILE LIMITED/TECNO; TECNO LE6; TECNO-LE6; mt6762; en_US; 839812174; IABMV/1) NV/5	2025-12-14 01:20:27.926143	\N
467	100.64.0.16	2025-12-14	Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Brave/1 Mobile/15E148 Safari/604.1	2025-12-14 03:00:06.265604	\N
468	100.64.0.4	2025-12-20	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1	2025-12-20 14:14:03.721148	\N
469	100.64.0.8	2025-12-20	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-20 14:15:49.276477	\N
470	100.64.0.28	2025-12-21	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2025-12-21 10:34:51.184917	\N
471	100.64.0.10	2025-12-21	Mozilla/5.0 (Linux; Android 16; SM-G990E Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.34 Mobile Safari/537.36 Instagram 410.1.0.63.71 Android (36/16; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 846519237; IABMV/1)	2025-12-21 12:13:48.575559	\N
472	100.64.0.3	2025-12-21	Mozilla/5.0 (Linux; Android 16; SM-G990E Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.34 Mobile Safari/537.36 Instagram 410.1.0.63.71 Android (36/16; 480dpi; 1080x2340; samsung; SM-G990E; r9s; exynos2100; en_GB; 846519237; IABMV/1)	2025-12-21 12:14:03.440418	\N
473	100.64.0.26	2025-12-21	Mozilla/5.0 (Linux; Android 8.1.0; SM-G390F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.89 Mobile Safari/537.36	2025-12-21 16:55:18.310287	\N
474	100.64.0.31	2025-12-21	Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/76.0.3809.81 Mobile/15E148 Safari/605.1	2025-12-21 17:06:45.474576	\N
475	100.64.0.31	2025-12-21	Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25	2025-12-21 17:07:44.515845	\N
476	100.64.0.4	2025-12-21	Mozilla/5.0 (Linux; Android 16; SM-A065F Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.34 Mobile Safari/537.36 Instagram 410.1.0.63.71 Android (36/16; 300dpi; 720x1600; samsung; SM-A065F; a06; mt6768; en_GB; 846519237; IABMV/1)	2025-12-21 17:31:03.286959	\N
477	100.64.0.2	2025-12-21	Mozilla/5.0 (Linux; Android 16; SM-A065F Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.34 Mobile Safari/537.36 Instagram 410.1.0.63.71 Android (36/16; 300dpi; 720x1600; samsung; SM-A065F; a06; mt6768; en_GB; 846519237; IABMV/1)	2025-12-21 17:31:33.495304	\N
478	100.64.0.2	2025-12-21	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23C54 Instagram 410.0.0.29.70 (iPhone14,3; iOS 26_2; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 843189213) Safari/604.1	2025-12-21 17:35:11.168864	\N
479	100.64.0.15	2025-12-21	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-12-21 22:36:10.587691	\N
480	100.64.0.17	2025-12-24	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-12-24 17:52:23.799127	\N
481	100.64.0.28	2025-12-26	Mozilla/5.0 (Linux; Android 12; SAMSUNG SM-A415F) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/23.0 Chrome/115.0.0.0 Mobile Safari/537.3	2025-12-26 12:45:04.828737	\N
482	100.64.0.31	2025-12-27	Mozilla/5.0 (iPhone; CPU iPhone OS 16_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1	2025-12-27 22:14:42.495771	\N
483	100.64.0.28	2025-12-27	Mozilla/5.0 (iPhone; CPU iPhone OS 16_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1	2025-12-27 22:14:53.301786	\N
484	100.64.0.10	2025-12-28	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	2025-12-28 11:25:06.114901	\N
485	100.64.0.18	2025-12-28	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23D5089e Instagram 410.1.0.36.70 (iPhone14,3; iOS 26_3; en_GB; en-GB; scale=3.00; 1284x2778; IABMV/1; 849447290) Safari/604.1	2025-12-28 19:51:05.790733	\N
486	100.64.0.4	2025-12-29	Mozilla/5.0 (Linux; Android 12) Chrome/111.0 Mobile Safari/537.36	2025-12-29 03:22:37.459914	\N
487	100.64.0.17	2025-12-30	Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36	2025-12-30 16:42:44.254246	\N
488	100.64.0.16	2025-12-31	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2025-12-31 14:01:55.207794	\N
489	100.64.0.10	2026-01-01	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2026-01-01 00:38:40.007263	\N
490	100.64.0.15	2026-01-01	Instagram 410.1.0.36.70 (iPhone14,3; iOS 26_3; en_GB; en-GB; scale=3.00; 1284x2778; 849447290) AppleWebKit/420+	2026-01-01 16:01:37.378979	\N
491	100.64.0.17	2026-01-02	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Mobile/15E148 Safari/604.1	2026-01-02 00:11:27.398306	\N
492	100.64.0.12	2026-01-02	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Mobile/15E148 Safari/604.1	2026-01-02 00:11:30.160435	\N
493	100.64.0.21	2026-01-02	Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36	2026-01-02 04:27:52.080351	\N
494	100.64.0.28	2026-01-02	Mozilla/5.0 (Linux; Android 9; SM-M305F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36	2026-01-02 09:27:01.870695	\N
495	100.64.0.6	2026-01-02	Mozilla/5.0 (Linux; Android 9; vivo 1805) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.101 Mobile Safari/537.36	2026-01-02 15:28:28.485558	\N
496	100.64.0.30	2026-01-02	Mozilla/5.0 (Linux; U; Android 2.2; en-us; ADR6300 Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1	2026-01-02 15:28:41.723691	\N
497	100.64.0.7	2026-01-02	Mozilla/5.0 (Linux; Android 9; ANE-LX1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Mobile Safari/537.36	2026-01-02 19:26:58.725994	\N
498	100.64.0.31	2026-01-02	Mozilla/5.0 (Linux; Android 5.1.1; SM-E700H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Mobile Safari/537.36	2026-01-02 19:27:42.099497	\N
499	100.64.0.28	2026-01-02	Mozilla/5.0 (Linux; Android 8.1.0; vivo 1807) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.99 Mobile Safari/537.36	2026-01-02 19:27:42.163421	\N
500	100.64.0.5	2026-01-02	Mozilla/5.0 (iPhone; CPU iPhone OS 26_1_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/399.2.845414227 Mobile/15E148 Safari/604.1	2026-01-02 20:18:41.669908	\N
504	100.64.0.26	2026-01-04	Mozilla/5.0 (Linux; Android 10; Pixel 3 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Mobile Safari/537.36	2026-01-04 17:07:50.110321	\N
501	100.64.0.28	2026-01-02	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)	2026-01-02 20:18:42.326769	\N
503	100.64.0.17	2026-01-04	Instagram 410.1.0.36.70 (iPhone14,3; iOS 26_3; en_GB; en-GB; scale=3.00; 1284x2778; 849447290) AppleWebKit/420+	2026-01-04 16:25:34.490185	\N
505	100.64.0.2	2026-01-04	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36	2026-01-04 19:05:32.479839	\N
508	100.64.0.10	2026-01-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Safari	2026-01-07 18:39:26.373007	\N
502	100.64.0.27	2026-01-03	Mozilla/5.0 (iPhone; CPU iPhone OS 26_1_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/399.2.845414227 Mobile/15E148 Safari/604.1	2026-01-03 15:59:34.259396	\N
506	100.64.0.24	2026-01-06	Mozilla/5.0 (Linux; Android 10; Pixel 3 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Mobile Safari/537.36	2026-01-06 11:01:06.285219	\N
511	100.64.0.3	2026-01-10	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1	2026-01-10 09:38:29.165961	\N
513	100.64.0.15	2026-01-11	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.7499.169 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2026-01-11 04:19:52.556445	\N
514	100.64.0.5	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 18_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0.1 Mobile/15E148 Safari/604.1	2026-01-11 08:40:01.571822	\N
507	100.64.0.10	2026-01-07	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2026-01-07 18:36:26.880884	\N
509	100.64.0.10	2026-01-10	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1	2026-01-10 09:30:24.56239	\N
510	100.64.0.18	2026-01-10	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1	2026-01-10 09:34:52.460783	\N
512	100.64.0.13	2026-01-10	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.7499.169 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	2026-01-10 12:03:38.662776	\N
515	202.47.48.243	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1	2026-01-11 15:48:51.702802	Mobile
516	34.198.201.66	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 15:51:13.145206	Desktop
517	178.156.187.238	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 15:56:18.180508	Desktop
518	3.12.251.153	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:01:24.074283	Desktop
519	5.161.73.160	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:06:29.327975	Desktop
520	2600:1f18:179:f900:4b7d:d1cc:2d10:211	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:11:35.161884	Desktop
521	2a01:4ff:f0:d3cd::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:16:40.554629	Desktop
522	178.156.189.249	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:21:49.736654	Desktop
523	52.87.72.16	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:32:00.879636	Desktop
524	2a01:4ff:f0:3e03::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:42:12.388206	Desktop
525	178.156.185.231	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:47:17.324534	Desktop
526	2a01:4ff:f0:e9cf::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:52:22.820134	Desktop
527	54.167.223.174	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 16:57:28.812651	Desktop
528	5.161.177.47	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 17:02:34.581046	Desktop
529	3.133.226.214	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 17:12:44.740204	Desktop
530	178.156.184.20	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 17:17:50.459723	Desktop
531	52.22.236.30	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 17:33:06.180525	Desktop
532	43.156.232.190	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 17:39:17.026587	Mobile
533	2a01:4ff:f0:b6f1::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 17:43:18.117078	Desktop
534	43.135.142.37	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 17:52:32.206768	Mobile
535	2a01:4ff:f0:efd1::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 17:53:29.357073	Desktop
536	43.157.50.58	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 18:01:56.064464	Mobile
537	52.15.147.27	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 18:03:39.043926	Desktop
538	5.161.113.195	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 18:08:43.940604	Desktop
539	43.166.132.142	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 18:13:23.791325	Mobile
540	2a01:4ff:f0:bfd::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 18:13:49.638115	Desktop
541	178.156.185.127	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 18:18:53.929812	Desktop
542	43.153.86.78	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 18:22:57.10849	Mobile
543	5.161.215.244	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 18:23:59.651029	Desktop
544	43.135.115.233	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 18:32:32.602089	Mobile
545	170.106.107.87	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 18:42:48.732705	Mobile
546	3.212.128.62	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 18:44:19.982819	Desktop
547	49.51.204.74	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 18:52:40.75392	Mobile
548	2a01:4ff:f0:5f80::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 18:54:29.934471	Desktop
549	43.156.168.214	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 19:02:14.330602	Mobile
550	3.149.57.90	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 19:04:40.222225	Desktop
551	43.159.140.236	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 19:11:29.840373	Mobile
552	129.226.174.80	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 19:22:37.771942	Mobile
558	18.116.205.62	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 20:05:59.360776	Desktop
553	43.130.67.33	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 19:30:19.276475	Mobile
554	54.87.112.51	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 19:35:28.223273	Desktop
556	170.106.192.208	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 19:52:29.859305	Mobile
559	43.157.95.239	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 20:11:39.268533	Mobile
560	5.161.194.92	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 20:21:13.766598	Desktop
562	43.157.53.115	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 20:32:52.682123	Mobile
565	5.161.117.52	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 21:42:36.967696	Desktop
566	2a01:4ff:f0:7fad::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 22:28:22.719915	Desktop
555	170.106.113.159	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 19:42:12.92999	Mobile
557	43.166.255.122	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 20:02:54.263291	Mobile
563	43.135.145.73	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 20:42:33.08019	Mobile
568	5.161.61.238	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 22:53:47.202652	Desktop
569	5.161.75.7	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 23:14:06.264212	Desktop
561	49.51.183.15	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 20:22:34.697675	Mobile
564	2600:1f18:179:f900:e8dd:eed1:a6c:183b	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 21:12:06.865245	Desktop
567	35.165.215.140	2026-01-11	Go-http-client/2.0	2026-01-11 22:50:38.681458	Desktop
570	43.157.147.3	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 23:37:26.565824	Mobile
571	2a01:4ff:f0:d283::1	2026-01-11	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-11 23:49:42.888884	Desktop
572	43.130.40.120	2026-01-11	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-11 23:50:33.318547	Mobile
573	170.106.110.146	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 00:00:45.35173	Mobile
574	54.167.223.174	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:04:58.251895	Desktop
575	2600:1f16:775:3a00:ac3:c5eb:7081:942e	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:10:03.101435	Desktop
576	43.153.76.247	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 00:14:49.080425	Mobile
577	5.161.75.7	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:15:08.738536	Desktop
578	34.198.201.66	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:20:14.213641	Desktop
579	43.153.73.200	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 00:20:41.054472	Mobile
580	5.161.61.238	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:25:19.89536	Desktop
581	43.156.202.34	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 00:29:34.86978	Mobile
582	2600:1f16:775:3a00:8c2c:2ba6:778f:5be5	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:30:25.08469	Desktop
583	5.161.177.47	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:35:30.574411	Desktop
584	3.20.63.178	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:40:36.00168	Desktop
585	170.106.143.6	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 00:40:46.886981	Mobile
586	43.128.67.187	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 00:49:30.918922	Mobile
587	3.12.251.153	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:50:46.785879	Desktop
588	178.156.189.249	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 00:55:52.401783	Desktop
589	43.130.3.120	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 01:00:26.3691	Mobile
590	52.22.236.30	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 01:00:57.596141	Desktop
591	5.161.113.195	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 01:06:02.382387	Desktop
592	43.157.50.58	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 01:08:52.216069	Mobile
593	178.156.189.113	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 01:21:17.507127	Desktop
594	5.161.194.92	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 01:26:22.705263	Desktop
595	178.156.185.127	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 01:46:42.766273	Desktop
596	3.133.226.214	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 01:51:48.337592	Desktop
597	178.156.187.238	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 01:56:52.752448	Desktop
598	52.15.147.27	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 02:01:58.571626	Desktop
599	54.87.112.51	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 02:12:09.94026	Desktop
600	5.161.117.52	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 02:32:30.718002	Desktop
601	2a01:4ff:f0:fdc7::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 02:42:40.175168	Desktop
602	3.212.128.62	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 02:47:45.282359	Desktop
603	3.149.57.90	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 03:13:09.806648	Desktop
604	2a01:4ff:f0:d3cd::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 03:43:40.904419	Desktop
605	2a01:4ff:f0:2219::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 03:48:46.438905	Desktop
606	5.161.215.244	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 04:03:59.97536	Desktop
607	2600:1f16:775:3a00:37bf:6026:e54a:f03a	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 04:19:16.892807	Desktop
608	178.156.185.231	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 04:39:36.869865	Desktop
609	5.161.73.160	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 04:44:42.226902	Desktop
610	18.116.205.62	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 05:05:02.359788	Desktop
611	52.87.72.16	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 05:20:17.101316	Desktop
612	178.156.184.20	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 05:25:22.124494	Desktop
613	43.157.179.227	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 05:40:23.330321	Mobile
614	2600:1f18:179:f900:4b7d:d1cc:2d10:211	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 05:55:52.724816	Desktop
615	178.156.181.172	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 06:51:49.794796	Desktop
616	2600:1f16:775:3a00:91ac:3120:ff38:92b5	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 07:22:22.153984	Desktop
617	2a01:4ff:f0:eccb::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 09:24:32.769647	Desktop
618	2600:1f18:179:f900:2406:9399:4ae6:c5d3	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 09:39:48.267577	Desktop
620	43.135.183.82	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 11:15:45.080576	Mobile
621	2a01:4ff:f0:9c5f::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 11:46:55.776957	Desktop
626	45.41.180.156	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1	2026-01-12 13:40:26.597272	Mobile
637	3.212.128.62	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:11:32.496527	Desktop
642	2600:1f16:775:3a00:dbbe:36b0:3c45:da32	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:36:57.9963	Desktop
644	2600:1f18:179:f900:2406:9399:4ae6:c5d3	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:47:09.096111	Desktop
645	178.156.187.238	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:52:13.834178	Desktop
647	2a01:4ff:f0:e516::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:02:25.557962	Desktop
654	34.90.72.216	2026-01-13	Scrapy/2.13.4 (+https://scrapy.org)	2026-01-13 01:42:03.25683	Desktop
659	54.167.223.174	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 02:28:59.659448	Desktop
661	3.20.63.178	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 02:44:15.858851	Desktop
662	178.156.185.231	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 03:04:36.744624	Desktop
664	5.161.113.195	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 03:19:50.747008	Desktop
667	2a01:4ff:f0:efd1::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 04:05:38.048089	Desktop
668	5.161.117.52	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 04:15:48.87743	Desktop
670	2a01:4ff:f0:b6f1::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 04:20:54.655057	Desktop
619	2600:1f18:179:f900:4696:7729:7bb3:f52f	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 10:05:15.920141	Desktop
622	92.50.37.245	2026-01-12	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	2026-01-12 13:40:23.513314	Desktop
623	138.226.21.11	2026-01-12	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-01-12 13:40:24.045697	Desktop
624	23.26.246.173	2026-01-12	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	2026-01-12 13:40:24.259915	Desktop
625	68.82.113.156	2026-01-12	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	2026-01-12 13:40:24.429222	Desktop
627	205.210.31.147	2026-01-12		2026-01-12 15:13:37.199115	Desktop
628	2a01:4ff:f0:7fad::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 16:21:47.959793	Desktop
629	2a01:4ff:f0:efd1::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 16:52:21.319494	Desktop
631	43.130.12.43	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 22:35:58.989323	Mobile
635	2600:1f18:179:f900:e8dd:eed1:a6c:183b	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:01:21.716277	Desktop
636	178.156.189.113	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:06:27.439961	Desktop
639	3.133.226.214	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:21:42.548031	Desktop
640	2a01:4ff:f0:9c5f::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:26:47.945003	Desktop
643	178.156.185.127	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:42:03.694133	Desktop
646	34.198.201.66	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:57:19.897301	Desktop
648	54.87.112.51	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:07:30.200183	Desktop
649	3.12.251.153	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:12:35.4726	Desktop
651	2a01:4ff:f0:e9cf::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:27:51.466972	Desktop
652	2600:1f18:179:f900:5c68:91b6:5d75:5d7	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:32:56.973941	Desktop
653	2a01:4ff:f0:d283::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:38:02.708442	Desktop
656	52.87.72.16	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:58:26.129449	Desktop
657	178.156.189.249	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 02:18:47.994386	Desktop
658	5.161.75.7	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 02:23:54.362171	Desktop
663	18.116.205.62	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 03:09:40.642421	Desktop
666	2600:1f16:775:3a00:3f24:5bb0:95d7:5a6b	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 03:55:28.015106	Desktop
669	43.157.95.239	2026-01-13	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-13 04:19:42.406434	Mobile
671	178.156.181.172	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 04:25:59.300631	Desktop
672	5.161.73.160	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 04:56:28.005618	Desktop
675	5.161.177.47	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 06:07:46.444474	Desktop
630	43.131.23.154	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 16:52:35.445789	Mobile
632	221.229.106.25	2026-01-12	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-12 23:11:39.815473	Mobile
633	2600:1f16:775:3a00:dbbe:36b0:3c45:da32	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 23:20:36.567798	Desktop
634	2a01:4ff:f0:b2f2::1	2026-01-12	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-12 23:51:10.202723	Desktop
638	178.156.184.20	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:16:37.269263	Desktop
641	5.161.194.92	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 00:31:53.669243	Desktop
650	52.22.236.30	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:22:45.782318	Desktop
655	5.161.215.244	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 01:53:20.205827	Desktop
660	5.161.61.238	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 02:39:10.341514	Desktop
665	3.149.57.90	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 03:30:00.51748	Desktop
673	2a01:4ff:f0:fdc7::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 05:16:50.418477	Desktop
674	2a01:4ff:f0:bfd::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 05:57:34.992873	Desktop
676	2a01:4ff:f0:5f80::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 06:39:25.057635	Desktop
677	2600:1f16:775:3a00:37bf:6026:e54a:f03a	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 07:35:18.649843	Desktop
678	52.15.147.27	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 08:16:03.097661	Desktop
679	198.235.24.79	2026-01-13	Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity	2026-01-13 09:11:43.426628	Desktop
680	2a01:4ff:f0:b2f2::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 09:32:22.194011	Desktop
681	43.157.38.228	2026-01-13	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-13 10:02:35.244303	Mobile
682	2a01:4ff:f0:3e03::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 10:53:48.281258	Desktop
683	182.42.105.85	2026-01-13	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-13 11:35:15.076249	Mobile
684	154.202.99.193	2026-01-13	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-01-13 12:11:42.005673	Desktop
685	172.252.223.228	2026-01-13	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-01-13 12:14:34.899995	Desktop
686	204.93.246.175	2026-01-13	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-01-13 12:16:15.180857	Desktop
687	2a03:2880:f800:4c::	2026-01-13	meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)	2026-01-13 12:59:02.514872	Desktop
688	2a01:4ff:f0:2219::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 13:56:48.491848	Desktop
689	2a01:4ff:f0:7fad::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 15:23:08.134233	Desktop
690	43.157.153.236	2026-01-13	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-13 15:33:41.391374	Mobile
691	2001:4860:7:622::fa	2026-01-13	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	2026-01-13 15:46:15.812947	Desktop
692	2001:4860:7:1622::ff	2026-01-13	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	2026-01-13 16:34:21.597021	Desktop
693	2600:1f18:179:f900:4696:7729:7bb3:f52f	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 20:43:57.339829	Desktop
694	2a01:4ff:f0:eccb::1	2026-01-13	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-13 21:09:21.699131	Desktop
695	43.153.86.78	2026-01-13	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-13 21:18:42.968999	Mobile
696	5.161.73.160	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:02:18.54833	Desktop
697	5.161.113.195	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:07:23.067371	Desktop
698	49.235.136.28	2026-01-14	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-14 00:09:25.503604	Mobile
699	178.156.185.127	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:12:29.060148	Desktop
700	52.22.236.30	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:17:34.734104	Desktop
701	5.161.117.52	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:22:38.894777	Desktop
702	5.161.75.7	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:27:44.282001	Desktop
703	5.161.194.92	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:32:49.647375	Desktop
704	54.167.223.174	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:42:59.801711	Desktop
705	3.133.226.214	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:48:05.582994	Desktop
706	178.156.181.172	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 00:53:11.127791	Desktop
707	3.12.251.153	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:13:32.403667	Desktop
708	5.161.215.244	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:18:37.421038	Desktop
709	5.161.177.47	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:23:42.245466	Desktop
710	178.156.187.238	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:33:52.530654	Desktop
711	178.156.189.113	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:38:57.59716	Desktop
712	34.198.201.66	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:49:06.35081	Desktop
713	18.116.205.62	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:54:11.933774	Desktop
714	178.156.184.20	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 01:59:16.916044	Desktop
715	52.87.72.16	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 02:09:27.329559	Desktop
718	3.149.57.90	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 02:29:49.566953	Desktop
720	178.156.185.231	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 03:10:29.314774	Desktop
721	150.109.119.38	2026-01-14	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-14 03:15:04.303076	Mobile
723	54.87.112.51	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 04:21:42.551618	Desktop
727	52.15.147.27	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 05:22:45.130597	Desktop
728	178.156.189.249	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 06:39:03.201118	Desktop
731	43.134.141.244	2026-01-14	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-14 08:59:09.310808	Mobile
733	2a01:4ff:f0:2219::1	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 12:04:49.785875	Desktop
734	109.166.44.213	2026-01-14	"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36"	2026-01-14 13:39:46.072191	Desktop
736	2a01:4ff:f0:e9cf::1	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 15:28:25.59913	Desktop
737	216.246.11.15	2026-01-14	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	2026-01-14 16:16:03.424236	Desktop
740	2600:1f18:179:f900:4b7d:d1cc:2d10:211	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 17:10:30.859427	Desktop
743	2600:1f16:775:3a00:dbbe:36b0:3c45:da32	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 20:04:43.414993	Desktop
746	34.198.201.66	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:04:13.486349	Desktop
748	5.161.177.47	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:14:24.363285	Desktop
750	2a01:4ff:f0:e516::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:24:34.991301	Desktop
755	3.20.63.178	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:55:10.013822	Desktop
758	5.161.117.52	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:15:34.403958	Desktop
761	52.22.236.30	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:25:47.50199	Desktop
767	2a01:4ff:f0:d3cd::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 02:31:59.541479	Desktop
768	43.165.67.57	2026-01-15	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-15 02:49:22.873942	Mobile
772	54.87.112.51	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 03:48:16.367128	Desktop
776	2600:1f18:179:f900:5c68:91b6:5d75:5d7	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 05:14:45.118488	Desktop
778	2600:1f18:179:f900:71:af9a:ade7:d772	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 05:45:15.652748	Desktop
781	2a01:4ff:f0:9c5f::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 06:31:07.298439	Desktop
782	2600:1f16:775:3a00:3f24:5bb0:95d7:5a6b	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 07:11:50.176231	Desktop
783	5.161.113.195	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 07:16:55.758054	Desktop
785	178.156.184.20	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 08:29:01.654474	Desktop
786	34.251.42.196	2026-01-15	Mozilla/5.0 (Linux; Android 10; Pixel 3 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Mobile Safari/537.36	2026-01-15 08:30:27.068579	Mobile
788	216.144.248.27	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 08:35:02.411007	Desktop
789	2a01:4ff:f0:e9cf::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 08:45:13.076853	Desktop
790	2a01:4ff:f0:5f80::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 08:50:18.844053	Desktop
792	178.156.181.172	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 10:37:16.701715	Desktop
793	186.22.253.214	2026-01-15	Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) EdgiOS/121.0.2277.107 Version/17.0 Mobile/15E148 Safari/604.1	2026-01-15 10:38:24.212183	Mobile
716	3.20.63.178	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 02:19:37.877047	Desktop
719	3.212.128.62	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 02:45:03.649893	Desktop
742	2600:1f16:775:3a00:3f24:5bb0:95d7:5a6b	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 19:33:55.684152	Desktop
744	43.153.71.12	2026-01-14	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-14 20:38:20.948741	Mobile
745	2a01:4ff:f0:7fad::1	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 21:41:38.247629	Desktop
747	178.156.185.127	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:09:19.202185	Desktop
751	5.161.73.160	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:29:41.672687	Desktop
752	2a01:4ff:f0:efd1::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:39:52.440643	Desktop
754	3.149.57.90	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:50:03.772006	Desktop
756	54.167.223.174	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:05:22.510163	Desktop
757	52.87.72.16	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:10:28.282274	Desktop
760	178.156.189.249	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:20:40.862087	Desktop
762	2a01:4ff:f0:3e03::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:30:52.666182	Desktop
773	52.15.147.27	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 03:53:22.049535	Desktop
784	2a01:4ff:f0:b6f1::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 07:53:19.332416	Desktop
717	111.88.12.217	2026-01-14	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.4 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.4 facebookexternalhit/1.1 Facebot Twitterbot/1.0	2026-01-14 02:29:46.791987	Desktop
724	2600:1f18:179:f900:2406:9399:4ae6:c5d3	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 04:42:03.773475	Desktop
732	2a01:4ff:f0:5f80::1	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 10:38:15.558106	Desktop
759	182.40.104.255	2026-01-15	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-15 01:18:02.683629	Mobile
763	5.161.75.7	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:41:03.148106	Desktop
764	18.116.205.62	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 01:46:08.926407	Desktop
771	3.12.251.153	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 03:27:57.694072	Desktop
780	2600:1f18:179:f900:4b7d:d1cc:2d10:211	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 06:15:50.68817	Desktop
794	2a01:4ff:f0:eccb::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 10:47:26.629415	Desktop
722	2a01:4ff:f0:d3cd::1	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 04:16:37.443334	Desktop
725	2600:1f18:179:f900:4696:7729:7bb3:f52f	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 04:52:13.27026	Desktop
726	2a01:4ff:f0:9c5f::1	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 05:12:34.465969	Desktop
729	2a01:4ff:f0:fdc7::1	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 07:29:56.535047	Desktop
730	5.161.61.238	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 07:35:02.402986	Desktop
735	43.166.128.86	2026-01-14	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-14 14:23:18.626246	Mobile
738	170.23.18.129	2026-01-14	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-01-14 16:16:03.538994	Desktop
739	2600:1f16:775:3a00:91ac:3120:ff38:92b5	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 16:24:23.114893	Desktop
741	2600:1f16:775:3a00:ac3:c5eb:7081:942e	2026-01-14	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-14 18:28:20.571199	Desktop
749	2600:1f18:179:f900:4696:7729:7bb3:f52f	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:19:29.412789	Desktop
753	178.156.185.231	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 00:44:58.557607	Desktop
765	178.156.189.113	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 02:11:38.906465	Desktop
766	5.161.215.244	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 02:16:43.563706	Desktop
769	5.161.194.92	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 02:57:24.698907	Desktop
770	3.212.128.62	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 03:02:30.547131	Desktop
774	5.161.61.238	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 04:34:04.374828	Desktop
775	3.133.226.214	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 04:54:24.978572	Desktop
777	2a01:4ff:f0:bfd::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 05:19:50.682968	Desktop
779	2600:1f18:179:f900:2406:9399:4ae6:c5d3	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 06:10:44.267586	Desktop
787	170.106.11.6	2026-01-15	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-15 08:32:57.517432	Mobile
791	2600:1f16:775:3a00:ac3:c5eb:7081:942e	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 09:25:59.414769	Desktop
795	2a01:4ff:f0:2219::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 11:12:52.587969	Desktop
796	2a01:4ff:f0:d283::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 12:24:10.435941	Desktop
797	114.96.103.33	2026-01-15	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-15 13:54:07.663056	Mobile
798	43.166.255.102	2026-01-15	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-15 14:02:34.406059	Mobile
799	2a01:4ff:f0:7fad::1	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 15:22:32.597067	Desktop
800	178.156.187.238	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 15:37:48.62911	Desktop
801	2600:1f18:179:f900:e8dd:eed1:a6c:183b	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 15:58:11.678224	Desktop
802	94.247.172.129	2026-01-15	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2)	2026-01-15 18:03:23.030958	Desktop
803	2a03:2880:f800:33::	2026-01-15	meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)	2026-01-15 19:41:35.800398	Desktop
804	43.157.148.38	2026-01-15	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-15 20:17:04.842261	Mobile
805	2600:1f16:775:3a00:8c2c:2ba6:778f:5be5	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 21:14:31.852104	Desktop
806	2600:1f16:775:3a00:37bf:6026:e54a:f03a	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 23:31:49.671379	Desktop
807	2600:1f16:775:3a00:dbbe:36b0:3c45:da32	2026-01-15	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-15 23:52:10.079264	Desktop
808	178.156.187.238	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:02:20.686058	Desktop
809	3.133.226.214	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:07:25.337017	Desktop
810	5.161.194.92	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:12:30.639649	Desktop
811	178.156.184.20	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:17:35.033245	Desktop
812	2600:1f16:775:3a00:ac3:c5eb:7081:942e	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:27:45.559901	Desktop
813	178.156.185.127	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:32:49.966479	Desktop
814	52.87.72.16	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:37:55.545695	Desktop
815	2600:1f18:179:f900:5c68:91b6:5d75:5d7	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:43:00.221896	Desktop
816	3.149.57.90	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:48:05.257331	Desktop
817	178.156.185.231	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 00:53:10.286592	Desktop
818	5.161.75.7	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 01:03:19.857621	Desktop
819	2600:1f16:775:3a00:3f24:5bb0:95d7:5a6b	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 01:08:26.0987	Desktop
820	18.116.205.62	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 01:13:32.621033	Desktop
821	5.161.73.160	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 01:28:48.306819	Desktop
822	5.161.61.238	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 01:33:53.476552	Desktop
823	5.161.177.47	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 01:49:09.314482	Desktop
824	2a01:4ff:f0:b6f1::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 01:59:19.023216	Desktop
825	3.20.63.178	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 02:09:29.932062	Desktop
826	2a01:4ff:f0:7fad::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 02:14:34.892767	Desktop
827	2600:1f16:775:3a00:dbbe:36b0:3c45:da32	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 02:24:45.150642	Desktop
829	5.161.117.52	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 02:34:55.580839	Desktop
833	2600:1f18:179:f900:71:af9a:ade7:d772	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 03:30:50.824284	Desktop
835	137.184.168.3	2026-01-16	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-01-16 04:51:31.220545	Desktop
836	52.22.236.30	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 05:02:21.973727	Desktop
838	178.156.181.172	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 05:37:56.795879	Desktop
841	3.212.128.62	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 06:08:26.845961	Desktop
853	34.60.131.171	2026-01-16	Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ShapBot/0.1.0	2026-01-16 13:29:20.99554	Desktop
856	170.106.192.3	2026-01-16	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-16 14:50:45.730061	Mobile
861	2a01:4ff:f0:b2f2::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 19:54:42.623104	Desktop
865	18.116.205.62	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:08:23.93322	Desktop
828	3.12.251.153	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 02:29:51.633689	Desktop
830	5.161.113.195	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 02:55:15.210331	Desktop
831	49.51.141.76	2026-01-16	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-16 03:11:55.096805	Mobile
832	178.156.189.113	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 03:20:41.429213	Desktop
834	54.167.223.174	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 03:41:02.375109	Desktop
837	2a01:4ff:f0:eccb::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 05:12:31.876601	Desktop
842	100.52.3.146	2026-01-16	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36	2026-01-16 06:25:58.046066	Desktop
843	2600:1f16:775:3a00:91ac:3120:ff38:92b5	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 06:28:47.578978	Desktop
844	52.15.147.27	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 07:29:45.532093	Desktop
845	178.156.189.249	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 08:51:06.514512	Desktop
846	47.82.11.26	2026-01-16	Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	2026-01-16 08:51:19.492024	Desktop
849	2a03:2880:f800:11::	2026-01-16	meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)	2026-01-16 09:47:20.945866	Desktop
860	2600:1f18:179:f900:4696:7729:7bb3:f52f	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 19:17:50.242409	Desktop
864	178.156.185.231	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:03:04.496907	Desktop
874	178.156.181.172	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 01:04:57.045751	Desktop
839	5.161.215.244	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 05:43:01.777083	Desktop
840	54.87.112.51	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 05:53:11.826198	Desktop
868	5.161.194.92	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:34:06.548643	Desktop
871	43.153.62.161	2026-01-17	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-17 00:48:31.39125	Mobile
872	178.156.187.238	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:49:26.092602	Desktop
847	2a01:4ff:f0:3e03::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 09:11:28.693864	Desktop
848	43.153.54.14	2026-01-16	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-16 09:13:27.307553	Mobile
850	2600:1f16:775:3a00:37bf:6026:e54a:f03a	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 11:03:25.381473	Desktop
851	186.96.213.122	2026-01-16	Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.4466.51 Safari/537.36	2026-01-16 12:14:46.526257	Desktop
852	34.198.201.66	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 12:45:06.604808	Desktop
854	2a01:4ff:f0:bfd::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 13:36:01.39605	Desktop
855	2a01:4ff:f0:5f80::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 14:31:59.803149	Desktop
857	182.42.111.213	2026-01-16	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-16 15:07:49.520561	Mobile
858	2600:1f16:775:3a00:8c2c:2ba6:778f:5be5	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 15:58:35.834128	Desktop
859	2600:1f18:179:f900:e8dd:eed1:a6c:183b	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 16:40:08.808028	Desktop
862	2600:1f18:179:f900:2406:9399:4ae6:c5d3	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 21:23:01.300195	Desktop
863	2a01:4ff:f0:2219::1	2026-01-16	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-16 23:42:40.686749	Desktop
866	5.161.73.160	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:18:35.913177	Desktop
867	178.156.185.127	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:23:41.654778	Desktop
869	3.212.128.62	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:39:13.454404	Desktop
870	5.161.215.244	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:44:18.790816	Desktop
873	178.156.189.249	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 00:59:50.74332	Desktop
875	52.15.147.27	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 01:10:04.419253	Desktop
876	5.161.113.195	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 01:15:09.839891	Desktop
877	3.12.251.153	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 01:20:16.577545	Desktop
910	5.161.75.7	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 05:17:47.231241	Desktop
911	3.20.63.178	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 05:22:53.869095	Desktop
912	3.133.226.214	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 05:33:06.250191	Desktop
913	2600:1f16:775:3a00:3f24:5bb0:95d7:5a6b	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 05:58:37.695456	Desktop
914	2a01:4ff:f0:7fad::1	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 06:03:43.170179	Desktop
915	54.87.112.51	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 06:14:10.787695	Desktop
916	5.161.61.238	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 06:29:33.636146	Desktop
917	52.22.236.30	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 06:34:39.497585	Desktop
918	5.161.177.47	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 06:39:44.447354	Desktop
919	34.198.201.66	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 06:50:15.03981	Desktop
920	2a01:4ff:f0:eccb::1	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 06:55:21.920209	Desktop
921	2a01:4ff:f0:efd1::1	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 08:12:41.976308	Desktop
922	43.157.149.188	2026-01-17	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	2026-01-17 08:55:46.289352	Mobile
923	2600:1f18:179:f900:4696:7729:7bb3:f52f	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 09:19:52.88975	Desktop
924	178.156.189.113	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 09:55:35.887528	Desktop
925	5.161.117.52	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 11:44:30.983542	Desktop
926	216.81.248.16	2026-01-17	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36	2026-01-17 12:03:33.332152	Desktop
927	3.149.57.90	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 12:15:30.476369	Desktop
928	52.87.72.16	2026-01-17	Mozilla/5.0+(compatible; UptimeRobot/2.0; http://www.uptimerobot.com/)	2026-01-17 12:30:50.316661	Desktop
929	2602:80d:1006::60	2026-01-17	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	2026-01-17 12:39:34.303291	Desktop
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_id_seq', 10, true);


--
-- Name: coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_id_seq', 8, true);


--
-- Name: inventory_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_item_id_seq', 19, true);


--
-- Name: optician_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.optician_message_id_seq', 1, false);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_id_seq', 15, true);


--
-- Name: order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_item_id_seq', 17, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_id_seq', 23, true);


--
-- Name: product_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_image_id_seq', 10, true);


--
-- Name: promo_banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.promo_banner_id_seq', 1, false);


--
-- Name: review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.review_id_seq', 1, true);


--
-- Name: setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.setting_id_seq', 1, true);


--
-- Name: visit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.visit_id_seq', 929, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: category category_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_name_key UNIQUE (name);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: coupon coupon_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT coupon_code_key UNIQUE (code);


--
-- Name: coupon coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (id);


--
-- Name: inventory_item inventory_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT inventory_item_pkey PRIMARY KEY (id);


--
-- Name: optician_message optician_message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.optician_message
    ADD CONSTRAINT optician_message_pkey PRIMARY KEY (id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order order_tracking_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_tracking_number_key UNIQUE (tracking_number);


--
-- Name: product_image product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: promo_banner promo_banner_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promo_banner
    ADD CONSTRAINT promo_banner_pkey PRIMARY KEY (id);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (id);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (id);


--
-- Name: visit visit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_pkey PRIMARY KEY (id);


--
-- Name: ix_visit_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_visit_date ON public.visit USING btree (date);


--
-- Name: order_item order_item_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(id) ON DELETE CASCADE;


--
-- Name: product product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: product_image product_image_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: review review_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- PostgreSQL database dump complete
--

\unrestrict IBXD3tPtqHg72Wi04Is9AfdKuO7eoUiEIMSDShaeaXjoOL1xgiYJKz7GAtVrg5K

