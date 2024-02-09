import 'package:flutter/material.dart';
import 'package:astroguide_flutter/components/button.dart';
import 'package:astroguide_flutter/components/colors.dart';
import 'package:astroguide_flutter/pages/login.dart';
import 'package:astroguide_flutter/pages/signup.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Image.asset("images/startup.png")),
              Button(
                  label: "Inciar Sesion",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
              Button(
                  label: "Registrarse",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
