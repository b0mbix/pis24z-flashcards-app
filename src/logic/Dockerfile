FROM python:3.10-slim

# Tworzymy katalog /app, jeśli jeszcze nie istnieje
RUN mkdir -p /app

# Przechodzimy do katalogu /app
WORKDIR /app

# Kopiowanie plików konfiguracyjnych przed instalacją
COPY poetry.lock pyproject.toml /app/

# Kopiowanie pozostałych plików do katalogu roboczego
COPY . /app/

# Instalowanie zależności
RUN pip install poetry
RUN poetry config virtualenvs.create false 
RUN poetry install --no-interaction --no-ansi --no-root

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

