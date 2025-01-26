from django.urls import path
from . import views


urlpatterns = [
    path('users/add/', views.add_user, name='add_user'),
    
    path('flashcards/add/', views.add_flashcard, name='add_flashcard'),
    path('flashcards/remove/<int:flashcard_id>/', views.remove_flashcard, name='remove_flashcard'),
    path('tags/add/', views.add_tag, name='add_tag'),


    path('flashcard-sets/add/', views.add_flashcard_set, name='add_flashcard_set'),
    path('flashcard-sets/tags/add/', views.add_flashcard_set_tag, name='add_flashcard_set_tag'),
    path('flashcard-sets/all/', views.get_flashcard_sets_with_details, name='get_flashcard_sets_with_details'),
    path('flashcard-sets/<int:set_id>/all/', views.get_flashcard_specified_set_with_details, name='get_flashcard_specified_set_with_details'),

]
