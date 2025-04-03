"""
This module contains the SQLAlchemy model for the auth_trail table.
"""

from sqlalchemy import Column, Integer, TIMESTAMP, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func

Base = declarative_base()


class AuthTrail(Base):
    """auth_trail db model"""

    __tablename__ = 'auth_trail'

    aid = Column(Integer, primary_key=True)
    auid = Column(Integer, primary_key=True)
    timestamp = Column(TIMESTAMP, server_default=func.current_timestamp())
