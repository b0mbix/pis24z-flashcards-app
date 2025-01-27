from django.contrib import admin
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

admin.site.register(FlashcardSet)
admin.site.register(Flashcard)
admin.site.register(Tag)
admin.site.register(FlashcardSetTag)
admin.site.register(FlashcardSetFavorite)
admin.site.register(FlashcardFavorite)
admin.site.register(FlashcardSetStats)
admin.site.register(FlashcardStatsSimple)
admin.site.register(FlashcardStatsStages)
admin.site.register(FlashcardStatsPercent)
