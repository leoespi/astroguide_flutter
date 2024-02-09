import 'package:astroguide_flutter/pages/menu.dart';
import 'package:astroguide_flutter/pages/profile.dart';
import 'package:astroguide_flutter/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:astroguide_flutter/pages/lecciones.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      
    );
  }
}
