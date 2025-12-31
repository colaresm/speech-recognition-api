import 'package:get_it/get_it.dart';
import 'package:speech_recognition_app/datasource/login_remote_datasource.dart';
import 'package:speech_recognition_app/datasource/register_speaker_remote_datasource.dart';
import 'package:speech_recognition_app/domain/repositories/impl/login_repository_impl.dart';
import 'package:speech_recognition_app/domain/repositories/impl/register_speaker_repository_impl.dart';
import 'package:speech_recognition_app/domain/repositories/login_repository.dart';
import 'package:speech_recognition_app/domain/repositories/register_speaker_repository.dart';
import 'package:speech_recognition_app/domain/usecases/send_audio_usecase.dart';
import 'package:speech_recognition_app/domain/usecases/send_audios_usecase.dart';
import 'package:speech_recognition_app/presentation/login/bloc/login_bloc.dart';
import 'package:speech_recognition_app/presentation/register_speaker/bloc/register_speaker_bloc.dart';

final getDependency = GetIt.instance;

void dependencyInjection() {
  getDependency.registerLazySingleton(() => RegisterSpeakerRemoteDatasource());

  getDependency.registerLazySingleton<RegisterSpeakerRepository>(
    () => RegisterSpeakerRepositoryImpl(
      getDependency<RegisterSpeakerRemoteDatasource>(),
    ),
  );

  getDependency.registerLazySingleton(
    () => SendAudiosUseCase(getDependency<RegisterSpeakerRepository>()),
  );

  getDependency.registerFactory(
    () => RegisterSpeakerBloc(getDependency<SendAudiosUseCase>()),
  );

  getDependency.registerLazySingleton(() => LoginRemoteDatasource());

  getDependency.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getDependency<LoginRemoteDatasource>()),
  );

  getDependency.registerLazySingleton(
    () => SendAudioUseCase(getDependency<LoginRepository>()),
  );

  getDependency.registerFactory(
    () => LoginBloc(getDependency<SendAudioUseCase>()),
  );
}
