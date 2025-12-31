
abstract class RegisterSpeakerEvent{}

class SendAudiosEvent extends RegisterSpeakerEvent {
  final String audio1Path;
  final String audio2Path;
  final String speakerId;

  SendAudiosEvent({
    required this.audio1Path,
    required this.audio2Path,
    required this.speakerId,
  });

  List<Object?> get props => [audio1Path, audio2Path, speakerId];
}
