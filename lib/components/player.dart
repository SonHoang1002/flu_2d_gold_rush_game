import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with CollisionCallbacks {
  static const int _squareSpeed = 250;
  static final Paint _squarePaint = BasicPalette.green.paint();
  static final Size _squareSize = Size(100, 100);
  // Rect _squarePos = Rect.zero;
  int _squareDirection = 1;

  late Size screenSize;
  late Offset _center;

  Offset get getCenter => _center;
  set setCenter(Offset newOffset) {
    _center = newOffset;
  }

  int get squareSpeed => _squareSpeed;
  get squarePaint => _squarePaint;
  Size get squareSize => _squareSize;
  double get squareWidth => squareSize.width;
  double get squareHeight => squareSize.width;
  int get squareDirection => _squareDirection;
  set setSquareDirection(int squareDirection) {
    _squareDirection = squareDirection;
  }

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  double get centerX => getCenter.dx;
  double get centerY => getCenter.dx;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    screenSize = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single,
    ).size;
    setCenter = Offset(
      (screenWidth / 2) - (squareWidth / 2),
      (screenHeight / 2) - (squareHeight / 2),
    );
    position = Vector2(centerX, centerY);
    size = Vector2(squareWidth, squareHeight);

    add(RectangleHitbox());
    
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), squarePaint);
  }

  @override
  void update(double deltaTime) {
    position.x += squareSpeed * squareDirection * deltaTime;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      if (squareDirection == 1) {
        setSquareDirection = -1;
      } else {
        setSquareDirection = 1;
      }
    }
  }
}
