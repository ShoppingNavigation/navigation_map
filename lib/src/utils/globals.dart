import 'package:flutter/material.dart';

class Globals {
  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF626200));
  static TextTheme textTheme = const TextTheme();

  static Paint defaultShelfPaint = Paint()
    ..color = Globals.colorScheme.primaryContainer
    ..style = PaintingStyle.fill;
}