import os
from pathlib import Path

# Budowanie ścieżek w projekcie
BASE_DIR = Path(__file__).resolve().parent.parent

# Ustawienie klucza tajnego
SECRET_KEY = os.getenv('DJANGO_SECRET_KEY', 'django-insecure-i1-myd#3&cj#m-6qmj5rdv-x(%t^segal)=%2y7sqo&mu6!urd')

# Włącz lub wyłącz debugowanie w zależności od zmiennej środowiskowej
DEBUG = os.getenv('DJANGO_DEBUG', 'True') == 'True'

# Lista dozwolonych hostów
ALLOWED_HOSTS = os.getenv('DJANGO_ALLOWED_HOSTS', '*').split(',')

# Sprawdzenie, czy środowisko to "blue" czy "green"
ENVIRONMENT = os.getenv('DJANGO_ENVIRONMENT', 'green')  # Domyślnie "green", jeśli nie ustawiono


# Ustawienie bazy danych w zależności od środowiska
if ENVIRONMENT == 'blue':
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': 'flashcards_db_blue',
            'USER': 'postgres',
            'PASSWORD': 'postgres',
            'HOST': '0.0.0.0',
            'PORT': '5432',  # Port dla środowiska blue
        }
    }
else:  # domyślnie "green"
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': 'flashcards_db',
            'USER': 'postgres',
            'PASSWORD': 'postgres',
            'HOST': '0.0.0.0',
            'PORT': '5432',  # Port dla środowiska green
        }
    }

print("ENVIRONMENT:", ENVIRONMENT)
print("DATABASES:", DATABASES)

# Aplikacje w projekcie
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'corsheaders',
    'api',
    'rest_framework',
]

# Middleware (pośrednicy)
MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

# CORS - dozwolone pochodzenia (origin)
CORS_ALLOWED_ORIGINS = [
    "http://127.0.0.1:8083",
]

# Główne ustawienia URL
ROOT_URLCONF = 'backend.urls'

# Ustawienia szablonów
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# Ustawienia aplikacji WSGI
WSGI_APPLICATION = 'backend.wsgi.application'

# CORS - zezwól na wszystkie pochodzenia (origin)
CORS_ALLOW_ALL_ORIGINS = True

# Dołączanie ukośnika na końcu URL
APPEND_SLASH = False

# Walidacja haseł
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Ustawienia językowe i strefa czasowa
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# Ścieżki do plików statycznych (CSS, JavaScript, obrazy)
STATIC_URL = 'static/'

# Typ pola identyfikatora dla nowych obiektów w bazie danych
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Dodatkowe ustawienia związane z Elasticsearch, Minio, itp. można dodać w podobny sposób
