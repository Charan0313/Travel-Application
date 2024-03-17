import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/home_screen.dart';
import 'package:frontend/presentation/screens/sign_in.dart';
import 'package:frontend/presentation/widgets/mytextfield.dart';
import 'package:frontend/presentation/widgets/mytextbutton.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    const SizedBox(height: 40),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Create an account to get started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 40),
                    MyTextField(
                      controller: nameController,
                      onChanged: (value) {},
                      hintText: 'Name',
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      onChanged: (value) {},
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 40),
                    MyTextButton(
                      text: 'Sign Up',
                      textColor: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }, backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            )
                          },
                          child: const Text('Login here',
                              style: TextStyle(
                                color: Color.fromARGB(255, 246, 212, 108),
                                fontWeight: FontWeight.bold,
                              )),
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
