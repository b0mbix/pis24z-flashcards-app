import psycopg2
from elasticsearch import Elasticsearch

# Konfiguracja PostgreSQL
pg_conn = psycopg2.connect(
    dbname="flashcards_db",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)
pg_cursor = pg_conn.cursor()

es = Elasticsearch(
    [{'host': 'localhost', 'port': 9200, 'scheme': 'http'}],
    basic_auth=('elastic', 'password')
)



def create_indices():
    indices = {
        "users": {
            "mappings": {
                "properties": {
                    "id": { "type": "integer" },
                    "username": { "type": "text" },
                    "email": { "type": "text" },
                    "password_hash": { "type": "keyword" },
                    "birth_date": { "type": "date" },
                    "is_premium": { "type": "boolean" },
                    "created_at": { "type": "date" },
                    "last_login": { "type": "date" }
                }
            }
        },
        "flashcard_sets": {
            "mappings": {
                "properties": {
                    "id": { "type": "integer" },
                    "user_id": { "type": "integer" },
                    "name": { "type": "text" },
                    "description": { "type": "text" },
                    "created_at": { "type": "date" },
                    "updated_at": { "type": "date" },
                    "views_count": { "type": "integer" },
                    "is_archived": { "type": "boolean" },
                    "is_public": { "type": "boolean" }
                }
            }
        },
        "flashcards": {
            "mappings": {
                "properties": {
                    "id": { "type": "integer" },
                    "set_id": { "type": "integer" },
                    "question": { "type": "text" },
                    "answer": { "type": "text" },
                    "created_at": { "type": "date" },
                    "updated_at": { "type": "date" }
                }
            }
        },
        "tags": {
            "mappings": {
                "properties": {
                    "id": { "type": "integer" },
                    "name": { "type": "text" }
                }
            }
        },
        "flashcard_set_tags": {
            "mappings": {
                "properties": {
                    "id": { "type": "integer" },
                    "set_id": { "type": "integer" },
                    "tag_id": { "type": "integer" }
                }
            }
        }
    }

    for index_name, index_body in indices.items():
        if not es.indices.exists(index=index_name):
            es.indices.create(index=index_name, body=index_body)
            print(f"Indeks '{index_name}' utworzony.")
        else:
            print(f"Indeks '{index_name}' już istnieje.")

def migrate_users():
    pg_cursor.execute("SELECT * FROM Users")
    users = pg_cursor.fetchall()
    for user in users:
        user_doc = {
            "id": user[0],
            "username": user[1],
            "email": user[2],
            "password_hash": user[3],
            "birth_date": user[4],
            "is_premium": user[5],
            "created_at": user[6],
            "last_login": user[7]
        }
        es.index(index="users", id=user[0], document=user_doc)

def migrate_flashcard_sets():
    pg_cursor.execute("SELECT * FROM FlashcardSets")
    sets = pg_cursor.fetchall()
    for flashcard_set in sets:
        set_doc = {
            "id": flashcard_set[0],
            "user_id": flashcard_set[1],
            "name": flashcard_set[2],
            "description": flashcard_set[3],
            "created_at": flashcard_set[4],
            "updated_at": flashcard_set[5],
            "views_count": flashcard_set[6],
            "is_archived": flashcard_set[7],
            "is_public": flashcard_set[8]
        }
        es.index(index="flashcard_sets", id=flashcard_set[0], document=set_doc)

def migrate_flashcards():
    pg_cursor.execute("SELECT * FROM Flashcards")
    flashcards = pg_cursor.fetchall()
    for flashcard in flashcards:
        flashcard_doc = {
            "id": flashcard[0],
            "set_id": flashcard[1],
            "question": flashcard[2],
            "answer": flashcard[3],
            "created_at": flashcard[4],
            "updated_at": flashcard[5]
        }
        es.index(index="flashcards", id=flashcard[0], document=flashcard_doc)

def migrate_tags():
    pg_cursor.execute("SELECT * FROM Tags")
    tags = pg_cursor.fetchall()
    for tag in tags:
        tag_doc = {
            "id": tag[0],
            "name": tag[1]
        }
        es.index(index="tags", id=tag[0], document=tag_doc)

def migrate_flashcard_set_tags():
    pg_cursor.execute("SELECT * FROM FlashcardSetTags")
    set_tags = pg_cursor.fetchall()
    for set_tag in set_tags:
        set_tag_doc = {
            "id": set_tag[0],
            "set_id": set_tag[1],
            "tag_id": set_tag[2]
        }
        es.index(index="flashcard_set_tags", id=set_tag[0], document=set_tag_doc)

def main():
    print("Tworzenie indeksów w Elasticsearch...")
    create_indices()
    print("Migracja danych...")
    migrate_users()
    migrate_flashcard_sets()
    migrate_flashcards()
    migrate_tags()
    migrate_flashcard_set_tags()
    print("Migracja zakończona.")

if __name__ == "__main__":
    main()

    pg_cursor.close()
    pg_conn.close()
