"""
This module contains the schemas for the auth_user model
"""
from pydantic import BaseModel


class UserLogin(BaseModel):
    """User login schema"""
    username: str
    password: str
    client_id: str
