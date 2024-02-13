import 'package:astroguide_flutter/pages/logros.dart';
import 'package:astroguide_flutter/pages/menu.dart';
import 'package:astroguide_flutter/pages/perfil.dart';
import 'package:astroguide_flutter/pages/lecciones.dart';
import 'package:astroguide_flutter/pages/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AstroGuide',
      home: token == null ? const LoginPage() : const menu(),
    );
  }
}
