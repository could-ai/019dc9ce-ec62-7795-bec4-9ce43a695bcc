import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AdminSekolahApp());
}

class AdminSekolahApp extends StatelessWidget {
  const AdminSekolahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Administrasi Kepala Sekolah SD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5), // A strong primary blue
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
