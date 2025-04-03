"""
This module contains the AuthToken model
"""

from sqlalchemy import Column, Integer, Text, TIMESTAMP, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func

Base = declarative_base()


class AuthToken(Base):
    """auth_token db model"""

    __tablename__ = 'auth_token'

    id = Column(Integer, primary_key=True, autoincrement=True)
    auid = Column(Integer, nullable=False)
    token = Column(Text, nullable=False)
    expiry = Column(TIMESTAMP, nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    updated_at = Column(
        TIMESTAMP,
        server_default=func.current_timestamp(),
        onupdate=func.current_timestamp()
    )
