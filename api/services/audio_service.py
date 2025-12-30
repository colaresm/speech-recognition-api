import librosa 
import numpy as np
from services import audio_service
from services import features

def truncate(audio, sr=16000, duration=3):
    max_len = sr * duration   
    if len(audio) < max_len:
        return False, audio   
    return True, audio[:max_len] 

def pre_emphasis(signal, alpha=0.97):
    return np.append(signal[0], signal[1:] - alpha * signal[:-1])

def pre_process_speech(audio):
    audio, _ = librosa.effects.trim(audio, top_db=20)
    audio = pre_emphasis(audio)
    audio = audio / max(abs(audio))
    is_valid ,audio = truncate(audio)
    return is_valid, audio 

def compute_data(paths):
    X_speaker = []
    coefs = []
    for path in paths:
        speech, _ = librosa.load(path, sr=16000, mono=True)
        _, speech = audio_service.pre_process_speech(speech)
        mfcs = features.extract_mfcc(speech)
        coefs.append(mfcs)

    X_speaker = np.hstack(coefs) 
    mean = X_speaker.mean(axis=1)   
    std  = X_speaker.std(axis=1)  

    X_speaker_norm = (X_speaker.T - mean) / (std + 1e-8)
    C = np.cov(X_speaker_norm.T)
    invC = np.linalg.inv(C)
    return invC,mean,std