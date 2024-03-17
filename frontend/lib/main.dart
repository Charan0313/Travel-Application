import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/initial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialScreen(),
    );
  }
}
