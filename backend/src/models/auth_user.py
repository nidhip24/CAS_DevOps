"""
This module contains the SQLAlchemy model for the auth_user table
"""

from sqlalchemy import (
    Column, Integer, String, Text, Boolean, TIMESTAMP, ForeignKey
)
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func

Base = declarative_base()


class AuthUser(Base):
    """auth_user db model"""

    __tablename__ = 'auth_user'

    id = Column(Integer, primary_key=True, autoincrement=True)
    aid = Column(Integer, nullable=False)
    amid = Column(Integer, nullable=False)
    username = Column(String(255), nullable=False)
    password = Column(Text, default=None)
    is_blocked = Column(Boolean, default=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    updated_at = Column(
        TIMESTAMP,
        server_default=func.current_timestamp(),
        onupdate=func.current_timestamp()
    )
