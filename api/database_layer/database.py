import os
from dotenv import load_dotenv
from pymongo import MongoClient

def connection():
    load_dotenv()

    mongo_uri = os.getenv("MONGO_URI")
    mongo_db = os.getenv("MONGO_DB")
    mongo_user = os.getenv("MONGO_USER")
    mongo_password = os.getenv("MONGO_PASSWORD")

    client = MongoClient(
        f"mongodb://{mongo_user}:{mongo_password}@{mongo_uri}:27017/?authSource=admin"
    )

    db = client[mongo_db]
    
    return db["speakers"]