import 'package:flutter/material.dart';
import 'package:gto/pantallas/app.dart';
import '../pantallas/home.dart';

void main() {
  runApp(const App());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gato',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Home(),
    );
  }
}
