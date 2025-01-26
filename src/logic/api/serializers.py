# from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework import serializers
from .models import (
    User,
    FlashcardSet,
    Flashcard,
    Tag,
    FlashcardSetTag,
    FlashcardSetFavorite,
    FlashcardFavorite,
    FlashcardSetStats,
    FlashcardStatsSimple,
    FlashcardStatsStages,
    FlashcardStatsPercent,
)


class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'password']

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password']
        )
        return user


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        user = authenticate(username=username, password=password)
        if not user:
            raise serializers.ValidationError("Invalid credentials")
        return user
