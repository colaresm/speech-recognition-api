import 'package:speech_recognition_app/datasource/login_remote_datasource.dart';
import 'package:speech_recognition_app/domain/repositories/login_repository.dart';

class LoginRepositoryImpl
    implements LoginRepository {
  final LoginRemoteDatasource datasource;
  LoginRepositoryImpl(this.datasource);

  @override
  Future<String> sendAudio({
    required String audio1Path,
  }) {
    return datasource.sendAudio(
      audio1Path: audio1Path,
    );
  }
}
