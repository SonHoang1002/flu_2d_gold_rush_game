import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart';
import 'package:goldrush_2d/components/characters/character.dart';
import 'package:goldrush_2d/utils/extension.dart' as myExt;

class Skeleton extends Character {
  final double skeSpeed;
  final Offset skePosition;
  Skeleton({required this.skeSpeed, required this.skePosition})
    : super(
        characterPosition: skePosition,
        characterSize: SIZE_SKELETON,
        characterSpeed: skeSpeed,
      );
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    var spite = await Flame.images.load(PATH_ENEMY_MEDIA);
    var spriteSheet = SpriteSheet(
      image: spite,
      srcSize: Vector2(SIZE_ENEMY.width, SIZE_ENEMY.height),
    );
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
    add(RectangleHitbox());
  }
}
