
import 'dart:math';

import 'package:flutter/material.dart';

class CosWaveTopSide4 extends CustomPainter {
  final Color waveColor4;

  CosWaveTopSide4({ this.waveColor4 = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = waveColor4; // Change color as needed

    final Path path = Path();

    path.lineTo(0, size.height);

    for (double i = 0; i <= size.width; i++) {
      final double x = i;

      final double amplitude =
          size.height / 15; // Adjust the amplitude for smaller or larger waves
      const double frequency =
      2; // Adjust the frequency for more or fewer waves
      const double phase = 310.95; // Adjust the phase for left or right shift
      final double centerY = size.height / 20; // Vertical position adjustment
      final double y =
          amplitude * cos((frequency * x / size.width * 2 * pi) - phase) +
              centerY;

      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}