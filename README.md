# Aplikacja fiszkowa
## Opis projektu
Aplikacja quizowa/fiszkowa pozwalająca na naukę w trybie spaced repetition, dodawanie, usuwanie i pełną modyfikację fiszek lub korzystanie z gotowych zestawów fiszek, pełnotekstowe wyszukiwanie fiszek po wszystkich atrybutach i opisach. Aplikacja przechowuje historię uczenia się w systemie i zdjęcia/multimedia w odrębnym komponencie - możliwym do postawienia na innym serwerze. Aplikacja umożliwia synchronizację danych pomiędzy urządzeniami, a bazą danych.

## Instrukcja uruchomienia
Cały projekt może być uruchomiony za pomocą Dockera. Przed pierwszym uruchomieniem należy zbudować projekt:
```
docker compose build
```

Aby uruchomić projekt, należy wpisać komendę:
```
docker compose up
```

Można również uruchamiać tylko poszczególne kontenery `[postgres|elasticsearch|minio|flutter|logic|migrate|nexus]`.

### Inne komendy
Dodanie konta typu `superuser`:
```
docker compose exec logic python manage.py createsuperuser
```
Po dodaniu superużytkownika, można zalogować się do strony `admin/` na serwerze.

Hard reset aplikacji wraz z wyczyszczeniem bazy danych:
```
docker compose down -v
```

### Eksport danych do Elasticsearch/MinIO
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
- Wejście na poziom bazy danych flashcards_db w kontenerze:

  ```
  docker exec -it pis24z-flashcards-app-postgres-1 psql -U postgres -d flashcards_db
  ```
- Sprawdzenie tabel i relacji bazy (pozostała funkcjonalność jak dla baz SQL):

  ```
  \dt
  ```

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
