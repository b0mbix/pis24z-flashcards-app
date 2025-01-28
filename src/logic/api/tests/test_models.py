import pytest
from api.models import (Flashcard, FlashcardFavorite, FlashcardSet,
                        FlashcardSetFavorite, FlashcardSetStats,
                        FlashcardSetTag, FlashcardStatsPercent,
                        FlashcardStatsSimple, FlashcardStatsStages, Tag)
from django.contrib.auth.models import User
from django.db import connections
from django.db.utils import IntegrityError


@pytest.fixture(autouse=True)
def close_db_connections():
    yield
    for conn in connections.all():
        conn.close()


@pytest.mark.django_db(transaction=True)
def test_create_user():
    user = User.objects.create(
        username="michal123",
        password="bezpieczneHaslo987"
    )
    assert user.username == "michal123"
    assert user.password == "bezpieczneHaslo987"


@pytest.mark.django_db(transaction=True)
def test_str_user():
    user = User.objects.create(
        username="karolina456",
        password="hasloKarolina456"
    )
    assert str(user) == "karolina456"


@pytest.mark.django_db(transaction=True)
def test_create_flashcard_set():
    user = User.objects.create(username="adam123", password="secure123")
    flashcard_set = FlashcardSet.objects.create(
        user=user,
        name="Fiszki z matematyki",
        description="Zestaw fiszek do nauki matematyki"
    )
    assert flashcard_set.name == "Fiszki z matematyki"
    assert flashcard_set.user == user
    assert flashcard_set.description == "Zestaw fiszek do nauki matematyki"
    assert flashcard_set.views_count == 0
    assert flashcard_set.is_archived is False
    assert flashcard_set.is_public is False


@pytest.mark.django_db(transaction=True)
def test_str_flashcard_set():
    user = User.objects.create(username="adam999", password="secure123")
    flashcard_set = FlashcardSet.objects.create(
        user=user,
        name="Fiszki z historii",
        description="Zestaw fiszek dotyczących historii"
    )
    assert str(flashcard_set) == "Fiszki z historii"


@pytest.mark.django_db(transaction=True)
def test_create_flashcard():
    user = User.objects.create(username="adam123", password="secure123")
    flashcard_set = FlashcardSet.objects.create(
        user=user,
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
    user = User.objects.create(username="adam789", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user,
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
    tag = Tag.objects.create(name="FiszkiTestoweFR")
    assert tag.name == "FiszkiTestoweFR"


@pytest.mark.django_db(transaction=True)
def test_str_tag():
    tag = Tag.objects.create(name="Biologia")
    assert str(tag) == "Biologia"


@pytest.mark.django_db(transaction=True)
def test_create_flashcard_set_tag():
    user = User.objects.create(username="tomasz666", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z programowania"
        )
    tag = Tag.objects.create(name="Python")
    flashcard_set_tag = FlashcardSetTag.objects.create(
        set=flashcard_set, tag=tag
        )

    assert flashcard_set_tag.set == flashcard_set
    assert flashcard_set_tag.tag == tag
    assert str(flashcard_set_tag) == "Fiszki z programowania - Python"


@pytest.mark.django_db(transaction=True)
def test_unique_tag_for_flashcard_set():
    user = User.objects.create(username="tomasz234", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z literatury"
        )
    tag = Tag.objects.create(name="Renesans")

    FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)

    with pytest.raises(IntegrityError):
        FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)


@pytest.mark.django_db(transaction=True)
def test_create_tag_for_nonexistent_flashcard_set():
    tag = Tag.objects.create(name="NonexistentSetTest")

    with pytest.raises(IntegrityError):
        FlashcardSetTag.objects.create(set_id=999, tag=tag)


@pytest.mark.django_db(transaction=True)
def test_create_tag_for_nonexistent_tag():
    user = User.objects.create(username="bartek567", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z języków"
        )

    with pytest.raises(IntegrityError):
        FlashcardSetTag.objects.create(set=flashcard_set, tag_id=999)


@pytest.mark.django_db(transaction=True)
def test_create_flashcard_stats_simple():
    user = User.objects.create(username="bartekADP", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z angielskiego"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="What is an apple?", answer="A fruit."
        )
    stats = FlashcardStatsSimple.objects.create(
        user=user, flashcard=flashcard, view_count=10
        )

    assert stats.user == user
    assert stats.flashcard == flashcard
    assert stats.view_count == 10


@pytest.mark.django_db(transaction=True)
def test_flashcard_stats_simple_str():
    user = User.objects.create(username="bartekCBD", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z angielskiego"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="What is an apple?", answer="A fruit."
        )
    stats = FlashcardStatsSimple.objects.create(
        user=user, flashcard=flashcard, view_count=5
        )

    expected_str = (f"{user.username} - {flashcard.id} "
                    f" (Views: {stats.view_count})"
                    )
    assert str(stats) == expected_str


@pytest.mark.django_db(transaction=True)
def test_flashcard_stats_percent_unique_constraint():
    user = User.objects.create(username="bartekAGD", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z biologii"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, 
        question="Co to jest fotosynteza?", 
        answer="Proces produkcji energii."
        )
    FlashcardStatsPercent.objects.create(
        user=user, 
        flashcard=flashcard, 
        view_count=2, 
        learning_stage="still_learning"
        )
    
    # Próba stworzenia duplikatu powinna rzucić wyjątek
    with pytest.raises(IntegrityError):
        FlashcardStatsPercent.objects.create(
            user=user, 
            flashcard=flashcard, 
            view_count=2, 
            learning_stage="learned"
            )


@pytest.mark.django_db(transaction=True)
def test_flashcard_set_favorite():
    user = User.objects.create(username="bartekDLL", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z chemii"
        )
    favorite = FlashcardSetFavorite.objects.create(
        user=user, set=flashcard_set
        )

    assert favorite.user == user
    assert favorite.set == flashcard_set
    assert str(favorite) == f"{user.username} - {flashcard_set.name}"


@pytest.mark.django_db(transaction=True)
def test_flashcard_favorite():
    user = User.objects.create(username="bartekMLG", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z biologii"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, 
        question="Co to jest DNA?", 
        answer="Nośnik informacji genetycznej"
        )
    favorite = FlashcardFavorite.objects.create(user=user, flashcard=flashcard)

    assert favorite.user == user
    assert favorite.flashcard == flashcard
    assert str(favorite) == f"{user.username} - {flashcard.question[:50]}"


@pytest.mark.django_db(transaction=True)
def test_flashcard_set_stats():
    user = User.objects.create(username="bartekPDF", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z fizyki"
        )
    stats = FlashcardSetStats.objects.create(
        user=user, set=flashcard_set, flashcards_viewed=5
        )

    assert stats.user == user
    assert stats.set == flashcard_set
    assert stats.flashcards_viewed == 5
    assert str(stats) == (f"{stats.id} - set:" 
                          f" {flashcard_set.id} - user: {user.id}"
                          )


@pytest.mark.django_db(transaction=True)
def test_flashcard_stats_stages():
    user = User.objects.create(username="bartekJPG", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z matematyki"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Ile to 2+2?", answer="4"
        )
    stats = FlashcardStatsStages.objects.create(
        user=user, flashcard=flashcard, view_count=3, stage=2, learned=True
        )

    assert stats.user == user
    assert stats.flashcard == flashcard
    assert stats.view_count == 3
    assert stats.stage == 2
    assert stats.learned is True
    assert str(stats) == (f"{user.username} - {flashcard.id} " 
                          f" (Stage: {stats.stage}, Learned: {stats.learned})"
                          )


@pytest.mark.django_db(transaction=True)
def test_flashcard_stats_percent():
    user = User.objects.create(username="bartekPNG", password="password123")
    flashcard_set = FlashcardSet.objects.create(
        user=user, name="Fiszki z języka polskiego"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, 
        question="Co to jest metafora?", 
        answer="Środek stylistyczny"
        )
    stats = FlashcardStatsPercent.objects.create(
        user=user, 
        flashcard=flashcard, 
        view_count=2, 
        learning_stage="still_learning"
        )

    assert stats.user == user
    assert stats.flashcard == flashcard
    assert stats.view_count == 2
    assert stats.learning_stage == "still_learning"
    assert str(stats) == (f"{user.username} - {flashcard.id} "
                          f"(Stage: {stats.learning_stage})"
                          )
