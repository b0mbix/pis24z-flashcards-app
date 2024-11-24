from logic.sample_logic import hello
import pytest


def test_hello():
    assert hello() == "Hello, World!"
