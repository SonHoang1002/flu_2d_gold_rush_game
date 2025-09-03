import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/src/components/position_component.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart';
import 'package:goldrush_2d/components/characters/character.dart';
import 'package:goldrush_2d/components/characters/skeleton.dart';
import 'package:goldrush_2d/components/characters/zombie.dart';
import 'package:goldrush_2d/utils/extension.dart';
import 'package:vector_math/vector_math.dart';

class MainCharacter extends Character {
  final double mainSpeed; 
  final Offset mainPosition;
  MainCharacter({
    required this.mainSpeed, 
    required this.mainPosition,
  }) : super(
         characterPosition: mainPosition,
         characterSize: SIZE_MAIN_CHARACTER,
         characterSpeed: mainSpeed,
       );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    var spriteImages = await Flame.images.load(PATH_CHARACTER_MEDIA);
    final spriteSheet = SpriteSheet(
      image: spriteImages,
      srcSize: SIZE_MAIN_CHARACTER.toVector2(),
    );
    animDown = spriteSheet.createAnimationByColumn(column: 0, stepTime: 0.2);
    animLeft = spriteSheet.createAnimationByColumn(column: 1, stepTime: 0.2);
    animUp = spriteSheet.createAnimationByColumn(column: 2, stepTime: 0.2);
    animRight = spriteSheet.createAnimationByColumn(column: 3, stepTime: 0.2);
    changeDirection();
    add(RectangleHitbox());
  }
  
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);               
    if(other is Zombie || other is Skeleton){
      other.removeFromParent();
    }
  }
}
