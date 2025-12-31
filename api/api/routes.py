from flask import Blueprint
from services import audio_service
from services import speaker_service
from flask import request, jsonify
import os
import base64

routes = Blueprint("routes", __name__)

@routes.route("/health", methods=["GET"])
def health():
    """
    Health check da API
    ---
    tags:
      - Health
    responses:
      200:
        description: API está funcionando
        schema:
          type: object
          properties:
            status:
              type: string
              example: ok
    """
    return {"status": "ok"}

@routes.route("/register-speaker", methods=["POST"])
def register_speaker():
    """
    Cadastro de um novo locutor
    ---
    tags:
      - Speakers
    consumes:
      - multipart/form-data
    parameters:
      - name: speaker_id
        in: formData
        type: string
        required: true
      - name: audio_1
        in: formData
        type: file
        required: true
      - name: audio_2
        in: formData
        type: file
        required: true
    responses:
      200:
        description: Locutor cadastrado com sucesso
        schema:
          type: object
          properties:
            status:
              type: string
            speaker_id:
              type: string
    """
  
    if "audio_1" not in request.files or "audio_2" not in request.files:
        return jsonify({"error": "Envie dois arquivos de áudio"}), 400
  
    speaker_id = request.form.get("speaker_id")
    audio_1 = request.files["audio_1"]
    audio_2 = request.files["audio_2"]

    profile_picture = request.files.get("profile_picture")
    if profile_picture:
      image_bytes = profile_picture.read()
      image_base64 = base64.b64encode(image_bytes).decode('utf-8')
    else:
      image_base64 = "" 

    
    if not speaker_id:
        return jsonify({"error": "speaker_id é obrigatório"}), 400

    paths = []

    for audio in [audio_1, audio_2]:
        path = f"/tmp/{audio.filename}"
        audio.save(path)
        paths.append(path)

    
    inv_C, mean, std = audio_service.compute_data(paths)
    speaker_service.register_speaker_service(
        mean=mean,
        std=std,
        inv_C=inv_C,
        speaker_id=speaker_id,
        image_base64=image_base64
    )

    return jsonify({
        "status": "ok",
        "speaker_id": speaker_id
    })


@routes.route("/identify-speaker", methods=["POST"])
def identify_speaker():
    """
    Identificação de locutor
    ---
    tags:
      - Recognition
    consumes:
      - multipart/form-data
    parameters:
      - name: audio
        in: formData
        type: file
        required: true
    responses:
      200:
        description: Resultado da identificação
        schema:
          type: object
          properties:
            speaker_id:
              type: string
            identify_speaker:
              type: string
    """

    if "audio" not in request.files:
        return jsonify({"error": "Envie um arquivo de áudio"}), 400

    audio_file = request.files["audio"]
    path = f"/tmp/{audio_file.filename}"
    audio_file.save(path)

    best_speaker,profile_picture = speaker_service.identify_speaker(path)

    os.remove(path)

    return jsonify({
        "speaker_id": best_speaker,
        "profile_picture": profile_picture
    })


