import os
from pymongo import MongoClient

def connection():
    mongo_uri = os.getenv("MONGO_URI")
    mongo_db = os.getenv("MONGO_DB")
    
    client = MongoClient(mongo_uri)
    db = client[mongo_db]

    return db["speakers"]
