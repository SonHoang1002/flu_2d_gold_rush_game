import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Setting extends PositionComponent {
  final Vector2 myPosition;
  Setting({required this.myPosition}):super(priority: 20);

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    RectangleComponent rectangleComponent = RectangleComponent(
      size: Vector2(200, 20),
      paint: Paint()..color = Colors.red,
      position: myPosition,
    );
    add(rectangleComponent);
    anchor = Anchor.centerRight;
  }
}
