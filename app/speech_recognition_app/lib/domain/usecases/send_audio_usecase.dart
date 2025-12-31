import 'package:speech_recognition_app/domain/repositories/login_repository.dart';
import 'package:speech_recognition_app/dto/get_speaker_responde_dto.dart';

class SendAudioUseCase {
  final LoginRepository repository;

  SendAudioUseCase(this.repository);

  Future<GetSpeakerResponseDTO> call({required String audio1Path}) {
    return repository.sendAudio(audio1Path: audio1Path);
  }
}
