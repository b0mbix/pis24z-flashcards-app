from django.urls import path
from . import views
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view


urlpatterns = [
    path('users/add/', views.add_user, name='add_user'),
    # path('flashcard-sets/all/', TODO...)
    path('flashcard-sets/add/', views.add_flashcard_set, name='add_flashcard_set'),
    path('flashcard-sets/tags/add/', views.add_flashcard_set_tag, name='add_flashcard_set_tag'),
    path('flashcards/add/', views.add_flashcard, name='add_flashcard'),
    path('tags/add/', views.add_tag, name='add_tag'),
]
