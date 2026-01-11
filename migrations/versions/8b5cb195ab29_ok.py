"""ok

Revision ID: 8b5cb195ab29
Revises: d34c848c551d
Create Date: 2026-01-11 20:40:08.976749
"""

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '8b5cb195ab29'
down_revision = 'd34c848c551d'
branch_labels = None
depends_on = None


def upgrade():
    with op.batch_alter_table('visit', schema=None) as batch_op:

        # ✅ Add device column (safe)
        batch_op.add_column(
            sa.Column('device', sa.String(length=20), nullable=True)
        )

        # ✅ Shrink IP safely (IPv6 max = 45 chars)
        batch_op.alter_column(
            'ip',
            existing_type=sa.VARCHAR(length=100),
            type_=sa.String(length=45),
            existing_nullable=True
        )

        # ✅ User agents can be VERY long → use TEXT
        batch_op.alter_column(
            'user_agent',
            existing_type=sa.VARCHAR(length=500),
            type_=sa.Text(),
            existing_nullable=True
        )

        # ✅ Index for fast date filtering
        batch_op.create_index(
            batch_op.f('ix_visit_date'),
            ['date'],
            unique=False
        )


def downgrade():
    with op.batch_alter_table('visit', schema=None) as batch_op:

        batch_op.drop_index(batch_op.f('ix_visit_date'))

        # ⬇️ Revert back safely (TEXT → VARCHAR(500))
        batch_op.alter_column(
            'user_agent',
            existing_type=sa.Text(),
            type_=sa.VARCHAR(length=500),
            existing_nullable=True
        )

        batch_op.alter_column(
            'ip',
            existing_type=sa.String(length=45),
            type_=sa.VARCHAR(length=100),
            existing_nullable=True
        )

        batch_op.drop_column('device')