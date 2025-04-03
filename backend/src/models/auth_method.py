"""
Auth Method Model DB Schema
"""

from sqlalchemy import Integer, Enum, Column, TIMESTAMP
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func


Base = declarative_base()


class AuthMethod(Base):
    """auth_method db model"""

    __tablename__ = 'auth_method'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(
        Enum('plain', 'plain-jwt', 'google', name='auth_method_enum'),
        nullable=False
    )
    timestamp = Column(TIMESTAMP, server_default=func.current_timestamp())
