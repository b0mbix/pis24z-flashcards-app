# Aplikacja fiszkowa
## Opis projektu
Aplikacja quizowa/fiszkowa pozwalająca na naukę w trybie spaced repetition, dodawanie, usuwanie i pełną modyfikację fiszek lub korzystanie z gotowych zestawów fiszek, pełnotekstowe wyszukiwanie fiszek po wszystkich atrybutach i opisach. Aplikacja przechowuje historię uczenia się w systemie i zdjęcia/multimedia w odrębnym komponencie - możliwym do postawienia na innym serwerze. Aplikacja umożliwia synchronizację danych pomiędzy urządzeniami, a bazą danych.

## Instrukcja uruchomienia
### Frontend
1. Zainstaluj Fluttera: https://docs.flutter.dev/get-started/install
2. Przejdź do katalogu `gui/flashcards`:
```
cd gui/flashcards
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


### backend
(Należy uruchomić przed uruchomieniem fluttera)
1. Przejdź do katalogu `logic`:
```
cd logic

```
2. przygotuj wirtualne środowisko
```
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

3. uruchom django:
```
python3 manage.py runserver
```

3. po zakończeniu programu wychodzimy ze środowiska:
```
deactivate
```