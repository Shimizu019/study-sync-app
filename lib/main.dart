import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const StudySyncApp());
}

class StudySyncApp extends StatelessWidget {
  const StudySyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Sync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF5B4FE9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B4FE9)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}