import 'package:http/http.dart' as http;

class RegisterSpeakerRemoteDatasource {
  Future<void> sendAudios({
    required String audio1Path,
    required String audio2Path,
    required String speakerId,
  }) async {
    final uri = Uri.parse('http://192.168.1.180:5001/register-speaker');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio_1',
        audio1Path,
        filename: 'audio.wav',
      ),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio_2',
        audio2Path,
        filename: 'audio2.wav',
      ),
    );

    request.fields['speaker_id'] = speakerId;

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Erro ao cadastrar usuário');
    }
  }
}
