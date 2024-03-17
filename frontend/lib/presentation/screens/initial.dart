import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/sign_up/sign_up.dart';
import 'package:frontend/presentation/widgets/mytextbutton.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 124, 207, 240),
              Color.fromARGB(255, 32, 140, 228)
            ],
            stops: [0.3, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "We're \ngoing \non a trip!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Are you in ?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 251, 251, 251),
                  fontSize: 22,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 40),
              MyTextButton(
                text: 'Get Started',
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen()),
                  );
                }, backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
