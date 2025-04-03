"""
This is the __init__.py file for the models package
"""
# from src.models.user_data import UserData as user_data
# from src.models.app import App as app
# from src.models.app_config import AppConfig as app_config
# from src.models.auth_method import AuthMethod as auth_method
# from src.models.auth_token import AuthToken as auth_token
# from src.models.auth_trail import AuthTrail as auth_trail
# from src.models.auth_user import AuthUser as auth_user
# from src.models.user_role import UserRole as user_role

# __all__ = [
#     "app_config",
#     "app",
#     "auth_method",
#     "auth_token",
#     "auth_trail",
#     "auth_user",
#     "user_data",
#     "user_role"
# ]

from .user_data import UserData
from .app import App
from .app_config import AppConfig
from .auth_method import AuthMethod
from .auth_token import AuthToken
from .auth_trail import AuthTrail
from .auth_user import AuthUser
from .user_role import UserRole

__all__ = [
    "UserData",
    "App",
    "AppConfig",
    "AuthMethod",
    "AuthToken",
    "AuthTrail",
    "AuthUser",
    "UserRole",
]
