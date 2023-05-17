import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const HelloRectangle());
}

class HelloRectangle extends StatelessWidget {
  const HelloRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ShadedArea(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShadedArea extends StatelessWidget {
  const ShadedArea({super.key});

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: FragmentProgram.fromAsset('shaders/all_blue.frag'),
    builder: (BuildContext context, AsyncSnapshot<FragmentProgram> snapshot) {
      if(snapshot.hasData) {
        return CustomPaint(
          size: const Size.square(double.infinity),
          painter: FragmentPainter(shader: snapshot.data!.fragmentShader()),
        );
      }
      return const Center(child: CircularProgressIndicator(),);
    },
  );
}

class FragmentPainter extends CustomPainter {
  final FragmentShader shader;
  const FragmentPainter({required this.shader});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader
    );
  }

  @override
  bool shouldRepaint(FragmentPainter oldDelegate) => false;
}