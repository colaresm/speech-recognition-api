abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final String speakerId;
  LoginSuccess(this.message, this.speakerId);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
