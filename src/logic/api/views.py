from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from django.views.decorators.csrf import csrf_exempt
import json
from models import User, FlashcardSet, Flashcard, Tag, FlashcardSetTag


@api_view(['POST'])
def add_user(request):
    if request.method == 'POST':
        try:
            data = request.data
            user = User.objects.create(
                username=data.get('username'),
                email=data.get('email'),
                password_hash=data.get('password_hash'),
                birth_date=data.get('birth_date'),
                is_premium=data.get('is_premium', False)
            )
            return Response({"message": "User created successfully", "user_id": user.id}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def add_flashcard_set(request):
    if request.method == 'POST':
        try:
            data = request.data
            user = User.objects.get(id=data.get('user_id'))
            flashcard_set = FlashcardSet.objects.create(
                user=user,
                name=data.get('name'),
                description=data.get('description', '')
            )
            return Response({"message": "Flashcard set created successfully", "set_id": flashcard_set.id}, status=status.HTTP_201_CREATED)
        except User.DoesNotExist:
            return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def add_flashcard(request):
    if request.method == 'POST':
        try:
            data = request.data
            flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
            flashcard = Flashcard.objects.create(
                set=flashcard_set,
                question=data.get('question'),
                answer=data.get('answer')
            )
            return Response({"message": "Flashcard created successfully", "flashcard_id": flashcard.id}, status=status.HTTP_201_CREATED)
        except FlashcardSet.DoesNotExist:
            return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def add_tag(request):
    if request.method == 'POST':
        try:
            data = request.data
            tag = Tag.objects.create(name=data.get('name'))
            return Response({"message": "Tag created successfully", "tag_id": tag.id}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def add_flashcard_set_tag(request):
    if request.method == 'POST':
        try:
            data = request.data
            flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
            tag = Tag.objects.get(id=data.get('tag_id'))
            flashcard_set_tag = FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)
            return Response({"message": "Flashcard set tagged successfully", "id": flashcard_set_tag.id}, status=status.HTTP_201_CREATED)
        except FlashcardSet.DoesNotExist:
            return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)
        except Tag.DoesNotExist:
            return Response({"error": "Tag not found"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    return Response({"message": "Invalid request method"}, status=status.HTTP_400_BAD_REQUEST)
