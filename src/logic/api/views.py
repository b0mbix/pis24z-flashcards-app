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
        return Response({"message": "Flashcard set added successfully", "data": data}, status=status.HTTP_201_CREATED)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)

@csrf_exempt
def add_flashcard_set_view(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            return JsonResponse({'status': 'success'}, status=201)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
    else:
        return JsonResponse({'error': 'Invalid method'}, status=405)



@api_view(['GET'])
def example_view(request): #MOCK -  
    data = [
    {
        'name': 'sket 1',
        'cards': [
        {'term': 'vcb', 'definition': 'cv'},
        {'term': 'cv', 'definition': 'cvbb'},
        {'term': 'cvbcvb', 'definition': 'vcbc'},
        {'term': 'bcvbcv', 'definition': 'cvb'},
        {'term': 'vbcvb', 'definition': 'cvbcv'},
        {'term': '', 'definition': ''},
        {'term': '', 'definition': ''},
        {'term': '', 'definition': ''},
        {'term': '', 'definition': ''},
        {'term': '', 'definition': ''},
        ],
    },
    {
        'name': 'soot 2',
        'cards': [
        {'term': 'term1', 'definition': 'definition1'},
        {'term': 'term2', 'definition': 'definition2'},
        {'term': 'term3', 'definition': 'definition3'},
        ],
    },
    ]
    return Response(data, status=status.HTTP_200_OK)

