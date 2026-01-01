import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:speech_recognition_app/dto/get_speaker_responde_dto.dart';

class LoginRemoteDatasource {
  Future<GetSpeakerResponseDTO> sendAudio({required String audio1Path}) async {
    final baseUrl = dotenv.env['BASE_URL']!;
    final uri = Uri.parse('$baseUrl/identify-speaker');
    final request = http.MultipartRequest('POST', uri);

    // Adiciona o arquivo de áudio
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
    final speakerResponse = GetSpeakerResponseDTO.fromJson(jsonData);

    return speakerResponse;
  }
}
