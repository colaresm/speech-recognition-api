import 'package:speech_recognition_app/datasource/login_remote_datasource.dart';
import 'package:speech_recognition_app/domain/repositories/login_repository.dart';
import 'package:speech_recognition_app/dto/get_speaker_responde_dto.dart';

class LoginRepositoryImpl
    implements LoginRepository {
  final LoginRemoteDatasource datasource;
  LoginRepositoryImpl(this.datasource);

  @override
  Future<GetSpeakerResponseDTO> sendAudio({
    required String audio1Path,
  }) {
    return datasource.sendAudio(
      audio1Path: audio1Path,
    );
  }
}
