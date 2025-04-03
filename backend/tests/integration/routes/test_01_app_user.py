"""
Test for the user routes
"""
from uuid import uuid4

LOGIN_HEADERS = headers = {
    "accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
}

UNIQUE_USERNAME = f"nidhip{uuid4().hex[:6]}@gmail.com"


def test_register_test_user(test_client):
    """
    Test for registering a user
    """
    response = test_client.post(
        "/v1/api/user/register",
        json={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()
    assert (
        "message" in data
        and data["message"] == "User created successfully"
        and response.status_code == 201
    )


def test_register(test_client):
    """
    Test for registering a user
    """
    response = test_client.post(
        "/v1/api/user/register",
        json={"username": UNIQUE_USERNAME, "password": "admin123"}
    )
    data = response.json()
    assert (
        "message" in data
        and data["message"] == "User created successfully"
        and response.status_code == 201
    )


def test_register_duplicate_email(test_client):
    """
    Test for registering a user with a duplicate email
    """
    response = test_client.post(
        "/v1/api/user/register",
        json={
            "username": UNIQUE_USERNAME,
            "password": "admin123"
        }
    )
    assert (
        response.status_code == 409
    )


# login test cases
def test_can_login_for_access_token(test_client):
    """
    Test for user login
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": UNIQUE_USERNAME, "password": "admin123"}
    )
    data = response.json()
    assert (
        "access_token" in data
        and data["token_type"] == "bearer"
        and response.status_code == 200
    )


def test_cant_login_for_wrong_password(test_client):
    """
    Test for user login with wrong password
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": UNIQUE_USERNAME, "password": "wrong"}
    )
    assert (
        response.status_code == 401
        and response.json()["detail"] == "Incorrect email or password"
    )


def test_cant_login_for_wrong_username(test_client):
    """
    Test for user login with wrong username
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "wrong@admin.com", "password": "admin"}
    )
    assert (
        response.status_code == 400
        and response.json()["detail"] == "Incorrect email or password"
    )
