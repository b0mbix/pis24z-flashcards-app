from datetime import timedelta

import pytest
from api.models import (Flashcard, FlashcardFavorite, FlashcardSet,
                        FlashcardSetFavorite, FlashcardSetStats,
                        FlashcardSetTag, FlashcardStatsPercent,
                        FlashcardStatsSimple, FlashcardStatsStages, Tag, User)
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def test_user(db):
    return User.objects.create_user(username="test_user", password="password123")


@pytest.mark.django_db
def test_register_user(api_client):
    url = reverse('register')
    data = {
        "username": "new_user",
        "password": "securepassword"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert "user_id" in response.data
    assert User.objects.filter(username="new_user").exists()


@pytest.mark.django_db
def test_register_user_invalid(api_client):
    url = reverse('register')
    data = {
        "username": ""
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_400_BAD_REQUEST


@pytest.mark.django_db
def test_login_user(api_client, test_user):
    test_user.set_password("password123")  
    test_user.save()  

    url = reverse('login')
    data = {
        "username": "test_user",
        "password": "password123"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_200_OK
    assert "access" in response.data


@pytest.mark.django_db
def test_login_user_invalid(api_client):
    url = reverse('login')
    data = {
        "username": "nonexistent_user",
        "password": "wrongpassword"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_400_BAD_REQUEST


@pytest.mark.django_db
def test_add_flashcard_set(api_client, test_user):
    url = reverse('add_flashcard_set')
    data = {
        "user_id": test_user.id,
        "name": "Test Flashcards",
        "description": "Description of the set"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert "set_id" in response.data
    assert FlashcardSet.objects.filter(name="Test Flashcards").exists()


@pytest.mark.django_db
def test_get_flashcard_sets(api_client, test_user):
    FlashcardSet.objects.all().delete()
    FlashcardSet.objects.create(
        user=test_user, name="Set 1", description="Description 1"
        )
    FlashcardSet.objects.create(
        user=test_user, name="Set 2", description="Description 2"
        )

    url = reverse('get_flashcard_sets')
    response = api_client.get(url)
    assert response.status_code == status.HTTP_200_OK
    assert len(response.data) == 2
    assert response.data[0]["name"] == "Set 1"
    assert response.data[1]["name"] == "Set 2"


@pytest.mark.django_db
def test_get_flashcard_set_details(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Details Set", description="Detailed description"
        )
    Flashcard.objects.create(set=flashcard_set, question="Q1", answer="A1")
    tag = Tag.objects.create(name="Tag1")
    FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)

    url = reverse('get_flashcard_set', args=[flashcard_set.id])
    response = api_client.get(url)
    assert response.status_code == status.HTTP_200_OK
    assert response.data["name"] == "Details Set"
    assert len(response.data["flashcards"]) == 1
    assert response.data["flashcards"][0]["question"] == "Q1"
    assert response.data["tags"][0]["name"] == "Tag1"


@pytest.mark.django_db
def test_add_tag(api_client):
    url = reverse('add_tag')
    data = {"name": "New Tag"}
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert "tag_id" in response.data
    assert Tag.objects.filter(name="New Tag").exists()


@pytest.mark.django_db
def test_get_tag(api_client):
    tag = Tag.objects.create(name="Existing Tag")
    url = reverse('get_tag', args=[tag.id])
    response = api_client.get(url)
    assert response.status_code == status.HTTP_200_OK
    assert response.data["name"] == "Existing Tag"


@pytest.mark.django_db
def test_update_tag(api_client):
    tag = Tag.objects.create(name="Old Name")
    url = reverse('update_tag', args=[tag.id])
    data = {"name": "Updated Name"}
    response = api_client.put(url, data, format='json')
    assert response.status_code == status.HTTP_200_OK
    assert Tag.objects.get(id=tag.id).name == "Updated Name"


@pytest.mark.django_db
def test_delete_tag(api_client):
    tag = Tag.objects.create(name="To Delete")
    url = reverse('delete_tag', args=[tag.id])
    response = api_client.delete(url)
    assert response.status_code == status.HTTP_204_NO_CONTENT
    assert not Tag.objects.filter(id=tag.id).exists()


@pytest.mark.django_db
def test_add_flashcard(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Set for Flashcard"
        )
    url = reverse('add_flashcard')
    data = {
        "set_id": flashcard_set.id,
        "question": "What is Python?",
        "answer": "A programming language"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert Flashcard.objects.filter(question="What is Python?").exists()


@pytest.mark.django_db
def test_delete_flashcard(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Set for Delete Test"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    url = reverse('delete_flashcard', args=[flashcard.id])
    response = api_client.delete(url)
    assert response.status_code == status.HTTP_204_NO_CONTENT
    assert not Flashcard.objects.filter(id=flashcard.id).exists()


@pytest.mark.django_db
def test_add_flashcard_to_favorites(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Set with Flashcard"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    url = reverse('add_flashcard_to_favorites')
    data = {
        "user_id": test_user.id,
        "flashcard_id": flashcard.id
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert FlashcardFavorite.objects.filter(
        user=test_user, flashcard=flashcard
        ).exists()


@pytest.mark.django_db
def test_add_flashcard_set_stats(api_client, test_user):
    api_client.force_authenticate(user=test_user)
    
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Stats Set"
        )
    url = reverse('add_flashcard_set_stats')
    data = {
        "user_id": test_user.id,
        "set_id": flashcard_set.id,
        "flashcards_viewed": 5,
        "total_study_time": timedelta(seconds=120).total_seconds()
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert FlashcardSetStats.objects.filter(
        set=flashcard_set, user=test_user
        ).exists()


@pytest.mark.django_db
def test_get_flashcard_set_stats(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Stats Set"
        )
    stats = FlashcardSetStats.objects.create(
        user=test_user,
        set=flashcard_set,
        flashcards_viewed=10,
        total_study_time=timedelta(seconds=300)
    )
    url = reverse('get_flashcard_set_stats', args=[stats.id])
    response = api_client.get(url)
    assert response.status_code == status.HTTP_200_OK
    assert response.data["flashcards_viewed"] == 10
    assert response.data["total_study_time"] == 300


@pytest.mark.django_db
def test_add_flashcard_stats_simple(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Simple Stats Set"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    url = reverse('add_flashcard_stats_simple')
    data = {
        "user_id": test_user.id,
        "flashcard_id": flashcard.id,
        "view_count": 3
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert FlashcardStatsSimple.objects.filter(
        user=test_user, flashcard=flashcard
        ).exists()


@pytest.mark.django_db
def test_update_flashcard_stats_simple(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Simple Stats Set"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    stats = FlashcardStatsSimple.objects.create(
        user=test_user, flashcard=flashcard, view_count=2
        )
    url = reverse('update_flashcard_stats_simple', args=[stats.id])
    data = {
        "view_count": 5
    }
    response = api_client.put(url, data, format='json')
    assert response.status_code == status.HTTP_200_OK
    assert FlashcardStatsSimple.objects.get(id=stats.id).view_count == 5


@pytest.mark.django_db
def test_add_flashcard_stats_stages(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Stages Stats Set"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    url = reverse('add_flashcard_stats_stages')
    data = {
        "user_id": test_user.id,
        "flashcard_id": flashcard.id,
        "view_count": 1,
        "stage": 2,
        "learned": False
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert FlashcardStatsStages.objects.filter(
        user=test_user, flashcard=flashcard
        ).exists()


@pytest.mark.django_db
def test_update_flashcard_stats_stages(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Stages Stats Set"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    stats = FlashcardStatsStages.objects.create(
        user=test_user,
        flashcard=flashcard,
        view_count=1,
        stage=1,
        learned=False
        )
    url = reverse('update_flashcard_stats_stages', args=[stats.id])
    data = {
        "view_count": 3,
        "stage": 4,
        "learned": True
    }
    response = api_client.put(url, data, format='json')
    assert response.status_code == status.HTTP_200_OK
    stats.refresh_from_db()
    assert stats.view_count == 3
    assert stats.stage == 4
    assert stats.learned is True


@pytest.mark.django_db
def test_add_flashcard_stats_percent(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Percent Stats Set"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    url = reverse('add_flashcard_stats_percent')
    data = {
        "user_id": test_user.id,
        "flashcard_id": flashcard.id,
        "view_count": 7,
        "learning_stage": "in_progress"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert FlashcardStatsPercent.objects.filter(
        user=test_user, flashcard=flashcard
        ).exists()


@pytest.mark.django_db
def test_update_flashcard_stats_percent(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(
        user=test_user, name="Percent Stats Set"
        )
    flashcard = Flashcard.objects.create(
        set=flashcard_set, question="Q1", answer="A1"
        )
    stats = FlashcardStatsPercent.objects.create(
        user=test_user,
        flashcard=flashcard,
        view_count=3,
        learning_stage="not_learned"
        )
    url = reverse('update_flashcard_stats_percent', args=[stats.id])
    data = {
        "view_count": 10,
        "learning_stage": "mastered"
    }
    response = api_client.put(url, data, format='json')
    assert response.status_code == status.HTTP_200_OK
    stats.refresh_from_db()
    assert stats.view_count == 10
    assert stats.learning_stage == "mastered"
