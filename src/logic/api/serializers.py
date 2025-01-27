from django.contrib.auth.models import User
from rest_framework import serializers


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['username', 'password']

    def create(self, validated_data):
        password = validated_data.pop('password')

        # Create the AuthUser (handles password hashing)
        user = User.objects.create_user(
            username=validated_data['username'],
            password=password
        )

        return user


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            raise serializers.ValidationError('Invalid username')

        if not user.check_password(password):
            raise serializers.ValidationError('Invalid password')

        return user
