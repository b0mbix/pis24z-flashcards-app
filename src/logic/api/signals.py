from django.core.management import call_command
from django.db.models.signals import post_migrate
from django.dispatch import receiver
import os
from django.conf import settings
import glob

@receiver(post_migrate)
def load_fixtures(sender, **kwargs):
    fixtures_path = os.path.join(settings.BASE_DIR, 'api/fixtures/*.json') 
    fixtures = sorted(glob.glob(fixtures_path))

    for fixture in fixtures:
        call_command('loaddata', fixture)
