abstract class RegisterSpeakerRepository {
  Future<void> sendAudios({
    required String audio1Path,
    required String audio2Path,
    required String profilePicturePath,
    required String speakerId,
  });
}
