from minio import Minio
import json
import psycopg2
import datetime
import io

POSTGRES_CONFIG = {
    "dbname": "flashcards_db",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432,
}

MINIO_CONFIG = {
    "endpoint": "localhost:9000",
    "access_key": "user",  
    "secret_key": "password", 
    "secure": False,
}

minio_client = Minio(
    MINIO_CONFIG["endpoint"],
    access_key=MINIO_CONFIG["access_key"],
    secret_key=MINIO_CONFIG["secret_key"],
    secure=MINIO_CONFIG["secure"],
)

class DateTimeEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, (datetime.date, datetime.datetime)):
            return obj.isoformat()
        return super().default(obj)

def create_bucket(bucket_name):
    if not minio_client.bucket_exists(bucket_name):
        minio_client.make_bucket(bucket_name)
        print(f"Bucket '{bucket_name}' został utworzony.")
    else:
        print(f"Bucket '{bucket_name}' już istnieje.")

def fetch_data(query):
    with psycopg2.connect(**POSTGRES_CONFIG) as conn:
        with conn.cursor() as cursor:
            cursor.execute(query)
            columns = [desc[0] for desc in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]

def migrate_to_minio(bucket_name, file_name, data):
    create_bucket(bucket_name)
    json_data = json.dumps(data, indent=2, cls=DateTimeEncoder)
    minio_client.put_object(
        bucket_name,
        file_name,
        data=io.BytesIO(json_data.encode('utf-8')),
        length=len(json_data),
        content_type="application/json",
    )
    print(f"Dane zostały przesłane do bucketu '{bucket_name}' jako '{file_name}'.")

def main():
    users_data = fetch_data("SELECT * FROM Users")
    flashcard_sets_data = fetch_data("SELECT * FROM FlashcardSets")
    flashcards_data = fetch_data("SELECT * FROM Flashcards")
    tags_data = fetch_data("SELECT * FROM Tags")
    flashcard_set_tags_data = fetch_data("SELECT * FROM FlashcardSetTags")

    migrate_to_minio("users", "users.json", users_data)
    migrate_to_minio("flashcard-sets", "flashcard_sets.json", flashcard_sets_data)
    migrate_to_minio("flashcards", "flashcards.json", flashcards_data)
    migrate_to_minio("tags", "tags.json", tags_data)
    migrate_to_minio("flashcard-set-tags", "flashcard_set-tags.json", flashcard_set_tags_data)

if __name__ == "__main__":
    main()
