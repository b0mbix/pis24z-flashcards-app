# Aplikacja fiszkowa
## Opis projektu
Aplikacja quizowa/fiszkowa pozwalająca na naukę w trybie spaced repetition, dodawanie, usuwanie i pełną modyfikację fiszek lub korzystanie z gotowych zestawów fiszek, pełnotekstowe wyszukiwanie fiszek po wszystkich atrybutach i opisach. Aplikacja przechowuje historię uczenia się w systemie i zdjęcia/multimedia w odrębnym komponencie - możliwym do postawienia na innym serwerze. Aplikacja umożliwia synchronizację danych pomiędzy urządzeniami, a bazą danych.

## Instrukcja uruchomienia
### Backend
(Należy uruchomić przed uruchomieniem fluttera)
1. Przejdź do katalogu `src/logic`
```
cd src/logic
```
2. Przygotuj wirtualne środowisko
```
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

3. Przed pierwszym uruchomieniem wykonaj migracje
```
python3 manage.py migrate
```

4. Uruchom serwer Django
```
python3 manage.py runserver
```

#### Inne komendy
Dodanie kolejnej migracji
```
python manage.py makemigrations
```

Dodanie konta typu `superuser`
```
python manage.py createsuperuser
```
Po dodaniu superużytkownika, można zalogować się do strony `admin/` na serwerze.


### Frontend
1. Zainstaluj Fluttera: https://docs.flutter.dev/get-started/install
2. Przejdź do katalogu `src/gui/flashcards`:
```
cd src/gui/flashcards
```
3. Pobierz potrzebne rzeczy i uruchom Fluttera:
```
flutter pub get
flutter run
```

Jeżeli wystąpią problemy, spróbuj przejść do wersji 3.4.4:
1. Przejdź do katalogu instalacji Fluttera
2. Zmień branch projektu:
```
git checkout v3.4.4
```