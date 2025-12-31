abstract class LoginState {}

class RegisterSpeakerInitial extends LoginState {}

class RegisterSpeakerLoading extends LoginState {}

class RegisterSpeakerSuccess extends LoginState {
  final String message;
  RegisterSpeakerSuccess(this.message);
}

class RegisterSpeakerError extends LoginState {
  final String message;
  RegisterSpeakerError(this.message);
}
