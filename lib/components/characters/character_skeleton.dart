import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart';
import 'package:goldrush_2d/components/characters/character_enemy.dart';

class CharacterSkeleton extends EnemyCharacter {
  final double skeSpeed;
  final Offset skePosition;
  CharacterSkeleton({required this.skeSpeed, required this.skePosition})
    : super(position: skePosition, size: SIZE_SKELETON, speed: skeSpeed);
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    var spite = await Flame.images.load(PATH_ENEMY_MEDIA);
    var spriteSheet = SpriteSheet(image: spite, srcSize: Vector2(32, 64));
    animDown = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.2,
      from: 3,
      to: 5,
    );
    animLeft = spriteSheet.createAnimation(
      row: 1,
      stepTime: 0.2,
      from: 3,
      to: 5,
    );
    animRight = spriteSheet.createAnimation(
      row: 2,
      stepTime: 0.2,
      from: 3,
      to: 5,
    );
    animUp = spriteSheet.createAnimation(row: 3, stepTime: 0.2, from: 3, to: 5);
    animation = animUp;
    var bg = RectangleComponent(
      size: SIZE_MAIN_CHARACTER.toVector2(),
      paint: Paint()..color = Colors.green.withAlpha(20),
    );
    add(bg);
    add(RectangleHitbox());
  }
}
