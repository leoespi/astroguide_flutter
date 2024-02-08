import 'package:astroguide_flutter/main.dart';
import 'package:astroguide_flutter/services/lecciones_service.dart';
import 'package:astroguide_flutter/services/logros_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astroguide_flutter/services/user_service.dart';
import 'menu.dart'; // Importa la primera página para la navegación

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<List<dynamic>> _logrosDataFuture = LogrosService.getLogros(); // Corregir aquí

    return Scaffold(
      appBar: AppBar(
        title: Text('Logros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<dynamic>>(
          future: _logrosDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final logrosData = snapshot.data![0]; // Suponiendo que la lista de usuarios solo contiene un usuario por ahora

              return Column(
                children: [
                  const SizedBox(height: 40),
                  const SizedBox(height: 20),
                  if (logrosData != null) ...[
                    itemProfile('Nombre_del_Logro', logrosData['Nombre_del_Logro'] ??'', CupertinoIcons.person), // Usa los datos del usuario aquí
                    const SizedBox(height: 10),
                    itemProfile('Rareza',logrosData['Rareza'] ?? '', CupertinoIcons.mail), // Usa los datos del usuario aquí
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Navega de regreso a la primera página
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text('Volver al menu'),
                    ),
                  )
                ],
              );
            } //Logros Arreglo 2.0
          },
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Color.fromARGB(255, 104, 51, 155).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}