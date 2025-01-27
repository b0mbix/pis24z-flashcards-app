from django.contrib.auth.models import User
from django.db import models
from datetime import timedelta


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


class FlashcardSetFavorite(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='favorite_flashcard_sets')
    set = models.ForeignKey(FlashcardSet, on_delete=models.CASCADE, related_name='favorited_by')

    class Meta:
        db_table = 'flashcardsetfavorites'
        unique_together = ('user', 'set')  # Prevent duplicate favorites

    def __str__(self):
        return f"{self.user.username} - {self.set.name}"


class FlashcardFavorite(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='favorite_flashcards')
    flashcard = models.ForeignKey(Flashcard, on_delete=models.CASCADE, related_name='favorited_by')

    class Meta:
        db_table = 'flashcardfavorites'
        unique_together = ('user', 'flashcard')  # Prevent duplicate favorites

    def __str__(self):
        return f"{self.user.username} - {self.flashcard.question[:50]}"

class FlashcardSetStats(models.Model):
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='flashcard_set_stats_user'
    )
    set = models.ForeignKey(
        FlashcardSet, on_delete=models.CASCADE, related_name='flashcard_set_stats_set'
    )
    flashcards_viewed = models.IntegerField(default=0)
    total_study_time = models.DurationField(default=timedelta(seconds=0))

    class Meta:
        db_table = 'flashcardsetstats'

    def __str__(self):
        return (f"{self.id} - set: {self.set.id} - user: {self.user.id}")

class FlashcardStatsSimple(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='flashcardstatssimple')
    flashcard = models.ForeignKey(Flashcard, on_delete=models.CASCADE, related_name='flashcardstatssimple')
    view_count = models.IntegerField(default=0)

    class Meta:
        db_table = 'flashcardstatssimple'
        unique_together = ('id', 'flashcard')  # Prevent duplicate stats for the same stats and flashcard

    def __str__(self):
        return f"{self.user.username} - {self.flashcard.id} (Views: {self.view_count})"


class FlashcardStatsStages(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='flashcardstatsstages')
    flashcard = models.ForeignKey('Flashcard', on_delete=models.CASCADE, related_name='flashcardstatsstages')
    view_count = models.IntegerField(default=0)
    stage = models.IntegerField(default=1)
    learned = models.BooleanField(default=False)

    class Meta:
        db_table = 'flashcardstatsstages'
        unique_together = ('user', 'flashcard')  # Zapobiega duplikatom dla użytkownika i fiszki

    def __str__(self):
        return f"{self.user.username} - {self.flashcard.id} (Stage: {self.stage}, Learned: {self.learned})"


class FlashcardStatsPercent(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='flashcardstatspercent')
    flashcard = models.ForeignKey('Flashcard', on_delete=models.CASCADE, related_name='flashcardstatspercent')
    view_count = models.IntegerField(default=0)
    learning_stage = models.CharField(
        max_length=20,
        choices=[
            ('not_learned', 'Not Learned'),
            ('still_learning', 'Still Learning'),
            ('almost_learned', 'Almost Learned'),
            ('learned', 'Learned')
        ],
        default='not_learned'
    )

    class Meta:
        db_table = 'flashcardstatspercent'
        unique_together = ('user', 'flashcard')  # Zapobiega duplikatom dla użytkownika i fiszki

    def __str__(self):
        return f"{self.user.username} - {self.flashcard.id} (Stage: {self.learning_stage})"