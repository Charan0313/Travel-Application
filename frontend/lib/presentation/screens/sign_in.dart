import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/sign_up/sign_up.dart';
import 'package:frontend/presentation/widgets/mytextbutton.dart';
import 'package:frontend/presentation/widgets/mytextfield.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({Key? key});
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 138, 217, 248),
              Color.fromARGB(255, 32, 140, 228),
            ],
            stops: [0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 40),
                   MyTextField(
                      onChanged: (value) {},
                      hintText: 'Email',
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      controller: emailController,
                    ), 
                    const SizedBox(height: 20),
                     MyTextField(
                      onChanged: (value) {},
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      controller: passController,
                    ),
                    const SizedBox(height: 20),
                    MyTextButton(
                      text: 'Sign In',
                      onPressed: () {},
                      textColor: Colors.blue, backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color.fromARGB(255, 246, 212, 108),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
