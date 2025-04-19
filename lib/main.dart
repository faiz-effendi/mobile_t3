import 'package:flutter/material.dart';
import 'pages/login_page.dart';
// import 'pages/home_page.dart'; // Misalnya halaman home

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 106, 40, 160),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // Warna teks label
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 255, 255, 255), // Warna background TextField
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // Warna teks hint
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Warna border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 85, 85, 85)), // Warna border saat tidak fokus
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      initialRoute: '/login', // Menentukan rute awal
      routes: {
        '/login': (context) => LoginPage(), // Rute untuk halaman login
        // Tambahkan rute lainnya jika perlu
      },
    );
  }
}