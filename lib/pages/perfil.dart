import 'package:flutter/material.dart';
import 'package:astroguide_flutter/services/user_service.dart';
import 'package:get_storage/get_storage.dart';

class UserData {
  final String name;
  final String username;
  final String email;

  UserData({
    required this.name,
    required this.username,
    required this.email,
  });
}

class ProfileScreen extends StatefulWidget {
  final String userId;

  ProfileScreen({required this.userId});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const ProfileScreen(),
    );
  }

  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {

    final Future<List<dynamic>> _userDataFuture =
        UserService.obtenerUsuarios(); // Corregir aquí

    var storage = GetStorage();
    var token = storage.read('token');
    final Future<UserData> userData = UserService.obtenerUsuarios(token);


    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<dynamic>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final userData = snapshot.data![
                  0]; // Suponiendo que la lista de usuarios solo contiene un usuario por ahora

              return Column(
                children: [
                  const SizedBox(height: 40),
                  const SizedBox(height: 20),
                  if (userData != null) ...[
                    itemProfile(
                        'Name',
                        userData['name'] ?? '',
                        CupertinoIcons
                            .person), // Usa los datos del usuario aquí
                    const SizedBox(height: 10),
                    itemProfile('Correo', userData['email'] ?? '',
                        CupertinoIcons.mail), // Usa los datos del usuario aquí
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navega de regreso a la primera página
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text('Volver al menu'),
                    ),
                  )
                ],
              );
            }
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
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,

      body: FutureBuilder<UserData>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final usuario = snapshot.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Nombre: ${usuario!.name}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Nombre de usuario: ${usuario.username}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Correo electrónico: ${usuario.email}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            );
          }
        },

      ),
    );
  }
}
