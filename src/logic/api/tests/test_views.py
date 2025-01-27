import pytest
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status
from api.models import User, FlashcardSet, Flashcard, Tag, FlashcardSetTag


@pytest.fixture
def api_client():
    return APIClient()


@pytest.fixture
def test_user():
    return User.objects.create(username="adam123", email="superadam@test.com", password="321mada")


@pytest.mark.django_db
def test_add_user(api_client):
    url = reverse('add_user')
    data = {
        "username": "test_użytkownik",
        "email": "test@tururu.com",
        "password": "giga_bezpieczne_hasło",
        "birth_date": "1995-04-20",
        "is_premium": True
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert response.data["message"] == "User created successfully"
    assert User.objects.filter(username="test_użytkownik").exists()


@pytest.mark.django_db
def test_add_user_missing_fields(api_client):
    url = reverse('add_user')
    data = {
        "username": "brak_emaila"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_400_BAD_REQUEST
    assert "error" in response.data


@pytest.mark.django_db
def test_add_flashcard_set(api_client, test_user):
    url = reverse('add_flashcard_set')
    data = {
        "user_id": test_user.id,
        "name": "Super Fiszki",
        "description": "FISZKI FISZKI FISZKI FISZKI"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert response.data["message"] == "Flashcard set created successfully"
    assert FlashcardSet.objects.filter(name="Super Fiszki").exists()
    assert FlashcardSet.objects.filter(description="FISZKI FISZKI FISZKI FISZKI").exists()


@pytest.mark.django_db
def test_get_flashcard_sets_with_details(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(user=test_user, name="ZestawTest", description="mega")
    Flashcard.objects.create(set=flashcard_set, question="Pytanie1", answer="Odpowiedź1")
    tag = Tag.objects.create(name="Kategoria1")
    FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)

    url = reverse('get_flashcard_sets_with_details')
    response = api_client.get(url)
    assert response.status_code == status.HTTP_200_OK
    assert len(response.data) == 1
    assert response.data[0]["name"] == "ZestawTest"
    assert response.data[0]["flashcards"][0]["question"] == "Pytanie1"
    assert response.data[0]["tags"][0]["name"] == "Kategoria1"


@pytest.mark.django_db
def test_add_flashcard(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(user=test_user, name="ZestawTest")
    url = reverse('add_flashcard')
    data = {
        "set_id": flashcard_set.id,
        "question": "Koń",
        "answer": "Jaki jest koń każdy widzi"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert response.data["message"] == "Flashcard created successfully"
    assert Flashcard.objects.filter(question="Koń").exists()
    assert Flashcard.objects.filter(answer="Jaki jest koń każdy widzi").exists()


@pytest.mark.django_db
def test_add_flashcard_set_without_name(api_client, test_user):
    url = reverse('add_flashcard_set')
    data = {
        "user_id": test_user.id,
        "description": "Brak nazwy zestawu"
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_400_BAD_REQUEST
    assert "error" in response.data


@pytest.mark.django_db
def test_add_tag(api_client):
    url = reverse('add_tag')
    data = {"name": "Giga Kategoria Test"}
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert response.data["message"] == "Tag created successfully"
    assert Tag.objects.filter(name="Giga Kategoria Test").exists()


@pytest.mark.django_db
def test_add_flashcard_set_tag(api_client, test_user):
    flashcard_set = FlashcardSet.objects.create(user=test_user, name="ZestawTest")
    tag = Tag.objects.create(name="Internet")
    url = reverse('add_flashcard_set_tag')
    data = {
        "set_id": flashcard_set.id,
        "tag_id": tag.id
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_201_CREATED
    assert response.data["message"] == "Flashcard set tagged successfully"
    assert FlashcardSetTag.objects.filter(set=flashcard_set, tag=tag).exists()


@pytest.mark.django_db
def test_add_flashcard_set_tag_invalid_set(api_client):
    tag = Tag.objects.create(name="Internet")
    url = reverse('add_flashcard_set_tag')
    data = {
        "set_id": 999,
        "tag_id": tag.id
    }
    response = api_client.post(url, data, format='json')
    assert response.status_code == status.HTTP_400_BAD_REQUEST
    assert "error" in response.data
