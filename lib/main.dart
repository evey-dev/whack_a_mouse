import 'package:flutter/material.dart';
import 'screen/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whack-a-mole',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Menu(),
    );
  }
}