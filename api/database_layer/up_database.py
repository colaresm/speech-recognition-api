import os
from dotenv import load_dotenv
from pymongo import MongoClient
from database_layer.database import connection


def create_database():
    db = connection()

    result = db.insert_one({
        "speaker_id": "spk_001_2",
    })

    print(result.inserted_id)
