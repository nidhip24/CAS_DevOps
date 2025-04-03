"""
Unit tests for the database module
"""

from typing import Generator
from unittest.mock import patch

import pytest
from sqlalchemy.orm import Session

# from src.database.db import get_db
from tests.conftest import override_get_db


@patch("src.database.db.get_db", return_value=override_get_db())
def test_get_db(mock_get_db):
    """
    testing get_db function
    """

    # Test case 1: Check if the function returns a generator
    db = mock_get_db()
    print(db)
    assert isinstance(db, Generator)

    # Test case 2: Check if the generator yields a session object
    session: Session = next(db)
    assert isinstance(session, Session)

    with pytest.raises(StopIteration) as e:
        session = next(db)
    assert e.type == StopIteration
