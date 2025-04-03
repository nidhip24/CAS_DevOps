"""This module contains the schemas for the authentication endpoints."""

from typing import Optional

from pydantic import BaseModel


class UserRegister(BaseModel):
    """User registration schema"""
    username: str
    password: str
    source: Optional[str] = None


class Token(BaseModel):
    """Bearer Access Token"""

    access_token: str
    token_type: str
    expires: int
