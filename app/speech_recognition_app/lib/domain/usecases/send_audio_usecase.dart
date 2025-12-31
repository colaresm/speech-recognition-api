import 'package:speech_recognition_app/domain/repositories/login_repository.dart';

class SendAudioUseCase {
  final LoginRepository repository;

  SendAudioUseCase(this.repository);

  Future<String> call({required String audio1Path}) {
    return repository.sendAudio(audio1Path: audio1Path);
  }
}
