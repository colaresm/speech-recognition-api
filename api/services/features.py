import librosa

def extract_mfcc(audio):
    sr = 16*103
    n_mfcc = 13
    frame_length = int(0.025 * sr)   
    hop_length = int(0.010 * sr)     

    mfcc = librosa.feature.mfcc(
        y=audio,
        sr=sr,
        n_mfcc=n_mfcc,
        n_fft=frame_length,
        hop_length=hop_length,
        n_mels=26
    )
    return mfcc