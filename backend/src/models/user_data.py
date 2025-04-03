"""
User Data Model DB Schema
"""

from sqlalchemy import Column, Integer, String, Text, TIMESTAMP
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func
from sqlalchemy.orm import Session

Base = declarative_base()


class UserData(Base):
    """user_data db model"""

    __tablename__ = 'user_data'

    id = Column(Integer, primary_key=True, autoincrement=True)
    rid = Column(Integer, nullable=False)
    username = Column(String(255), nullable=False)
    password = Column(Text, default=None)
    source = Column(String(50), nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    updated_at = Column(
        TIMESTAMP,
        server_default=func.current_timestamp(),
        onupdate=func.current_timestamp())

    def __repr__(self):
        return f'<UserData {self.username}>'

    def find_by_username(self, db: Session, username: str):
        """
        Get user data by username

        Parameters:
            - db: Database session
            - username: Username to search

        Returns:
            - User data object
        """
        return db.query(UserData).filter_by(username=username).first()

    def save(self, db: Session):
        """
        Save user data to database

        Parameters:
            - db: Database session
        """
        db.add(self)
        db.commit()
