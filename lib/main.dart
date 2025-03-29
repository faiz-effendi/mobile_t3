import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 247, 171, 29),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 165, 165, 165), // Warna teks label
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 0, 0, 0), // Warna background TextField
          hintStyle: TextStyle(
            color: Colors.white, // Warna teks hint
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Warna border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white), // Warna border saat tidak fokus
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: LoginPage(),
    );
  }
}
