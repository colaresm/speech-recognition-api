import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:speech_recognition_app/utils/routes.dart';
import 'package:speech_recognition_app/utils/toast.dart';

class PersonalPage extends StatelessWidget {
  final String speakerId;
  final String profilePictureBase64;

  const PersonalPage({
    super.key,
    required this.speakerId,
    required this.profilePictureBase64,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (profilePictureBase64.isNotEmpty) {
      try {
        imageBytes = base64Decode(profilePictureBase64);
      } catch (e) {
        imageBytes = null;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Perfil do Usuário'.toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.logout),
            onPressed: () {
              AppToast.showSuccess("Logout realizado com sucesso");
              redirectToHomePage(context);
            },
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black87,
                  backgroundImage: imageBytes != null
                      ? MemoryImage(imageBytes)
                      : null,
                  child: imageBytes == null
                      ? Text(
                          speakerId.isNotEmpty
                              ? speakerId[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'Bem-vindo(a), ',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: speakerId,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'Caro usuário, você está logado neste aplicativo por meio de um sistema de reconhecimento de voz.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
