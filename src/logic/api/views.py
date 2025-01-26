# from django.http import JsonResponse
# from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view

from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
import json
from .models import User, FlashcardSet, Flashcard, Tag, FlashcardSetTag, FlashcardSetFavorite, FlashcardFavorite, FlashcardSetStats, FlashcardStatsPercent


# User

@api_view(['POST'])
def add_user(request):
    try:
        data = request.data
        user = User.objects.create(
            username=data.get('username'),
            password_hash=data.get('password_hash'),
        )
        return Response({"message": "User created successfully", "user_id": user.id}, status=status.HTTP_201_CREATED)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_user(request, user_id):
    try:
        user = User.objects.get(id=user_id)
        return Response({
            "username": user.username,
        }, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_user(request, user_id):
    try:
        user = User.objects.get(id=user_id)
        data = request.data
        user.username = data.get('username', user.username)
        user.password_hash = data.get('password_hash', user.password_hash)
        user.save()
        return Response({"message": "User updated successfully"}, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_user(request, user_id):
    try:
        user = User.objects.get(id=user_id)
        user.delete()
        return Response({"message": "User deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)


# FlashcardSet

@api_view(['POST'])
def add_flashcard_set(request):
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
        return Response({"error": "User not found"}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_flashcard_sets(request):
    flashcard_sets = FlashcardSet.objects.all()
    response = []
    for flashcard_set in flashcard_sets:
        response.append({
            "id": flashcard_set.id,
            "name": flashcard_set.name,
            "description": flashcard_set.description,
            "user_id": flashcard_set.user.id,
        })
    return Response(response, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_flashcard_set(request, set_id):
    try:
        flashcard_set = FlashcardSet.objects.get(id=set_id)
        flashcards = Flashcard.objects.filter(set=flashcard_set)
        tags = FlashcardSetTag.objects.filter(set=flashcard_set)
        return Response({
            "id": flashcard_set.id,
            "name": flashcard_set.name,
            "description": flashcard_set.description,
            "user_id": flashcard_set.user.id,
            "flashcards": [{"question": flashcard.question, "answer": flashcard.answer} for flashcard in flashcards],
            "tags": [{"id": tag.tag.id, "name": tag.tag.name} for tag in tags]
        }, status=status.HTTP_200_OK)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_flashcard_set(request, set_id):
    try:
        flashcard_set = FlashcardSet.objects.get(id=set_id)
        data = request.data
        flashcard_set.name = data.get('name', flashcard_set.name)
        flashcard_set.description = data.get('description', flashcard_set.description)
        flashcard_set.is_archived = data.get('is_archived', flashcard_set.is_archived)
        flashcard_set.is_public = data.get('is_public', flashcard_set.is_public)
        flashcard_set.save()
        return Response({"message": "Flashcard set updated successfully"}, status=status.HTTP_200_OK)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_flashcard_set(request, set_id):
    try:
        flashcard_set = FlashcardSet.objects.get(id=set_id)
        flashcard_set.delete()
        return Response({"message": "Flashcard set deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)


# Flashcard 

@api_view(['POST'])
def add_flashcard(request):
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
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
def delete_flashcard(request, flashcard_id):
    try:
        flashcard = Flashcard.objects.get(id=flashcard_id)

        try:
            set_id = flashcard.set.id
            flashcard_set = FlashcardSet.objects.get(id=set_id)
            flashcard_set.updated_at = datetime.now()
            flashcard_set.save()
        except FlashcardSet.DoesNotExist:
            return Response({"error": "Flashcard set not found"}, status=status.HTTP_400_BAD_REQUEST)
        
        return Response({"message": "Flashcard deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
    except Flashcard.DoesNotExist:
        return Response({"error": "Flashcard not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['GET'])
def get_flashcard(request, flashcard_id):
    try:
        flashcard = Flashcard.objects.get(id=flashcard_id)
        return Response({
            "question": flashcard.question,
            "answer": flashcard.answer,
            "created_at": flashcard.created_at,
        }, status=status.HTTP_200_OK)
    except Flashcard.DoesNotExist:
        return Response({"error": "Flashcard not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_flashcard(request, flashcard_id):
    try:
        flashcard = Flashcard.objects.get(id=flashcard_id)
        data = request.data
        flashcard.question = data.get('question', flashcard.question)
        flashcard.answer = data.get('answer', flashcard.answer)
        flashcard.save()
        return Response({"message": "Flashcard updated successfully"}, status=status.HTTP_200_OK)
    except Flashcard.DoesNotExist:
        return Response({"error": "Flashcard not found"}, status=status.HTTP_404_NOT_FOUND)




# Tag 

@api_view(['POST'])
def add_tag(request):
    try:
        data = request.data
        tag = Tag.objects.create(name=data.get('name'))
        return Response({"message": "Tag created successfully", "tag_id": tag.id}, status=status.HTTP_201_CREATED)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_tag(request, tag_id):
    try:
        tag = Tag.objects.get(id=tag_id)
        return Response({"name": tag.name}, status=status.HTTP_200_OK)
    except Tag.DoesNotExist:
        return Response({"error": "Tag not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_tag(request, tag_id):
    try:
        tag = Tag.objects.get(id=tag_id)
        data = request.data
        tag.name = data.get('name', tag.name)
        tag.save()
        return Response({"message": "Tag updated successfully"}, status=status.HTTP_200_OK)
    except Tag.DoesNotExist:
        return Response({"error": "Tag not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_tag(request, tag_id):
    try:
        tag = Tag.objects.get(id=tag_id)
        tag.delete()
        return Response({"message": "Tag deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
    except Tag.DoesNotExist:
        return Response({"error": "Tag not found"}, status=status.HTTP_404_NOT_FOUND)


# FlashcardSetTag

@api_view(['POST'])
def add_flashcard_set_tag(request):
    try:
        data = request.data
        flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
        tag = Tag.objects.get(id=data.get('tag_id'))
        flashcard_set_tag = FlashcardSetTag.objects.create(set=flashcard_set, tag=tag)
        return Response({"message": "Flashcard set tagged successfully", "id": flashcard_set_tag.id}, status=status.HTTP_201_CREATED)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_400_BAD_REQUEST)
    except Tag.DoesNotExist:
        return Response({"error": "Tag not found"}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
def delete_flashcard_set_tag(request, set_id, tag_id):
    try:
        flashcard_set_tag = FlashcardSetTag.objects.get(set_id=set_id, tag_id=tag_id)
        flashcard_set_tag.delete()
        return Response({"message": "Flashcard set tag deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
    except FlashcardSetTag.DoesNotExist:
        return Response({"error": "Tag not found in this flashcard set"}, status=status.HTTP_404_NOT_FOUND)


# FlashcardSetFavaorite

@api_view(['POST'])
def add_flashcard_set_to_favorites(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
        
        flashcard_set_favorite, created = FlashcardSetFavorite.objects.get_or_create(user=user, set=flashcard_set)
        
        if created:
            return Response({"message": "Flashcard set added to favorites"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"message": "Flashcard set already in favorites"}, status=status.HTTP_400_BAD_REQUEST)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def remove_flashcard_set_from_favorites(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
        
        flashcard_set_favorite = FlashcardSetFavorite.objects.get(user=user, set=flashcard_set)
        flashcard_set_favorite.delete()
        
        return Response({"message": "Flashcard set removed from favorites"}, status=status.HTTP_204_NO_CONTENT)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSetFavorite.DoesNotExist:
        return Response({"error": "Flashcard set not found in favorites"}, status=status.HTTP_404_NOT_FOUND)


# FlascardFavorite

@api_view(['POST'])
def add_flashcard_to_favorites(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard = Flashcard.objects.get(id=data.get('flashcard_id'))
        
        flashcard_favorite, created = FlashcardFavorite.objects.get_or_create(user=user, flashcard=flashcard)
        
        if created:
            return Response({"message": "Flashcard added to favorites"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"message": "Flashcard already in favorites"}, status=status.HTTP_400_BAD_REQUEST)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except Flashcard.DoesNotExist:
        return Response({"error": "Flashcard not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def remove_flashcard_from_favorites(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard = Flashcard.objects.get(id=data.get('flashcard_id'))
        
        flashcard_favorite = FlashcardFavorite.objects.get(user=user, flashcard=flashcard)
        flashcard_favorite.delete()
        
        return Response({"message": "Flashcard removed from favorites"}, status=status.HTTP_204_NO_CONTENT)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except Flashcard.DoesNotExist:
        return Response({"error": "Flashcard not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardFavorite.DoesNotExist:
        return Response({"error": "Flashcard not found in favorites"}, status=status.HTTP_404_NOT_FOUND)


# FlashcardSetStats

@api_view(['POST'])
def create_flashcard_set_stats(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
        
        flashcard_set_stats = FlashcardSetStats.objects.create(
            user=user,
            set=flashcard_set,
            flashcards_viewed=data.get('flashcards_viewed', 0),
            total_study_time=data.get('total_study_time', '0:00:00'),
            correct_answers=data.get('correct_answers', 0),
            incorrect_answers=data.get('incorrect_answers', 0),
            completion_percentage=data.get('completion_percentage', 0)
        )
        return Response({"message": "Flashcard set stats created successfully", "stats_id": flashcard_set_stats.id}, status=status.HTTP_201_CREATED)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_flashcard_set_stats(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
        
        flashcard_set_stats = FlashcardSetStats.objects.get(user=user, set=flashcard_set)
        flashcard_set_stats.flashcards_viewed = data.get('flashcards_viewed', flashcard_set_stats.flashcards_viewed)
        flashcard_set_stats.total_study_time = data.get('total_study_time', flashcard_set_stats.total_study_time)
        flashcard_set_stats.correct_answers = data.get('correct_answers', flashcard_set_stats.correct_answers)
        flashcard_set_stats.incorrect_answers = data.get('incorrect_answers', flashcard_set_stats.incorrect_answers)
        flashcard_set_stats.completion_percentage = data.get('completion_percentage', flashcard_set_stats.completion_percentage)
        flashcard_set_stats.save()
        
        return Response({"message": "Flashcard set stats updated successfully"}, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSetStats.DoesNotExist:
        return Response({"error": "Flashcard set stats not found"}, status=status.HTTP_404_NOT_FOUND)


# FlashcardStatsPercent

@api_view(['POST'])
def create_flashcard_stats_percent(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard = Flashcard.objects.get(id=data.get('flashcard_id'))
        
        flashcard_stats = FlashcardStatsPercent.objects.create(
            user=user,
            flashcard=flashcard,
            view_count=data.get('view_count', 0),
            learning_stage=data.get('learning_stage', 'not_learned')
        )
        return Response({"message": "Flashcard stats created successfully", "stats_id": flashcard_stats.id}, status=status.HTTP_201_CREATED)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except Flashcard.DoesNotExist:
        return Response({"error": "Flashcard not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_flashcard_stats_percent(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard = Flashcard.objects.get(id=data.get('flashcard_id'))
        
        flashcard_stats = FlashcardStatsPercent.objects.get(user=user, flashcard=flashcard)
        flashcard_stats.view_count = data.get('view_count', flashcard_stats.view_count)
        flashcard_stats.learning_stage = data.get('learning_stage', flashcard_stats.learning_stage)
        flashcard_stats.save()
        
        return Response({"message": "Flashcard stats updated successfully"}, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except Flashcard.DoesNotExist:
        return Response({"error": "Flashcard not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardStatsPercent.DoesNotExist:
        return Response({"error": "Flashcard stats not found"}, status=status.HTTP_404_NOT_FOUND)


# Reset Statystyk uczenia fiszek

@api_view(['PUT'])
def reset_flashcard_set_stats(request):
    try:
        data = request.data
        user = User.objects.get(id=data.get('user_id'))
        flashcard_set = FlashcardSet.objects.get(id=data.get('set_id'))
        
        flashcard_set_stats = FlashcardSetStats.objects.get(user=user, set=flashcard_set)
        flashcard_set_stats.flashcards_viewed = 0
        flashcard_set_stats.total_study_time = '0:00:00'
        flashcard_set_stats.correct_answers = 0
        flashcard_set_stats.incorrect_answers = 0
        flashcard_set_stats.completion_percentage = 0
        flashcard_set_stats.save()

        flashcards = Flashcard.objects.filter(set=flashcard_set)
        for flashcard in flashcards:
            flashcard_stats = FlashcardStatsPercent.objects.get(user=user, flashcard=flashcard)
            flashcard_stats.view_count = 0
            flashcard_stats.correct_answers = 0
            flashcard_stats.incorrect_answers = 0
            flashcard_stats.total_study_time = '0:00:00'
            flashcard_stats.last_answered_at = None
            flashcard_stats.learning_stage = 'not_learned'
            flashcard_stats.save()
        
        return Response({"message": "Flashcard set stats and flashcard stats reset successfully"}, status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSet.DoesNotExist:
        return Response({"error": "Flashcard set not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardSetStats.DoesNotExist:
        return Response({"error": "Flashcard set stats not found"}, status=status.HTTP_404_NOT_FOUND)
    except FlashcardStatsPercent.DoesNotExist:
        return Response({"error": "Some flashcard stats not found"}, status=status.HTTP_404_NOT_FOUND)
