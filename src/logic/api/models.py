from django.db import models


class User(models.Model):
    username = models.CharField(max_length=50, unique=True)
    email = models.EmailField(unique=True)
    password_hash = models.CharField(max_length=255)
    birth_date = models.DateField(null=True, blank=True)
    is_premium = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'users'

    def __str__(self):
        return self.username


class FlashcardSet(models.Model):
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='flashcard_sets'
    )
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    views_count = models.IntegerField(default=0)
    is_archived = models.BooleanField(default=False)
    is_public = models.BooleanField(default=False)

    class Meta:
        db_table = 'flashcardsets'

    def __str__(self):
        return self.name


class Flashcard(models.Model):
    set = models.ForeignKey(
        FlashcardSet, on_delete=models.CASCADE, related_name='flashcards'
    )
    question = models.TextField()
    answer = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'flashcards'

    def __str__(self):
        return self.question[:50]  # Return the first 50 characters of the question


class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'tags'

    def __str__(self):
        return self.name


class FlashcardSetTag(models.Model):
    set = models.ForeignKey(
        FlashcardSet, on_delete=models.CASCADE, related_name='flashcard_set_tags'
    )
    tag = models.ForeignKey(
        Tag, on_delete=models.CASCADE, related_name='tagged_flashcard_sets'
    )

    class Meta:
        db_table = 'flashcardsettags'
        unique_together = ('set', 'tag')  # Prevent duplicate tags for the same set

    def __str__(self):
        return f"{self.set.name} - {self.tag.name}"
