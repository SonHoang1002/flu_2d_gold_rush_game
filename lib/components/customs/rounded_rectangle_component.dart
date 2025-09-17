import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RoundedRectangleComponent extends ShapeComponent {
  final Vector2 cSize;
  final Paint cPaint;
  final double borderRadius;
  final Vector2? cPosition;

  RoundedRectangleComponent({
    required this.cSize,
    required this.cPaint,
    this.borderRadius = 8.0,
    this.cPosition,
  }) {
    size = cSize;
    paint = cPaint;
    if (cPosition != null) {
      position = cPosition!;
    }
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, cSize.x, cSize.y);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    canvas.drawRRect(rrect, paint);
  }
}
