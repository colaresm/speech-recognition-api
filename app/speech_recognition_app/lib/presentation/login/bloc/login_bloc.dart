import 'package:bloc/bloc.dart';
import 'package:speech_recognition_app/domain/usecases/send_audio_usecase.dart';
import 'package:speech_recognition_app/presentation/login/bloc/events/login_speaker_events.dart';
import 'package:speech_recognition_app/presentation/login/bloc/states/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendAudioUseCase sendAudioUseCase;

  LoginBloc(this.sendAudioUseCase) : super(LoginInitial()) {
    on<SendAudioEvent>(_onSendAudio);
  }

  Future<void> _onSendAudio(
    SendAudioEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final String speakerId = await sendAudioUseCase(
        audio1Path: event.audio1Path,
      );

      emit(LoginSuccess("Login realizado com sucesso", speakerId));
    } catch (e) {
      emit(LoginError("Servidor indisponível. Tente novamente."));
    }
  }
}
