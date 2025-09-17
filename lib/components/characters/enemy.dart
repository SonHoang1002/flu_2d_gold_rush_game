import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:goldrush_2d/commons/constants.dart';

class Enemy extends SpriteAnimationComponent with CollisionCallbacks {
  final double characterSpeed;
  final Size characterSize;
  final Offset characterPosition;

  Enemy({
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
}
