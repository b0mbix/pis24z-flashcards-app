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

### Bazy danych
1. W katalogu projektu, gdzie znajduje się plik `docker-compose.yml`, uruchom następujące polecenie:
  ```bash
  docker-compose up <(opcjonalnie) nazwa bazy [postgres, elasticsearch, minio]>
  ```
2. Bazy danych uruchomią się w osobnych kontenerach:
  - **PostgreSQL**: Dostępny na porcie `5432`.
  - **Elasticsearch**: Dostępny na porcie `9200`.
  - **Minio**: Dostępny na porcie `9000` (API) i `9001` (Konsola zarządzania).

#### Eksport danych do Elasticsearch/MinIO
1. Aby wyeksportować dane do Elasticsearch, uruchom polecenie:
  ```bash
  python3 ./database/migrate_elasticsearch.py
  ```
2. Po tym kroku dane zostaną zapisane w odpowiednikach tabel w Elasticsearch i można je obejrzeć np. poprzez http://localhost:9200/<nazwa_tabeli> (żeby zobaczyć dane tabeli) lub http://localhost:9200/<nazwa_tabeli>/_search (żeby zobaczyć dane *w* tabeli).

3. Aby wyeksportować dane do Minio, uruchom polecenie:
  ```bash
  python3 ./database/migrate_minio.py
  ```
4. Po tym kroku dane w formatach JSON zostaną zapisane w odpowiednich bucketach w Minio.

## Dostępy do baz danych
### PostgreSQL:
- Dane dostępowe:
  - **Username**: `postgres`
  - **Password**: `postgres`
- Domyślna baza danych: `flashcards_db`

### Elasticsearch:
- Dane dostępowe:
  - **Username**: `elastic`
  - **Password**: `password`
- Adres API: `http://localhost:9200`

### Minio:
- Dane dostępowe:
  - **Username**: `user`
  - **Password**: `password`
- Konsola zarządzania: `http://localhost:9001`
- API: `http://localhost:9000`
