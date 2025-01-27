from django.contrib.auth.models import User as AuthUser
from django.contrib.auth.hashers import check_password
from rest_framework import serializers
from .models import (
    User,
)


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['username', 'password']

    def create(self, validated_data):
        password = validated_data.pop('password')

        auth_user = AuthUser.objects.create_user(
            username=validated_data['username'],
            password=password
        )

        user = User.objects.create(
            auth_user=auth_user,
        )
        return user


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        try:
            user = AuthUser.objects.get(username=username)
        except User.DoesNotExist:
            raise serializers.ValidationError('Invalid username')

        if not check_password(password, user.password):
            raise serializers.ValidationError('Invalid password')

        return user
