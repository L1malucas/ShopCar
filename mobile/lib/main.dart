import 'package:flutter/material.dart';
import 'package:mobile/Views/Pages/intro_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const IntroPage(),
      theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}
