abstract class LoginEvent {}

class SendAudioEvent extends LoginEvent {
  final String audio1Path;

  SendAudioEvent({required this.audio1Path});

  List<Object?> get props => [audio1Path];
}
