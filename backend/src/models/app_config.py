"""
This module contains the SQLAlchemy model for the app_config table
"""

from sqlalchemy import Column, Integer, Text, TIMESTAMP, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func

Base = declarative_base()


class AppConfig(Base):
    """app_config db model"""

    __tablename__ = 'app_config'

    id = Column(Integer, primary_key=True, autoincrement=True)
    aid = Column(Integer, nullable=False)
    metadata_ = Column("metadata", Text, nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    updated_at = Column(
        TIMESTAMP,
        server_default=func.current_timestamp(),
        onupdate=func.current_timestamp()
    )
