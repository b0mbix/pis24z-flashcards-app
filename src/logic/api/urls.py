from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView
from . import views


urlpatterns = [
    path('token/refresh/', TokenRefreshView.as_view(), name='refresh_token'),
    path('register/', views.register, name='register'),
    path('login/', views.login, name='login'),
    path('test-auth/', views.test_auth, name='test_auth'),

    path('users/add/', views.add_user, name='add_user'),
    path('users/<int:user_id>/get/', views.get_user, name='get_user'),
    path('users/<int:user_id>/update/', views.update_user, name='update_user'),
    path('users/<int:user_id>/delete/', views.delete_user, name='delete_user'),

    path('flashcard-sets/add/', views.add_flashcard_set, name='add_flashcard_set'),
    path('flashcard-sets/all/', views.get_flashcard_sets, name='get_flashcard_sets'),
    path('flashcard-sets/<int:set_id>/get/', views.get_flashcard_set, name='get_flashcard_set'),
    path('flashcard-sets/<int:set_id>/update/', views.update_flashcard_set, name='update_flashcard_set'),
    path('flashcard-sets/<int:set_id>/delete/', views.delete_flashcard_set, name='delete_flashcard_set'),

    path('flashcards/add/', views.add_flashcard, name='add_flashcard'),
    path('flashcards/<int:flashcard_id>/get/', views.get_flashcard, name='get_flashcard'),
    path('flashcards/<int:flashcard_id>/update/', views.update_flashcard, name='update_flashcard'),
    path('flashcards/<int:flashcard_id>/delete/', views.delete_flashcard, name='delete_flashcard'),

    path('tags/add/', views.add_tag, name='add_tag'),
    path('tags/<int:tag_id>/get/', views.get_tag, name='get_tag'),
    path('tags/<int:tag_id>/update/', views.update_tag, name='update_tag'),
    path('tags/<int:tag_id>/delete/', views.delete_tag, name='delete_tag'),


    path('flashcard-sets/tags/add/', views.add_flashcard_set_tag, name='add_flashcard_set_tag'),
    path('flashcard-sets/tags/delete/', views.delete_flashcard_set_tag, name='delete_flashcard_set_tag'),

    path('flashcard-set-favorite/add/', views.add_flashcard_set_to_favorites, name='add_flashcard_set_to_favorites'),
    path('flashcard-set-favorite/<int:user_id>/delete/', views.remove_flashcard_set_from_favorites, name='delete_flashcard_set_from_favorites'),

    path('flashcard-favorites/add/', views.add_flashcard_to_favorites, name='add_flashcard_to_favorites'),
    path('flashcard-favorites/<int:user_id>/delete/', views.remove_flashcard_from_favorites, name='delete_flashcard_from_favorites'),

    path('flashcard-set-stats/add/', views.add_flashcard_set_stats, name='add_flashcard_set_stats'),
    path('flashcard-set-stats/<int:stats_id>/get/', views.get_flashcard_set_stats, name='get_flashcard_set_stats'),
    path('flashcard-set-stats/<int:stats_id>/update/', views.update_flashcard_set_stats, name='update_flashcard_set_stats'),
    path('flashcard-set-stats/<int:stats_id>/delete/', views.delete_flashcard_set_stats, name='delete_flashcard_set_stats'),

    path('flashcard-stats-simple/add/', views.add_flashcard_stats_simple, name='add_flashcard_stats_simple'),
    path('flashcard-stats-simple/<int:stats_id>/get/', views.get_flashcard_stats_simple, name='get_flashcard_stats_simple'),
    path('flashcard-stats-simple/<int:stats_id>/update/', views.update_flashcard_stats_simple, name='update_flashcard_stats_simple'),
    path('flashcard-stats-simple/<int:stats_id>/delete/', views.delete_flashcard_stats_simple, name='delete_flashcard_stats_simple'),

    path('flashcard-stats-stages/add/', views.add_flashcard_stats_stages, name='add_flashcard_stats_stages'),
    path('flashcard-stats-stages/<int:stats_id>/get/', views.get_flashcard_stats_stages, name='get_flashcard_stats_stages'),
    path('flashcard-stats-stages/<int:stats_id>/update/', views.update_flashcard_stats_stages, name='update_flashcard_stats_stages'),
    path('flashcard-stats-stages/<int:stats_id>/delete/', views.delete_flashcard_stats_stages, name='delete_flashcard_stats_stages'),

    path('flashcard-stats-percent/add/', views.add_flashcard_stats_percent, name='add_flashcard_stats_percent'),
    path('flashcard-stats-percent/<int:stats_id>/get/', views.get_flashcard_stats_percent, name='get_flashcard_stats_percent'),
    path('flashcard-stats-percent/<int:stats_id>/update/', views.update_flashcard_stats_percent, name='update_flashcard_stats_percent'),
    path('flashcard-stats-percent/<int:stats_id>/delete/', views.delete_flashcard_stats_percent, name='delete_flashcard_stats_percent')
]
