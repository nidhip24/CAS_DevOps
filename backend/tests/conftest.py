"""
This is test file for the api
"""

import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from src.log import get_logger

log = get_logger(__name__)

# from src.schemas.auth import UserRegister
# from src.database.db import get_db
# from src.models import user_data as UserData

log = get_logger()

TEST_SQLALCHEMY_DATABASE_URL = (
    "mysql+mysqlconnector://root:@localhost:3306/CAS"
)


@pytest.fixture
def test_sqlalchemy_database_url():
    """ return test database"""
    return TEST_SQLALCHEMY_DATABASE_URL


engine = create_engine(TEST_SQLALCHEMY_DATABASE_URL, echo=False)


@pytest.fixture
def _engine():
    return engine


@pytest.fixture
def _test_session(_engine):
    return sessionmaker(bind=_engine, autocommit=False, autoflush=False)


def override_get_db():
    """asdasd"""
    log.debug("getting test database session")
    db = sessionmaker(bind=engine, autocommit=False, autoflush=False)()
    try:
        yield db
    finally:
        log.debug("closing test database session")
        db.close()
