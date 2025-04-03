"""
DB Schema for the App model.
"""
from pydantic import BaseModel, ConfigDict


class AppSchema(BaseModel):
    """
    App schema
    """
    name: str
    client_id: str
    secret: str

    model_config = ConfigDict(from_attributes=True)
