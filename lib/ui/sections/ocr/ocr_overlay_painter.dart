import 'package:flutter/material.dart';

class OcrOverlayPainter extends CustomPainter {
  final Rect centerRect;
  OcrOverlayPainter(this.centerRect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(centerRect, const Radius.circular(20)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // Draw frame corners
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    const double cornerLength = 32.0;

    // Top Left
    canvas.drawPath(
      Path()
        ..moveTo(centerRect.left, centerRect.top + cornerLength)
        ..lineTo(centerRect.left, centerRect.top)
        ..lineTo(centerRect.left + cornerLength, centerRect.top),
      strokePaint,
    );

    // Top Right
    canvas.drawPath(
      Path()
        ..moveTo(centerRect.right - cornerLength, centerRect.top)
        ..lineTo(centerRect.right, centerRect.top)
        ..lineTo(centerRect.right, centerRect.top + cornerLength),
      strokePaint,
    );

    // Bottom Left
    canvas.drawPath(
      Path()
        ..moveTo(centerRect.left, centerRect.bottom - cornerLength)
        ..lineTo(centerRect.left, centerRect.bottom)
        ..lineTo(centerRect.left + cornerLength, centerRect.bottom),
      strokePaint,
    );

    // Bottom Right
    canvas.drawPath(
      Path()
        ..moveTo(centerRect.right - cornerLength, centerRect.bottom)
        ..lineTo(centerRect.right, centerRect.bottom)
        ..lineTo(centerRect.right, centerRect.bottom - cornerLength),
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant OcrOverlayPainter oldDelegate) {
    return oldDelegate.centerRect != centerRect;
  }
}
