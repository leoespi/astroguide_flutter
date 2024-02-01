import 'package:astroguide_flutter/components/my_button.dart';
import 'package:astroguide_flutter/components/my_textfield.dart';
import 'package:flutter/material.dart';




class LoginPage extends StatelessWidget {
   LoginPage ({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}


  @override
  Widget build  (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(children: [

        //logo
        Icon(
          Icons.lock,
          size: 100,
          ), 

           const SizedBox(height: 50),


        //Welcome back
        Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

               const SizedBox(height: 25),

         
        //username textfield
         
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

        //password textfield

         MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),




        //forgot password?

         Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

        //sign in button
         MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 50),

        //or continue with google 
           Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

        
        



        

        // Register now 
         





      ]),
    );

  }
}