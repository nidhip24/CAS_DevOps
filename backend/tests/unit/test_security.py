"""
Test cases for the security module
"""
from datetime import datetime, timedelta

import pytest
from jose import jwt

from src.security import (
    create_access_token, get_password_hash, verify_password
)


def test_password_hash():
    """
    Test that the password is hashed
    """
    password = "password123"
    hashed = get_password_hash(password)
    assert password not in hashed


def test_matching_passwords():
    """
    Test that the password verification works
    """
    password = "password123"
    hashed = get_password_hash(password)
    assert verify_password(password, hashed) is True


def test_non_matching_passwords():
    """Test that the password verification works"""
    password = "password123"
    hashed = get_password_hash(password)
    assert verify_password("password321", hashed) is False


@pytest.mark.parametrize(
    "subject, expires_delta",
    [
        ("user123", timedelta(minutes=30)),
        ("user456", None),
    ],
)
def test_create_access_token(subject, expires_delta):
    """Test that the access token is created successfully"""
    token = create_access_token(subject, expires_delta)

    # Verify that the token is not empty
    assert token is not None

    # Verify that the token is a string
    assert isinstance(token, str)

    # Verify that the token can be decoded
    decoded_token = jwt.decode(
        token,
        "ca6f2f0aa75c75b07d43b7b8f954b424f4165c775b7de030d76c87d3fb7da268",
        algorithms=["HS256"],
        options={"verify_aud": False},
    )
    assert decoded_token is not None

    # Verify that the token contains the correct subject
    assert decoded_token["sub"] == subject

    # Verify that the token expires in the future
    assert decoded_token["exp"] > datetime.utcnow().timestamp()
