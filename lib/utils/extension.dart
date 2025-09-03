import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

extension CreateAnimationByColumn on SpriteSheet {
  SpriteAnimation createAnimationByColumn({
    required int column,
    required double stepTime,
    bool loop = true,
    int from = 0,
    int? to,
  }) {
    to ??= this.columns;
    final spriteList = List<int>.generate(
      to - from,
      (i) => from + i,
    ).map((e) => this.getSprite(e, column)).toList();
    print(spriteList);
    return SpriteAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}

extension SizeExtension on Size {
  Vector2 toVector2() => Vector2(width, height);
}

extension OffsetExtension on Offset {
  Vector2 toVector2() => Vector2(dx, dy);
}
