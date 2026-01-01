import os
from dotenv import load_dotenv
from pymongo import MongoClient

def connection():
    #load_dotenv()

    mongo_uri = os.getenv("MONGO_URI")
    mongo_db = os.getenv("MONGO_DB")
    
    client = MongoClient(mongo_uri)
    db = client[mongo_db]

    return db["speakers"]
