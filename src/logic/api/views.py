from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from django.views.decorators.csrf import csrf_exempt
import json

@api_view(['POST'])
def add_flashcard_set(request):
    if request.method == 'POST':
        data = request.data
        # Here, you can process and save the data as needed
        # For example, save it to the database
        # flashcard_set = FlashcardSet.objects.create(...)
        return Response({"message": "Flashcard set added successfully", "data": data}, status=status.HTTP_201_CREATED)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)

@csrf_exempt
def add_flashcard_set_view(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            # Process the data here (e.g., saving to database)
            return JsonResponse({'status': 'success'}, status=201)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
    else:
        return JsonResponse({'error': 'Invalid method'}, status=405)

def era_single_session_view(request):
    # Mock data to return, you can replace this with actual data retrieval logic
    data = {
        "session": "mock_session_data",
        "description": "This is a mock session for the Flutter frontend to consume"
    }
    return JsonResponse(data)

def example_view(request):
    data = {
        "message":"heloooooo little boy!!!",
        "status": "success",
        "items": [1, 2, 3, 4],
    }
    return JsonResponse(data)

