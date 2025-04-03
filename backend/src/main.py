"""
Main module of the server file
"""
from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware


from src.middleware import AuthMiddleware
from src.api.routes.user import router as user
from src.api.routes.app import router as application
from src.api.routes.app_user import router as app_user

app = FastAPI(title="CAS API", version="1.0.0")
origins = ["*"]


# Custom error handler for validation errors
@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    """
    Custom error handler for validation errors
    """
    errors = []
    for error in exc.errors():
        errors.append({
            "field": error.get("loc", ["unknown"])[-1],
            "error": error.get("msg"),
        })
    return JSONResponse(
        status_code=422,
        content={
            "message": "Validation failed",
            "errors": errors
        }
    )


# Add the middleware to the app
app.add_middleware(AuthMiddleware)
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user, prefix="/v1/api/user", tags=["users"])
app.include_router(application, prefix="/v1/api/app", tags=["apps"])
app.include_router(app_user, prefix="/v1/api/app/user", tags=["apps_users"])


# @app.get("/")
# def root():
#     return {"Hello": "World"}
