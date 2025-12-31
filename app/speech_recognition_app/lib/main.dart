import 'package:flutter/material.dart';
import 'package:speech_recognition_app/presentation/register_speaker/register_speaker_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  RecordToStreamExample(),
    );
  }
}
