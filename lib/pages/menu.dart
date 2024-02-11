import 'package:astroguide_flutter/main.dart';
import 'package:astroguide_flutter/pages/logros.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astroguide_flutter/pages/lecciones.dart'; // Importa la página de lecciones
import 'package:astroguide_flutter/pages/Perfil.dart'; // Importa la página de perfil

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const menu());
}

class menu extends StatelessWidget {
  const menu({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello!',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Good Morning',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.white54)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/shrek.jpg'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboardWithButton('Logros',
                      CupertinoIcons.play_rectangle, Colors.deepOrange),
                  itemDashboardWithButton(
                      'Perfil',
                      CupertinoIcons.profile_circled,
                      Colors.green), // Modificación aquí
                  itemDashboardWithButton('Lecciones', CupertinoIcons.person_2,
                      Colors.purple), // Modificación aquí
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  // Widget para los elementos del dashboard sin botones
  Widget itemDashboard(String title, IconData iconData, Color background) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      );

  // Widget para los elementos del dashboard con botones
  Widget itemDashboardWithButton(
          String title, IconData iconData, Color background) =>
      GestureDetector(
        onTap: () {
          if (title == 'Perfil') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      perfil()), // Navega a la página de perfil
            );
          } else if (title == 'Lecciones') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Lecciones()), // Navega a la página de lecciones
            );
          } else if (title == 'Logros') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyApp()), // Navega a la página de lecciones
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (title == 'Perfil') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              perfil()), // Navega a la página de perfil
                    );
                  } else if (title == 'Lecciones') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Lecciones()), // Navega a la página de lecciones
                    );
                  } else if (title == 'Logros') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyApp()), // Navega a la página de lecciones
                    );
                  }
                },
                child: Column(
                  children: [
                    Text(title == 'Perfil'
                        ? 'Ver perfil'
                        : 'Ir a Logros'), // Modificación aquí
                    if (title == 'Lecciones')
                      Text(
                          'Ir a Lecciones') // Agregar este texto condicionalmente
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
