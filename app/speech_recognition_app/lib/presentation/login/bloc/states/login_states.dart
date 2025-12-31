abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final String speakerId;
  final String profilePictureBase64;
  LoginSuccess(this.message, this.speakerId, this.profilePictureBase64);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
