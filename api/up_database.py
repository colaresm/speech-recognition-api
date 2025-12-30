import os
from dotenv import load_dotenv
from pymongo import MongoClient

load_dotenv()

mongo_uri = os.getenv("MONGO_URI")
mongo_db = os.getenv("MONGO_DB")
mongo_user = os.getenv("MONGO_USER")
mongo_password = os.getenv("MONGO_PASSWORD")

client = MongoClient(
    f"mongodb://{mongo_user}:{mongo_password}@{mongo_uri}:27017/?authSource=admin"
)

db = client[mongo_db]
speakers = db["speakers"]

result = speakers.insert_one({
    "speaker_id": "spk_001_2",
})

print(result.inserted_id)
print(client.list_database_names())
