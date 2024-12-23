from django.urls import path
from . import views
from .views import add_flashcard_set
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from .views import add_flashcard_set
from .views import add_flashcard_set_view
from .views import era_single_session_view

urlpatterns = [
    path('example/', views.example_view, name='example'),
    path('add_flashcard_set/', add_flashcard_set_view, name='add_flashcard_set'),    
    path('eraSingleSeson/', era_single_session_view, name='era_single_session'),
]


@api_view(['POST'])
def add_flashcard_set(request):
    if request.method == 'POST':
        data = request.data
        # Here, you can process and save the data as needed
        # For example, save it to the database
        # flashcard_set = FlashcardSet.objects.create(...)

        return Response({"message": "Flashcard set added successfully", "data": data}, status=status.HTTP_201_CREATED)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)
