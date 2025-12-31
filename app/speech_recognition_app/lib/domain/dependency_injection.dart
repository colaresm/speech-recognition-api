import 'package:get_it/get_it.dart';
import 'package:speech_recognition_app/datasource/register_speaker_remote_datasource.dart';
import 'package:speech_recognition_app/domain/repositories/impl/register_speaker_repository_impl.dart';
import 'package:speech_recognition_app/domain/repositories/register_speaker_repository.dart';
import 'package:speech_recognition_app/domain/usecases/send_audios_usecase.dart';
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
}
