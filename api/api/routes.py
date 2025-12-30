from flask import Blueprint
from services import  audio,features
import librosa
import numpy as np
import os
from dotenv import load_dotenv
from pymongo import MongoClient

routes = Blueprint("routes", __name__)

@routes.route("/health", methods=["GET"])
def health():
    return {"status": "ok"}

@routes.route("/register-speaker", methods=["GET"])
def register_speaker():
    paths = ["tests/a.ogg","tests/b.ogg"]
    inv_C,mean,std = compute_data(paths)
    print(mean)

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
       "speaker_id": "spk_001",
    "mean": mean.tolist(),
    "std": std.tolist(),
    "invC": inv_C.tolist()
    })

    return {"status": "mean"}

def compute_data(paths):
    X_speaker = []
    coefs = []
    for path in paths:
        speech, sr = librosa.load(path, sr=16000, mono=True)
        _, speech = audio.pre_process_speech(speech)
            # extract mfccs
        mfcs = features.extract_mfcc(speech)
        coefs.append(mfcs)
    X_speaker = np.hstack(coefs) 
    mean = X_speaker.mean(axis=1)   # (D,)
    std  = X_speaker.std(axis=1)    # (D,)

    X_speaker_norm = (X_speaker.T - mean) / (std + 1e-8)
    C = np.cov(X_speaker_norm.T)
    invC = np.linalg.inv(C)
    return invC,mean,std