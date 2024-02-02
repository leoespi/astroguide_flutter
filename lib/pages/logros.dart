import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Logros {
  final String titulo;
  final String descripcion;
  final DateTime fecha;

  Logros(this.titulo, this.descripcion, this.fecha);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logros de mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ventanaLogros(),
    );
  }
}

class ventanaLogros extends StatefulWidget {
  @override
   createState() => _ventanaLogrosState();
}

class _ventanaLogrosState extends State<ventanaLogros> {
  
  List<Logros> achievements = [
    Logros(
      "Logro 1",
      "Descripción del logro 1",
      DateTime.now(),
    ),
    Logros(
      "Logro 2",
      "Descripción del logro 2",
      DateTime.now(),
    ),
    Logros(
      "Lunatico",
      "completa la leccion completa de lunas",
      DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Logros'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return ListTile(
            title: Text(achievement.titulo),
            subtitle: Text(
              'Descripción: ${achievement.descripcion}\nFecha: ${achievement.fecha.day}/${achievement.fecha.month}/${achievement.fecha.year}',
            ),
          );
        },
      ),
    );
  }
}