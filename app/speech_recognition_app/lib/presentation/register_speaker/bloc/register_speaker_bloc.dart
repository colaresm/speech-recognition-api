
import 'package:bloc/bloc.dart';
import 'package:speech_recognition_app/domain/usecases/send_audios_usecase.dart';
import 'package:speech_recognition_app/presentation/register_speaker/bloc/events/register_speaker_events.dart';
import 'package:speech_recognition_app/presentation/register_speaker/bloc/states/register_speaker_states.dart';

class RegisterSpeakerBloc
    extends Bloc<RegisterSpeakerEvent, RegisterSpeakerState> {
  final SendAudiosUseCase sendAudiosUseCase;

  RegisterSpeakerBloc(this.sendAudiosUseCase)
    : super(RegisterSpeakerInitial()) {
    on<SendAudiosEvent>(_onSendAudios);
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
        profilePicturePath: event.profilePicturePath,
        speakerId: event.speakerId,
      );
      emit(RegisterSpeakerSuccess("Usuário cadastrado com sucesso."));
    } catch (e) {
      emit(RegisterSpeakerError("Servidor indisponível. Tente novamente."));
    }
  }
}
