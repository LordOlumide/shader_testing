import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:shader_testing/widgets/shader_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final FragmentProgram fragmentProgram;

  @override
  void initState() {
    super.initState();
    loadMyShader();
  }

  Future<void> loadMyShader() async {
    fragmentProgram = await FragmentProgram.fromAsset('shaders/myshader.frag');
  }

  void updateShader(Canvas canvas, Rect rect, FragmentProgram program) {
    var shader = program.fragmentShader();
    shader.setFloat(0, 42.0);
    canvas.drawRect(rect, Paint()..shader = shader);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadMyShader(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ShaderBuilder(
              assetKey: 'assets/shaders/custom_shader.frag',
              (BuildContext context, FragmentShader shader, Widget? child) {
                return CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: MyShaderPainter(shader),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
