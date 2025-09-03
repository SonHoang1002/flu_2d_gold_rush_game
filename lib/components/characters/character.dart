import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart';

class Character extends SpriteAnimationComponent with CollisionCallbacks {
  final double characterSpeed;
  final Size characterSize;
  final Offset characterPosition;

  Character({
    required this.characterSpeed,
    required this.characterSize,
    required this.characterPosition,
  });

  late double screenSize;
  late SpriteAnimation animLeft, animUp, animRight, animDown;
  late double speed;

  double elapsedTime = 0.0;
  int currentDirection = DIRECTION_DOWN;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = characterSize.toVector2();
    position = characterPosition.toVector2();
    speed = characterSpeed;
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    elapsedTime += deltaTime;
    if (elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }
    switch (currentDirection) {
      case DIRECTION_DOWN:
        position.y += speed * deltaTime;
        break;
      case DIRECTION_LEFT:
        position.x -= speed * deltaTime;
        break;
      case DIRECTION_UP:
        position.y -= speed * deltaTime;
        break;
      case DIRECTION_RIGHT:
        position.x += speed * deltaTime;
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      changeFlipDirection();
      elapsedTime = 0.0;
    }
  }

  void changeFlipDirection() {
    switch (currentDirection) {
      case DIRECTION_DOWN:
        currentDirection = DIRECTION_UP;
        animation = animUp;
        break;
      case DIRECTION_LEFT:
        currentDirection = DIRECTION_RIGHT;
        animation = animRight;
        break;
      case DIRECTION_UP:
        currentDirection = DIRECTION_DOWN;
        animation = animDown;
        break;
      case DIRECTION_RIGHT:
        currentDirection = DIRECTION_LEFT;
        animation = animLeft;
        break;
    }
  }

  void changeDirection() {
    Random random = Random();
    int newDirection = random.nextInt(4);
    while (newDirection == currentDirection) {
      newDirection = random.nextInt(4);
    }
    switch (newDirection) {
      case DIRECTION_DOWN:
        animation = animDown;
        break;
      case DIRECTION_LEFT:
        animation = animLeft;
        break;
      case DIRECTION_UP:
        animation = animUp;
        break;
      case DIRECTION_RIGHT:
        animation = animRight;
        break;
    }
    currentDirection = newDirection;
  }
}
