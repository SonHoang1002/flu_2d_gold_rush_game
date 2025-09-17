import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart'; 
import 'package:goldrush_2d/components/characters/character_enemy.dart';

class CharacterZombie extends EnemyCharacter {
  final double zbSpeed;
  final Offset zbPosition;
  CharacterZombie({required this.zbSpeed, required this.zbPosition})
    : super(
        position: zbPosition,
        size: SIZE_ENEMY,
        speed: zbSpeed,
      );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    var sprite = await Flame.images.load(PATH_ENEMY_MEDIA);
    SpriteSheet spriteSheet = SpriteSheet(image: sprite, srcSize: size);
    var stepTimes = List.generate(3, (_) => 0.2);
    animDown = spriteSheet.createAnimationWithVariableStepTimes(
      row: 0,
      stepTimes: stepTimes,
      from: 0,
      to: 3,
    );
    animLeft = spriteSheet.createAnimationWithVariableStepTimes(
      row: 1,
      stepTimes: stepTimes,
      from: 0,
      to: 3,
    );
    animRight = spriteSheet.createAnimationWithVariableStepTimes(
      row: 2,
      stepTimes: stepTimes,
      from: 0,
      to: 3,
    );
    animUp = spriteSheet.createAnimationWithVariableStepTimes(
      row: 3,
      stepTimes: stepTimes,
      from: 0,
      to: 3,
    );
    animation = animUp;
    var bg = RectangleComponent(
      size: SIZE_MAIN_CHARACTER.toVector2(),
      paint: Paint()..color = Colors.blue.withAlpha(20),
    );
    add(bg);
    add(RectangleHitbox());
  }
}
