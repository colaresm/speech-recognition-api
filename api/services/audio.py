import librosa 
import numpy as np


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