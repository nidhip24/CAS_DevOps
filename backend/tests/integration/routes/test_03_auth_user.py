"""
Test the auth_user routes
"""
from uuid import uuid4

LOGIN_HEADERS = headers = {
    "accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
}
UNIQUE_NAME = f"SAMPLE{uuid4().hex[:6]}"
CLIENT_ID = "1fd9ef05-3623-4911-ae02-c79cc79edf41"


def test_auth_user_register_without_token(test_client):
    """
    Test for app registration without auth
    """
    # pass authorization headers as well
    response = test_client.post(
        "/v1/api/app/user/signup",
        json={
            "client_id": CLIENT_ID,
            "username": "hahahaahahhaah",
            "password": "password",
            "auth_method": "plain"
        },
    )
    data = response.json()
    assert (
        "detail" in data
        and data["detail"] == "Unauthorized access"
        and response.status_code == 401
    )


def test_auth_user_register_with_invalid_token(test_client):
    """
    Test auth user registration with invalid token
    """
    response = test_client.post(
        "/v1/api/app/user/signup",
        json={
            "client_id": CLIENT_ID,
            "username": "hahahaahahhaah",
            "password": "password",
            "auth_method": "plain"
        },
        headers={"Authorization": "invalid_token"}
    )
    data = response.json()
    assert (
        "detail" in data
        and data["detail"] == "Unauthorized access"
        and response.status_code == 401
    )


def test_auth_user_register_with_expired_token(test_client):
    """
    Test auth user registration with expired token
    """

    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.post(
        "/v1/api/app/user/signup",
        json={
            "client_id": CLIENT_ID,
            "username": "hahahaahahhaah",
            "password": "password",
            "auth_method": "plain"
        },
        headers={"Authorization": "Bearer expired_token"}
    )
    data = response.json()
    assert (
        "detail" in data
        and data["detail"] == "Unauthorized access"
        and response.status_code == 401
    )


def test_auth_user_register_with_invalid_params(test_client):
    """
    Test auth user registration with invalid params
    """

    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.post(
        "/v1/api/app/user/signup",
        json={
            "client_id": CLIENT_ID,
            "username": "hahahaahahhaah",
            "password": "password"
        },
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "message" in data
        and data["message"] == "Validation failed"
        and response.status_code == 422
    )


def get_client_id(test_client):
    """
    Get client id
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.get(
        "/v1/api/app/list",
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    print(data)
    return data["apps"][0]["client_id"]


def test_auth_user_register(test_client):
    """
    Test auth user registration
    """

    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.post(
        "/v1/api/app/user/signup",
        json={
            "client_id": get_client_id(test_client),
            "username": UNIQUE_NAME,
            "password": "password",
            "auth_method": "plain"
        },
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "message" in data
        and data["message"] == "User created successfully"
        and response.status_code == 201
    )


def test_auth_user_register_duplicate(test_client):
    """
    Test auth user registration with duplicate username
    """

    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()

    response = test_client.post(
        "/v1/api/app/user/signup",
        json={
            "client_id": get_client_id(test_client),
            "username": UNIQUE_NAME,
            "password": "password",
            "auth_method": "plain"
        },
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert response.status_code == 409


def test_auth_user_login_invalid_params(test_client):
    """
    Test auth user login with invalid params
    """

    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()
    response = test_client.post(
        "/v1/api/app/user/login",
        json={
            "client_id": get_client_id(test_client),
            "username": UNIQUE_NAME,
            "passwor1d": "password"
        },
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "message" in data
        and data["message"] == "Validation failed"
        and response.status_code == 422
    )


def test_auth_user_login_user_does_not_exist(test_client):
    """
    Test auth user login with user that does not exist
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()
    response = test_client.post(
        "/v1/api/app/user/login",
        json={
            "client_id": get_client_id(test_client),
            "username": UNIQUE_NAME + "somw",
            "password": "password"
        },
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "detail" in data
        and data["detail"] == "Incorrect email or password"
        and response.status_code == 400
    )


def test_auth_user_login_invalid_password(test_client):
    """
    Test auth user login with invalid password
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()
    response = test_client.post(
        "/v1/api/app/user/login",
        json={
            "client_id": get_client_id(test_client),
            "username": UNIQUE_NAME,
            "password": "passwordinvalid"
        },
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "detail" in data
        and data["detail"] == "Incorrect email or password"
        and response.status_code == 401
    )


def test_auth_user_login(test_client):
    """
    Test auth user login
    """
    response = test_client.post(
        "/v1/api/user/login",
        headers=LOGIN_HEADERS,
        data={"username": "admin@gmail.com", "password": "admin"}
    )
    data = response.json()
    response = test_client.post(
        "/v1/api/app/user/login",
        json={
            "client_id": get_client_id(test_client),
            "username": UNIQUE_NAME,
            "password": "password"
        },
        headers={"Authorization": data["access_token"]}
    )
    data = response.json()
    assert (
        "access_token" in data
        and response.status_code == 200
    )
