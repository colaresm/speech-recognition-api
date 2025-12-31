import 'package:flutter/material.dart';
import 'package:speech_recognition_app/utils/routes.dart';
import 'package:speech_recognition_app/widgets/default_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            DefaultButton(
              text: "Logar",
              width: buttonWidth,
              isActive: true,
              onPressed: () {
                print("logar");
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Não tem conta? ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => redirectToRegisterSpeakerPage(context),
                  child: const Text(
                    "Registre-se",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar:  Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
          "developed by Marcelo Colares".toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
