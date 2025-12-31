import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRemoteDatasource {
  Future<String> sendAudio({required String audio1Path}) async {
    final uri = Uri.parse('http://192.168.1.180:5001/identify-speaker');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio',
        audio1Path,
        filename: 'audio.wav',
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Erro ao identificar usuário');
    }

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final speakerId = (jsonData['speaker_id']).toString();

    return speakerId;
  }
}
