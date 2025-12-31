import numpy as np
from database_layer.database import connection
def register_speaker(mean,std,inv_C,speaker_id,image_base64):
    db = connection()
    db.insert_one({
    "speaker_id": speaker_id,
    "mean": mean.tolist(),
    "std": std.tolist(),
    "invC": inv_C.tolist(),
    "profile_picture":image_base64
    })


def identify_speaker(X_mfcc):
    db = connection()
    best_speaker = None
    best_score = float("inf")

    for doc in db.find({}):
        inv_C = np.array(doc["invC"])
        mean = np.array(doc["mean"])
        std = np.array(doc["std"])

        X = (X_mfcc - mean) / std

        distances = []
        for i in range(X.shape[0]):
            diff = X[i]
            dist = diff.T @ inv_C @ diff
            distances.append(dist)

        total_dist = np.median(distances) / 12

        if total_dist < best_score:
            best_score = total_dist
            best_speaker = doc["speaker_id"]
            profile_picture = doc["profile_picture"]
    return  best_speaker,profile_picture