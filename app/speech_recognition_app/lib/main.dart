import 'package:flutter/material.dart';
import 'package:speech_recognition_app/domain/dependency_injection.dart';
import 'package:speech_recognition_app/presentation/home/home_page.dart';

void main() {
  dependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
