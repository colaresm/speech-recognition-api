import 'package:speech_recognition_app/dto/get_speaker_responde_dto.dart';

abstract class LoginRepository {
  Future<GetSpeakerResponseDTO> sendAudio({required String audio1Path});
}
