import 'package:flutter/material.dart';

class DebugGlobals {
  static Paint nodePaint = Paint()..color = const Color(0xFF9C2C77);
  static Paint edgePaint = Paint()
    ..color = const Color(0xFFCD104D)
    ..strokeWidth = 1;
  static Paint connectorPointPaint = Paint()..color = const Color(0xFFFD841F);
  static Paint connectorPointEdgePaint = Paint()
    ..color = const Color(0xFFE14D2A)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;
  static Paint minimalBoundingRectanglePaint = Paint()
    ..color = const Color(0xFFF96666)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.1;
}
