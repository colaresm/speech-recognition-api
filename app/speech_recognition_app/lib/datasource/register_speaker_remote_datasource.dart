import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RegisterSpeakerRemoteDatasource {
  Future<void> sendAudios({
    required String audio1Path,
    required String audio2Path,
    required String profilePicturePath,
    required String speakerId,
  }) async {
    final baseUrl = dotenv.env['BASE_URL']!;
    final uri = Uri.parse('$baseUrl/register-speaker');
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

    if (profilePicturePath != "") {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_picture',
          profilePicturePath,
          filename: 'profile_picture_$speakerId.png',
        ),
      );
    }

    request.fields['speaker_id'] = speakerId;

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Erro ao cadastrar usuário');
    }
  }
}
