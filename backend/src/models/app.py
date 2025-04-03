"""
App Model DB Schema
"""

from sqlalchemy import Integer, Column, TIMESTAMP, ForeignKey, String, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func

Base = declarative_base()


class App(Base):
    """app db model"""

    __tablename__ = 'app'

    id = Column(Integer, primary_key=True, autoincrement=True)
    uid = Column(Integer, nullable=False)
    amid = Column(Integer, nullable=False)
    name = Column(String(255), nullable=False)
    client_id = Column(Text, nullable=False)
    secret = Column(Text, nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    updated_at = Column(
        TIMESTAMP,
        server_default=func.current_timestamp(),
        onupdate=func.current_timestamp())
