import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart';
import 'package:goldrush_2d/components/background.dart';
import 'package:goldrush_2d/components/characters/main_character.dart';
import 'package:goldrush_2d/components/characters/skeleton.dart';
import 'package:goldrush_2d/components/characters/zombie.dart';

class GoldRush extends FlameGame with HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    Size screenSize = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single,
    ).size;
    Offset mainCharacterCenter = Offset(
      (screenSize.width / 2) - (SIZE_MAIN_CHARACTER.width / 2),
      (screenSize.height / 2) - (SIZE_MAIN_CHARACTER.height / 2),
    );

    /// add components
    add(Background());
    add(ScreenHitbox());
    add(MainCharacter(mainSpeed: 100.0, mainPosition: mainCharacterCenter));
    add(
      Zombie(
        zbSpeed: 40.0,
        zbPosition: mainCharacterCenter.translate(-200, -200),
      ),
    );
    add(
      Skeleton(
        skeSpeed: 40.0,
        skePosition: mainCharacterCenter.translate(200, 200),
      ),
    );
  }
}
