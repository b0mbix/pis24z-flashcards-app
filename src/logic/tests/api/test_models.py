import pytest
from logic.api.models import User, FlashcardSet, Flashcard, Tag, FlashcardSetTag
from django.db.utils import IntegrityError
from django.db import connections


# Fixture, aby zamknąć połączenia z bazą danych po każdym teście
@pytest.fixture(autouse=True)
def close_db_connections():
    yield
    for conn in connections.all():
        conn.close()


@pytest.mark.django_db(transaction=True)
def test_create_user():
    user = User.objects.create(
        username="michal123", 
        email="michal123@example.com", 
        password_hash="bezpieczneHaslo987"
    )
    assert user.username == "michal123"
    assert user.email == "michal123@example.com"
    assert user.password_hash == "bezpieczneHaslo987"
    assert user.is_premium is False


@pytest.mark.django_db(transaction=True)
def test_str_user():
    user = User.objects.create(
        username="karolina456", 
        email="karolina456@example.com", 
        password_hash="hasloKarolina456"
    )
    assert str(user) == "karolina456"


@pytest.mark.django_db(transaction=True)
def test_create_flashcard_set(test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user,
        name="Fiszki z matematyki",
        description="Zestaw fiszek do nauki matematyki"
    )
    assert flashcard_set.name == "Fiszki z matematyki"
    assert flashcard_set.user == test_user
    assert flashcard_set.description == "Zestaw fiszek do nauki matematyki"
    assert flashcard_set.views_count == 0
    assert flashcard_set.is_archived is False
    assert flashcard_set.is_public is False


@pytest.mark.django_db(transaction=True)
def test_str_flashcard_set():
    flashcard_set = FlashcardSet.objects.create(
        user=User.objects.create(username="test_user", email="test_user@example.com", password_hash="password123"),
        name="Fiszki z historii",
        description="Zestaw fiszek dotyczących historii"
    )
    assert str(flashcard_set) == "Fiszki z historii"


@pytest.mark.django_db(transaction=True)
def test_create_flashcard(test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user,
        name="Fiszki z fizyki"
    )
    flashcard = Flashcard.objects.create(
        set=flashcard_set,
        question="Co to jest siła?",
        answer="Siła to działanie, które zmienia ruch ciała"
    )
    assert flashcard.set == flashcard_set
    assert flashcard.question == "Co to jest siła?"
    assert flashcard.answer == "Siła to działanie, które zmienia ruch ciała"


@pytest.mark.django_db(transaction=True)
def test_str_flashcard():
    flashcard_set = FlashcardSet.objects.create(
        user=User.objects.create(username="adam789", email="adam789@example.com", password_hash="password123"),
        name="Fiszki z geografii"
    )
    flashcard = Flashcard.objects.create(
        set=flashcard_set,
        question="Jakie jest największe ocean na Ziemi?",
        answer="Ocean Spokojny"
    )
    assert str(flashcard) == "Jakie jest największe ocean na Ziemi?"


@pytest.mark.django_db(transaction=True)
def test_create_tag():
    tag = Tag.objects.create(name="Matematyka")
    assert tag.name == "Matematyka"


@pytest.mark.django_db(transaction=True)
def test_str_tag():
    tag = Tag.objects.create(name="Biologia")
    assert str(tag) == "Biologia"


@pytest.mark.django_db(transaction=True)
def test_create_flashcard_set_tag(test_user):
    flashcard_set = FlashcardSet.objects.create(user=test_user, name="Fiszki z programowania")
    tag = Tag.objects.create(name="Python")
    flashcard_set_tag = FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)
    
    assert flashcard_set_tag.set == flashcard_set
    assert flashcard_set_tag.tag == tag
    assert str(flashcard_set_tag) == "Fiszki z programowania - Python"


@pytest.mark.django_db(transaction=True)
def test_unique_tag_for_flashcard_set():
    flashcard_set = FlashcardSet.objects.create(user=User.objects.create(username="tomasz234", email="tomasz234@example.com", password_hash="password123"), name="Fiszki z literatury")
    tag = Tag.objects.create(name="Renesans")

    FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)
    
    with pytest.raises(IntegrityError):
        FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)


@pytest.mark.django_db(transaction=True)
def test_create_tag_for_nonexistent_flashcard_set():
    tag = Tag.objects.create(name="NieistniejacyTag")
    
    with pytest.raises(ValueError):
        FlashcardSetTag.objects.create(set_id=999, tag=tag)


@pytest.mark.django_db(transaction=True)
def test_create_tag_for_nonexistent_tag():
    flashcard_set = FlashcardSet.objects.create(user=User.objects.create(username="bartek567", email="bartek567@example.com", password_hash="password123"), name="Fiszki z języków")
    
    with pytest.raises(ValueError):
        FlashcardSetTag.objects.create(set=flashcard_set, tag_id=999)
