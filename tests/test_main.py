from main import func
import pytest
from hypothesis import given, settings
from hypothesis.strategies import integers


@given(a=integers(min_value=-100, max_value=100),
       b=integers(min_value=-100, max_value=100))
@settings(max_examples=10)
def test_smth_else(a, b):
    assert func(a, b) == a + b


@pytest.mark.parametrize(
    ("x", "y", "expected"),
    [
        (1, 1, 2),
        (2, 3, 5),
        (-1, 1, 0)
    ],
)
def test_something(x, y, expected):
    assert func(x, y) == expected
