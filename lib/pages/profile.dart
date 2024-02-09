import 'package:flutter/material.dart';
import 'package:astroguide_flutter/components/button.dart';
import 'package:astroguide_flutter/components/colors.dart';
import 'package:astroguide_flutter/services/user_service.dart';
import 'package:astroguide_flutter/pages/login.dart';
import 'package:astroguide_flutter/models/user.dart';

class Profile extends StatelessWidget {
  final User? profile;
  const Profile({Key? key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 77,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/no_user.jpg"),
                    radius: 75,
                  ),
                ),
                const SizedBox(height: 10),
                Text(profile!.fullName ?? "",
                    style: const TextStyle(fontSize: 28, color: primaryColor)),
                Text(profile!.email ?? "",
                    style: const TextStyle(fontSize: 17, color: Colors.grey)),
                Button(
                  label: "Cerrar sesión",
                  press: () async {
                    try {
                      // Llama al método de UserService para cerrar sesión
                      await UserService.logout();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    } catch (e) {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text('Error al cerrar sesión: $e'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person, size: 30),
                  subtitle: const Text("Nombre completo"),
                  title: Text(profile!.fullName ?? ""),
                ),
                ListTile(
                  leading: const Icon(Icons.email, size: 30),
                  subtitle: const Text("Correo electrónico"),
                  title: Text(profile!.email ?? ""),
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle, size: 30),
                  subtitle: Text(profile!.usrName),
                  title: const Text("Usuario"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
