import 'package:speech_recognition_app/domain/repositories/register_speaker_repository.dart';

class SendAudiosUseCase {
  final RegisterSpeakerRepository repository;

  SendAudiosUseCase(this.repository);

  Future<void> call({
    required String audio1Path,
    required String audio2Path,
    required String profilePicturePath,
    required String speakerId,
  }) {
    if (speakerId.isEmpty) {
      throw Exception('Speaker ID inválido');
    }

    return repository.sendAudios(
      audio1Path: audio1Path,
      audio2Path: audio2Path,
      profilePicturePath: profilePicturePath,
      speakerId: speakerId,
    );
  }
}
