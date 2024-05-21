import 'package:flutter/material.dart';
import 'package:plant_disease_detection/ui/style/app_colors.dart';

class InvertedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.heavyGrey.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // Draw the outer rectangle (background)
    canvas.drawRect(Offset.zero & size, paint);

    // Create a path for the transparent circle
    final path = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 4, // Adjust the radius as needed
      ));

    // Clip the path to make the circle transparent
    canvas.clipPath(path, doAntiAlias: true);

    // Draw a transparent rectangle to clear the clipped area
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.transparent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
