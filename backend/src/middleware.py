"""
Middleware to protect certain paths in the API.
"""
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
from fastapi import HTTPException, status
from fastapi.responses import JSONResponse


from src.config import settings
from src.security import (
    verify_token
)


class AuthMiddleware(BaseHTTPMiddleware):
    """
    Middleware to protect certain paths in the API.
    """
    def __init__(self, app, protected_paths=None):
        super().__init__(app)
        self.protected_paths = (
            protected_paths or
            settings.PROTECTED_PATHS.split(",")
        )

    async def dispatch(self, request: Request, call_next):
        """
        Handle the request and check if the user is authenticated.
        """
        # Check if the URL is in the protected paths
        if any(
            request.url.path.startswith(path) for path in self.protected_paths
        ):
            try:
                token = request.headers.get("Authorization")
                if not token or not self.authenticate_user(token):
                    raise HTTPException(
                        status_code=status.HTTP_401_UNAUTHORIZED,
                        detail="Unauthorized access"
                    )
                request.state.token = token
            except HTTPException as exc:
                return JSONResponse(
                    content={"detail": exc.detail},
                    status_code=exc.status_code
                )

        response = await call_next(request)
        return response

    @staticmethod
    def authenticate_user(token: str) -> bool:
        """
        Authenticate the user using the token.
        """
        return (verify_token(token) is not None)
