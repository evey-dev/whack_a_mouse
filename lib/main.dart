import 'package:flutter/material.dart';
import 'const/app_theme.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static AppTheme colors = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whack-a-mole',
      theme: ThemeData(
        primarySwatch: colors.mainPink,
      ),
      home: const Game(),
    );
  }
}