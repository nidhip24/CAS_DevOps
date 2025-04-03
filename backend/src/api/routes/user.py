"""
This module contains the routes for the app_user model
"""
from datetime import timedelta, datetime
from typing import Any, Dict

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from src.schemas.auth import (UserRegister, Token)
from src.database.db import get_db
from src.models import UserData
from src.security import (
    get_password_hash, create_access_token, verify_password
)
from src.config import settings


router = APIRouter()


@router.post(
        "/register",
        response_model=dict,
        status_code=status.HTTP_201_CREATED
    )
def register(user_register: UserRegister, db: Session = Depends(get_db)):
    """
    Register a new user
    """

    user = db.query(UserData).filter(
        UserData.username == user_register.username
    ).first()

    # user = user_crud.get_user_by_email(db, email=user_register.email)
    if user:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"The user with this {user_register.username} "
            + "already exists in the system",
        )

    print(user_register.password)

    # insert the user into the db
    db_user = UserData(
        username=user_register.username,
        password=get_password_hash(user_register.password),
        rid=2,
        source="api"
    )
    db.add(db_user)
    db.commit()

    # user_crud.create(db, user_in)
    return {"message": "User created successfully"}


@router.post("/login", response_model=Token)
def login_for_access_token(
    db: Session = Depends(get_db),
    form_data: OAuth2PasswordRequestForm = Depends()
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

    # filter the user by the email and password
    user = db.query(UserData).filter(
        UserData.username == form_data.username
    ).first()

    print(get_password_hash(form_data.password))

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
