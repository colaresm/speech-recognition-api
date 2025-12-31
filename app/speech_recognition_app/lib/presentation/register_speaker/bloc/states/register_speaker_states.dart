abstract class RegisterSpeakerState {}

class RegisterSpeakerInitial extends RegisterSpeakerState {}

class RegisterSpeakerLoading extends RegisterSpeakerState {}

class RegisterSpeakerSuccess extends RegisterSpeakerState {
  final String message;
  RegisterSpeakerSuccess(this.message);
}

class RegisterSpeakerError extends RegisterSpeakerState {
  final String message;
  RegisterSpeakerError(this.message);
}
