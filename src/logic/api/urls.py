from django.urls import path
from . import views
from .views import add_flashcard_set
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view

from . import views

urlpatterns = [
    path('example/', views.example_view, name='example'),  
    path('add_flashcard_set/', views.add_flashcard_set, name='add_flashcard_set'), 
]
