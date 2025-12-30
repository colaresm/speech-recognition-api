from services import audio_service
from repository import speaker_repository
import librosa
from services import features

def register_speaker_service(mean, std, inv_C,speaker_id):
    speaker_repository.register_speaker( mean, std, inv_C,speaker_id)

def identify_speaker(path):
    speech, _ = librosa.load(path, sr=16000, mono=True)
    _, speech = audio_service.pre_process_speech(speech)
    X_mfcc = features.extract_mfcc(speech).T
    best_speaker = None
    best_score = float("inf")
    best_score,best_speaker = speaker_repository.identify_speaker(X_mfcc)
    return  best_score,best_speaker