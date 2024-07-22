import 'package:flutter/material.dart';
import 'package:tictac_game/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primarySwatch: Colors.green,
        primaryColor: const Color.fromRGBO(160, 147, 125, 1),
        shadowColor: const Color.fromRGBO(231, 212, 181, 1),
        splashColor: const Color.fromRGBO(246, 230, 203, 1)
      ),
      home: const HomePage(),
    );
  }
}