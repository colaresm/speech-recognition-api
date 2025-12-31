class GetSpeakerResponseDTO {
  final String speakerId;
  final String profilePicture;

  GetSpeakerResponseDTO({
    required this.speakerId,
    required this.profilePicture,
  });

  factory GetSpeakerResponseDTO.fromJson(Map<String, dynamic> json) {
    return GetSpeakerResponseDTO(
      speakerId: json['speaker_id'] as String? ?? '',
      profilePicture: json['profile_picture'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'speaker_id': speakerId, 'profile_picture': profilePicture};
  }
}
