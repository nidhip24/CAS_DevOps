"""
Routes for the app
"""
# from typing import Any, Dict
# import json
from typing import Any, Dict
from datetime import timedelta, datetime

from fastapi import APIRouter, Depends, HTTPException, status, Request
from sqlalchemy.orm import Session

from src.schemas.auth import Token
from src.schemas.auth_user import AuthUser as AuthUserSchema
from src.schemas.user_login_schema import UserLogin
from src.database.db import get_db
from src.models import App as AppModel
from src.models import AuthUser as AuthUserModel
from src.models import AuthMethod as AuthMethodModel
from src.security import (
    verify_token, get_password_hash, verify_password, create_access_token
)
from src.config import settings


router = APIRouter()


@router.post(
        "/signup",
        response_model=dict,
        status_code=status.HTTP_201_CREATED
    )
def register_app(
    auth_user: AuthUserSchema,
    db: Session = Depends(get_db),
    request: Request = None
):
    """
    Register a new user with app
    """
    token = getattr(request.state, "token", None)
    payload = verify_token(token)

    db_app = db.query(AppModel).filter(
        AppModel.client_id == auth_user.client_id,
        AppModel.uid == payload["sub"]
    ).first()

    if not db_app:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"The app with this {auth_user.client_id} "
            + "does not exist in the system",
        )

    db_user = db.query(AuthUserModel).filter(
        AuthUserModel.username == auth_user.username
    ).first()

    db_auth_method = db.query(AuthMethodModel).filter(
        AuthMethodModel.name == auth_user.auth_method
    ).first()

    if db_user:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"The user with this {auth_user.username} "
            + "already exists in the system",
        )

    if not db_auth_method:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"The auth method with this {auth_user.auth_method} "
            + "does not exist in the system",
        )

    new_user = AuthUserModel(
        aid=db_app.id,
        amid=db_auth_method.id,
        username=auth_user.username,
        password=get_password_hash(auth_user.password)
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {
        "message": "User created successfully"
    }


# # route to get all apps
# @router.get(
#         "/list",
#         response_model=dict,
#         status_code=status.HTTP_200_OK
#     )
# def get_all_apps(
#         db: dict = Depends(get_db),
#         request: Request = None
# ):
#     """
#     Get all apps
#     """
#     token = getattr(request.state, "token", None)
#     payload = verify_token(token)

#     apps = db.query(AuthUserModel.username, AuthUserModel.is_blocked).filter(
#             AppModel.uid == payload["sub"]
#         ).all()

#     print(f"Apps: {apps}")
#     return {
#         "apps": [AppSchema.model_validate(app).dict() for app in apps]
#     }


@router.post("/login", response_model=Token)
def login_for_access_token(
    form_data: UserLogin,
    db: Session = Depends(get_db),
    request: Request = None
) -> Dict[str, Any]:
    """
    Endpoint for user login. Authenticates the user using the provided
    email and password.

    Parameters:
        - db (Session): The database session.
        - form_data (OAuth2PasswordRequestForm): The form data
        containing the username and password.

    Returns:
        - Dict[str, Any]: A dictionary containing the access token 
        and token type.
    """
    token = getattr(request.state, "token", None)
    payload = verify_token(token)

    db_app = db.query(AppModel).filter(
        AppModel.client_id == form_data.client_id,
        AppModel.uid == payload["sub"]
    ).first()

    if not db_app:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"The app with this {form_data.client_id} "
            + "does not exist in the system",
        )

    # filter the user by the email and password
    user = db.query(AuthUserModel).filter(
        AuthUserModel.username == form_data.username,
        AuthUserModel.aid == db_app.id
    ).first()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Incorrect email or password",
        )

    if not verify_password(form_data.password, user.password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
        )

    access_token_expires = timedelta(
        minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES
    )
    expires_at = int((datetime.now() + access_token_expires).timestamp())
    access_token = create_access_token(
        subject=user.id, expires_delta=access_token_expires
    )

    return {
        "access_token": access_token,
        "token_type": "bearer",
        "expires": expires_at
    }
