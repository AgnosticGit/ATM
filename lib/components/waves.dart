import 'dart:ui';
import 'package:ATM/theme/colors.dart';
import 'package:flutter/material.dart';

class Waves extends CustomPainter {
  Gradient gradientController(bool isReversed, double opacity) {
    List<Color> colorList = [CustomColors.deepBlue, CustomColors.purple];

    if (isReversed) {
      colorList = colorList.reversed.toList();
    }
    
    return LinearGradient(
      colors: <Color>[
        colorList[0].withOpacity(opacity),
        colorList[1].withOpacity(opacity),
      ],
    );
  }

  Paint paintController(double opacity, Size size, [bool isRversed = false]) {
    Rect rect = new Rect.fromLTWH(0, 0, size.width, 0);

    return Paint()
      ..style = PaintingStyle.fill
      ..shader = gradientController(isRversed, opacity).createShader(rect);
  }

  Path pathController(
    double start,
    double x1,
    double y1,
    double x2,
    double y2,
    double y3,
    size, [
    bool isBottom = false,
  ]) {
    Path path = Path();

    if (isBottom) {
      path.moveTo(0, size.height);
    }

    path.lineTo(0, size.height * start);
    path.cubicTo(
      size.width * x1,
      size.height * y1,
      size.width * x2,
      size.height * y2,
      size.width,
      size.height * y3,
    );

    if (isBottom) {
      path.lineTo(size.width, size.height);
    } else {
      path.lineTo(size.width, 0);
    }

    return path;
  }

  void paint(Canvas canvas, Size size) {
    final paint1 = paintController(0.7, size);
    final paint2 = paintController(0.4, size, true);
    final paint3 = paintController(0.2, size);
    final paint4 = paintController(0.7, size);

    final wave1 = pathController(0.12, 0.2, 0.13, 0.85, 0.27, 0.17, size);
    final wave2 = pathController(0.19, 0.4, 0.24, 0.4, 0.03, 0.17, size);
    final wave3 = pathController(0.14, 0.5, 0.28, 0.75, 0.1, 0.23, size);
    final wave4 = pathController(0.14, 0.3, 0.1, 0.85, 0.2, 0.2, size);

    final wave5 = pathController(0.88, 0.15, 0.75, 0.8, 0.92, 0.93, size, true);
    final wave6 = pathController(0.88, 0.6, 1.02, 0.6, 0.82, 0.86, size, true);
    final wave7 = pathController(0.82, 0.25, 0.95, 0.5, 0.77, 0.91, size, true);
    final wave8 = pathController(0.85, 0.15, 0.85, 0.7, 0.95, 0.91, size, true);

    canvas.drawPath(wave1, paint1);
    canvas.drawPath(wave2, paint2);
    canvas.drawPath(wave3, paint3);
    canvas.drawPath(wave4, paint4);

    canvas.drawPath(wave5, paint1);
    canvas.drawPath(wave6, paint2);
    canvas.drawPath(wave7, paint3);
    canvas.drawPath(wave8, paint4);
  }

  bool shouldRepaint(Waves oldDelegate) => false;
}
