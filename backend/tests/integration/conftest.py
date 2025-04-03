"""
Setting up
"""
import pytest
from fastapi.testclient import TestClient

from src.main import app


@pytest.fixture
def test_client():
    """Create a test client for the fastapi app"""
    return TestClient(app)
