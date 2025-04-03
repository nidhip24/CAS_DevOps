"""
This module contains the schemas for the app_user model
"""
from typing import Literal
from pydantic import BaseModel


class AuthUser(BaseModel):
    """Auth User schema"""
    client_id: str
    username: str
    password: str
    auth_method: Literal["plain", "plain-jwt", "google"]
