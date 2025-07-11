import 'dart:ui';

import 'package:flutter/material.dart';

class MyShaderPainter extends CustomPainter {
  final FragmentShader shader;

  MyShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}