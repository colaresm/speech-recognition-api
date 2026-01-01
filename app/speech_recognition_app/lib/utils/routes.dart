import 'package:flutter/material.dart';
import 'package:speech_recognition_app/presentation/home/home_page.dart';
import 'package:speech_recognition_app/presentation/login/login_page.dart';
import 'package:speech_recognition_app/presentation/personal/personal_page.dart';
import 'package:speech_recognition_app/presentation/register_speaker/register_speaker_page.dart';

void redirectToHomePage(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}

void redirectToRegisterSpeakerPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegisterSpeakerPage()),
  );
}

void redirectToLoginPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
}

void redirectToPersonalPage({
  required BuildContext context,
  required String profilePictureBase64,
  required String speakerId,
}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => PersonalPage(
        profilePictureBase64: profilePictureBase64,
        speakerId: speakerId,
      ),
    ),
  );
}

 
