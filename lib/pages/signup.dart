import 'package:astroguide_flutter/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:astroguide_flutter/components/button.dart';
import 'package:astroguide_flutter/components/colors.dart';
import 'package:astroguide_flutter/components/textfield.dart';
import 'package:http/http.dart' as http;


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final usrName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  static const String baseUrl = 'http://127.0.0.1:8000';

  Future<void> signUp() async {
    if (password.text != confirmPassword.text) {
      // Mostrar mensaje de error si las contraseñas no coinciden
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Las contraseñas no coinciden.'),
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

    final response = await http.post(
      Uri.parse('$baseUrl/signup.php'),
      body: {
        'fullName': fullName.text,
        'email': email.text,
        'usrName': usrName.text,
        'password': password.text,
      },
    );

    if (response.statusCode == 200) {
      // Suponiendo que el script PHP devuelve 'true' si el usuario se crea correctamente
      if (response.body == 'true') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Manejar otros posibles casos de error, como nombre de usuario duplicado, etc.
        // Aquí puedes mostrar un mensaje de error al usuario o realizar otras acciones según tu lógica
      }
    } else {
      throw Exception('Error de red: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Registro",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 55,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                InputField(
                  hint: "Nombre completo",
                  icon: Icons.person,
                  controller: fullName,
                ),
                InputField(
                  hint: "Correo electrónico",
                  icon: Icons.email,
                  controller: email,
                ),
                InputField(
                  hint: "Nombre de usuario",
                  icon: Icons.account_circle,
                  controller: usrName,
                ),
                InputField(
                  hint: "Contraseña",
                  icon: Icons.lock,
                  controller: password,
                  passwordInvisible: true,
                ),
                InputField(
                  hint: "Reingresa la contraseña",
                  icon: Icons.lock,
                  controller: confirmPassword,
                  passwordInvisible: true,
                ),
                const SizedBox(height: 10),
                Button(
                  label: "Registrarse",
                  press: signUp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿Ya tienes una cuenta?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text("Iniciar sesión"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
