import 'package:speech_recognition_app/datasource/register_speaker_remote_datasource.dart';
import 'package:speech_recognition_app/domain/repositories/register_speaker_repository.dart';

class RegisterSpeakerRepositoryImpl
    implements RegisterSpeakerRepository {

  final RegisterSpeakerRemoteDatasource datasource;

  RegisterSpeakerRepositoryImpl(this.datasource);

  @override
  Future<void> sendAudios({
    required String audio1Path,
    required String audio2Path,
    required String speakerId,
  }) {
    return datasource.sendAudios(
      audio1Path: audio1Path,
      audio2Path: audio2Path,
      speakerId: speakerId,
    );
  }
}
