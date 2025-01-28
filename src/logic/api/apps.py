from django.apps import AppConfig


class ApiConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'api'

    def ready(self):
        # TODO - uncomment if needed when needed, delete if not and remove "pass"
        # import api.signals
        pass