import 'package:flutter/material.dart';
import 'package:ihp/screens/home.dart';

void main() {
  runApp(const IHP());
}

class IHP extends StatelessWidget {
  const IHP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
    );
  }
}
