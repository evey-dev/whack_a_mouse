import 'package:flutter/material.dart';
import 'material_color_generator.dart';

@immutable
class AppTheme {
  final gen = MaterialColorGenerator();
  late final mainPink;
  AppTheme() {
    mainPink = gen.createMaterialColor(const Color(0xFFF2D8E5));
  }
}