"""
User Role Model DB Schema
"""

from sqlalchemy import Integer, String, Column, TIMESTAMP, UniqueConstraint
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func


Base = declarative_base()


class UserRole(Base):
    """user_role db model"""

    __tablename__ = 'user_role'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    type = Column(String(50), nullable=False)
    timestamp = Column(TIMESTAMP, server_default=func.current_timestamp())

    __table_args__ = (
        UniqueConstraint('name', 'type', name='cur_uk_name_type'),
    )
