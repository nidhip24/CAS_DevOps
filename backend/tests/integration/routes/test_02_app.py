"""
Test the app routes
"""
from uuid import uuid4

LOGIN_HEADERS = headers = {
    "accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
}
UNIQUE_NAME = f"SAMPLE{uuid4().hex[:6]}"


def test_app_register_without_auth(test_client):
    """
    Test for app registration without auth
    """
    # pass authorization headers as well
    response = test_client.post(
        "/v1/api/app/create",
        json={"name": "someapp", "auth_method": "plain-jwt"},
    )
    data = response.json()
    assert (
        "detail" in data
        and data["detail"] == "Unauthorized access"
        and response.status_code == 401
    )


def test_app_register_without_invalid_auth(test_client):
    """
    Test for app registration without auth
    """
    # pass authorization headers as well

    response = test_client.post(
        "/v1/api/app/create",
        json={"name": "someapp", "auth_method": "plain-jwt"},
        headers={"Authorization": "Bearer some_token"}
    )
    data = response.json()
    assert (
        "detail" in data
        and data["detail"] == "Unauthorized access"
        and response.status_code == 401
    )


def test_app_register_with_valid_auth(test_client):
    """
    Test for app registration with valid auth
    """
    # pass authorization headers as well

    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.post(
        "/v1/api/app/create",
        json={"name": UNIQUE_NAME, "auth_method": "plain-jwt"},
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "message" in data
        and data["message"] == "App registered successfully"
        and response.status_code == 201
    )


def test_app_register_duplicate_name(test_client):
    """
    Test for app registration with valid auth
    """
    # pass authorization headers as well
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.post(
        "/v1/api/app/create",
        json={"name": UNIQUE_NAME, "auth_method": "plain-jwt"},
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (response.status_code == 409)


def test_app_register_invalid_params(test_client):
    """
    Test for app registration with valid auth
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.post(
        "/v1/api/app/create",
        json={"name": "someapp", "auth": "plain-jwt"},
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "message" in data
        and data["message"] == "Validation failed"
        and response.status_code == 422
    )
