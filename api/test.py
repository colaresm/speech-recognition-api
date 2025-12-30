from pymongo import MongoClient
from pymongo.errors import ConnectionFailure

MONGO_URI = "mongodb://admin:admin123@localhost:27017"

try:
    client = MongoClient(MONGO_URI, serverSelectionTimeoutMS=3000)
    client.admin.command("ping")
    print("✅ Conectado ao MongoDB com sucesso!")
except ConnectionFailure as e:
    print("❌ Erro ao conectar no MongoDB:", e)
