"""
This module contains the schemas for the app model
"""
from typing import Dict, Literal
from pydantic import BaseModel, Field


class App(BaseModel):
    """App schema"""
    name: str
    auth_method: Literal["plain", "plain-jwt", "google"]
    metadata: Dict[str, str] = Field(default_factory=dict)
