"""populate auth_method table

Revision ID: c1bbb0b870fe
Revises: 98ee7a80f76b
Create Date: 2024-11-26 03:15:53.621170

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c1bbb0b870fe'
down_revision: Union[str, None] = '98ee7a80f76b'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.execute(
        """
        INSERT INTO auth_method (name)
        VALUES
        ('plain'),
        ('plain-jwt');
        """
    )


def downgrade() -> None:
    op.execute(
        """
        DELETE FROM auth_method
        WHERE name IN ('plain', 'plain-jwt');
        """
    )
