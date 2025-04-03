"""
Routes for the app
"""
# from typing import Any, Dict
import uuid
import secrets
import json

from fastapi import APIRouter, Depends, HTTPException, status, Request
from sqlalchemy.orm import Session

from src.schemas.app import App
from src.schemas.app_schema import AppSchema
from src.database.db import get_db
from src.models import App as AppModel
from src.models import AuthMethod as AuthMethodModel
from src.models import AppConfig as AppConfigModel
from src.security import (
    verify_token
)
# from src.config import settings


router = APIRouter()


@router.post(
        "/create",
        response_model=dict,
        status_code=status.HTTP_201_CREATED
    )
def register_app(
    app: App,
    db: Session = Depends(get_db),
    request: Request = None
):
    """
    Register a new user
    """
    token = getattr(request.state, "token", None)
    payload = verify_token(token)

    db_app = db.query(AppModel).filter(
        AppModel.name == app.name
    ).first()

    db_auth_method = db.query(AuthMethodModel).filter(
        AuthMethodModel.name == app.auth_method
    ).first()

    # user = user_crud.get_user_by_email(db, email=user_register.email)
    if db_app:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"The app with this {app.name} "
            + "already exists in the system",
        )

    if not db_auth_method:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"The auth method with this {app.auth_method} "
            + "does not exist in the system",
        )

    # Generate unique client_id and client_secret
    client_id = str(uuid.uuid4())
    client_secret = secrets.token_hex(32)

    # insert the user into the db
    db_user_app = AppModel(
        name=app.name,
        uid=payload["sub"],
        amid=db_auth_method.id,
        client_id=client_id,
        secret=client_secret
    )
    db.add(db_user_app)
    db.commit()
    db.refresh(db_user_app)

    if app.metadata:
        db_app_config = AppConfigModel(
            aid=db_user_app.id,
            metadata_=json.dumps(app.metadata)
        )
        db.add(db_app_config)
        db.commit()
        db.refresh(db_app_config)

    return {
        "message": "App registered successfully",
        "client_id": db_user_app.client_id,
        "client_secret": db_user_app.secret,
    }


# route to get all apps
@router.get(
        "/list",
        response_model=dict,
        status_code=status.HTTP_200_OK
    )
def get_all_apps(
        db: dict = Depends(get_db),
        request: Request = None
    ):
    """
    Get all apps
    """
    token = getattr(request.state, "token", None)
    payload = verify_token(token)

    apps = db.query(AppModel.name, AppModel.client_id, AppModel.secret).filter(
            AppModel.uid == payload["sub"]
        ).all()

    print(f"Apps: {apps}")
    return {
        "apps": [AppSchema.model_validate(app).dict() for app in apps]
    }
