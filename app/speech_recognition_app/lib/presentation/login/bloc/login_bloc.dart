
import 'package:bloc/bloc.dart';
import 'package:speech_recognition_app/domain/usecases/send_audios_usecase.dart';
import 'package:speech_recognition_app/presentation/login/bloc/events/login_speaker_events.dart';
import 'package:speech_recognition_app/presentation/login/bloc/states/login_states.dart';
import 'package:speech_recognition_app/presentation/register_speaker/bloc/events/register_speaker_events.dart';
import 'package:speech_recognition_app/presentation/register_speaker/bloc/states/register_speaker_states.dart';

class LoginBloc
    extends Bloc<LoginEvent, LoginState> {
  final SendAudiosUseCase sendAudiosUseCase; //TODO: SOLVE THIS!

  LoginBloc(this.sendAudiosUseCase)
    : super(LoginInitial()) {
    on<SendAudioEvent>(_onSendAudios);
  }

  Future<void> _onSendAudios(
    SendAudiosEvent event,
    Emitter<RegisterSpeakerState> emit,
  ) async {
    emit(RegisterSpeakerLoading());
    try {
      await sendAudiosUseCase(
        audio1Path: event.audio1Path,
        audio2Path: event.audio2Path,
        speakerId: event.speakerId,
      );
      emit(RegisterSpeakerSuccess("Login realizado com sucesso."));
    } catch (e) {
      emit(RegisterSpeakerError("Servidor indisponível. Tente novamente."));
    }
  }
}
