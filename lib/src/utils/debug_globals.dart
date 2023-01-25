import 'package:flutter/material.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugGlobals {
  static Paint nodePaint = Paint()..color = const Color(0xFF9C2C77);
  static Paint edgePaint = Paint()
    ..color = const Color(0xFFCD104D)
    ..strokeWidth = groundPlanCubit.state.groundPlan.lineWidth;
  static Paint connectorPointPaint = Paint()..color = const Color(0xFFFD841F);
  static Paint connectorPointEdgePaint = Paint()
    ..color = const Color(0xFFE14D2A)
    ..style = PaintingStyle.stroke
    ..strokeWidth = groundPlanCubit.state.groundPlan.lineWidth * 0.5;
  static Paint minimalBoundingRectanglePaint = Paint()
    ..color = const Color(0xFFF96666)
    ..style = PaintingStyle.stroke
    ..strokeWidth = groundPlanCubit.state.groundPlan.lineWidth * 0.1;
  static Paint userPaint = Paint()..color = const Color(0xFF1CD6CE);
  static Paint userClosestPointOnEdgePaint = Paint()
    ..color = const Color(0xFF367E18)
    ..strokeWidth = groundPlanCubit.state.groundPlan.lineWidth * 0.25;
  static Paint userClosestPointPaint = Paint()
    ..color = const Color(0xFFFD841F)
    ..strokeWidth = groundPlanCubit.state.groundPlan.lineWidth * 0.25;
}
