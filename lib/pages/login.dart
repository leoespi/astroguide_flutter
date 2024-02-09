import 'package:flutter/material.dart';
import 'package:astroguide_flutter/components/button.dart';
import 'package:astroguide_flutter/components/colors.dart';
import 'package:astroguide_flutter/components/textfield.dart';
import 'package:astroguide_flutter/pages/profile.dart';
import 'package:astroguide_flutter/pages/signup.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;

  static const String baseUrl = 'ttp://127.0.0.1:8000'; // Cambia esta URL por la de tu servidor

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'), // Cambia el endpoint a tu script PHP de inicio de sesión
        body: {
          'username': usrName.text,
          'password': password.text,
        },
      );

      if (response.statusCode == 200) {
        if (response.body == 'true') {
          // Aquí podrías obtener los detalles del usuario si es necesario
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Profile(),
            ),
          );
        } else {
          setState(() {
            isLoginTrue = true;
          });
        }
      } else {
        throw Exception('Error de red: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoginTrue = true;
      });
      print('Error al iniciar sesión: $e');
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
                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(color: primaryColor, fontSize: 40),
                ),
                Image.asset("images/startup.png"),
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
                ListTile(
                  horizontalTitleGap: 2,
                  title: const Text("Recordar Sesión"),
                  leading: Checkbox(
                    activeColor: primaryColor,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                ),
                Button(
                  label: "Iniciar Sesión",
                  press: login,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿No tienes una cuenta?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text("Registrarse"),
                    )
                  ],
                ),
                isLoginTrue
                    ? Text(
                        "El nombre de usuario o la contraseña son incorrectos",
                        style: TextStyle(color: Colors.red.shade900),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
