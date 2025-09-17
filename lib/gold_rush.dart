import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart';
import 'package:goldrush_2d/components/background.dart';
import 'package:goldrush_2d/components/characters/character_main.dart';
import 'package:goldrush_2d/components/characters/character_skeleton.dart';
import 'package:goldrush_2d/components/characters/character_zombie.dart';
import 'package:goldrush_2d/components/hud/joystick.dart';
import 'package:goldrush_2d/components/hud/run_button.dart';
import 'package:goldrush_2d/components/hud/score_text.dart';
import 'package:goldrush_2d/components/setting/my_slider.dart';

class GoldRush extends FlameGame with HasCollisionDetection {
  // screen size
  late Size screenSize;

  // Head-Uo Display (HUD)
  late Joystick hudJoystick;
  late RunButton hudRunButton;
  late ScoreText hudScoreText;

  // characters
  late CharacterMain cMain;
  late CharacterZombie cZombie;
  late CharacterSkeleton cSkeleton;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    screenSize = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single,
    ).size;

    _handleInitJoyStick();
    _handleInitRunButton();
    _handleInitScore();
    _handleCharacters();

    /// add components
    add(Background(cMain: cMain));

    add(cMain);
    // add(cZombie);
    add(cSkeleton);
    add(ScreenHitbox());

    add(hudJoystick);
    add(hudRunButton);
    add(hudScoreText);
    // add(Setting(myPosition: Vector2(screenSize.width - 240, 40)));
    // Thêm slider với callback
    // final slider = SliderComponent(
    //   listNormalizeSnapPoint: [0, 0.1, 0.4, 0.5, .8, 1],
    // );
    // slider.position = Vector2(100, 100);
    // add(slider);
  }

  void _handleInitJoyStick() {
    hudJoystick = Joystick(
      knob: CircleComponent(
        radius: 20.0,
        paint: BasicPalette.green.withAlpha(70).paint(),
      ),
      background: CircleComponent(
        radius: 40.0,
        paint: BasicPalette.gray.withAlpha(70).paint(),
      ),
      margin: const EdgeInsets.only(left: 50, bottom: 50),
    );
  }

  void _handleInitRunButton() {
    hudRunButton = RunButton(
      runButton: CircleComponent(
        radius: 25.0,
        paint: BasicPalette.red.withAlpha(100).paint(),
      ),
      runButtonDown: CircleComponent(
        radius: 25.0,
        paint: BasicPalette.green.withAlpha(30).paint(),
      ),
      runMargin: const EdgeInsets.only(right: 50, bottom: 50),
      onPressed: () => {},
    );
  }

  void _handleInitScore() {
    hudScoreText = ScoreText(
      stMargin: const EdgeInsets.only(left: 40, top: 60),
    );
  }

  void _handleCharacters() {
    Offset characterMainCenter = Offset(
      (screenSize.width / 2) - (SIZE_MAIN_CHARACTER.width / 2),
      (screenSize.height / 2) - (SIZE_MAIN_CHARACTER.height / 2),
    );
    cMain = CharacterMain(
      mainSpeed: 100.0,
      mainPosition: characterMainCenter,
      joystick: hudJoystick,
      runButton: hudRunButton,
      scoreText: hudScoreText,
      onAddEnemy: onAddEnemy,
    );
    cZombie = CharacterZombie(
      zbSpeed: 40.0,
      zbPosition: characterMainCenter.translate(100, 100),
    );
    cSkeleton = CharacterSkeleton(
      skeSpeed: 40.0,
      skePosition: characterMainCenter.translate(100, 100),
    );
  }

  void onAddEnemy(int indexEnemy) {
    if (indexEnemy == 0) {
      add(
        CharacterZombie(
          zbSpeed: 40.0,
          zbPosition: Offset(
            Random().nextDouble() * screenSize.width,
            Random().nextDouble() * screenSize.height,
          ),
        ),
      );
    } else if (indexEnemy == 1) {
      add(
        CharacterSkeleton(
          skeSpeed: 40.0,
          skePosition: Offset(
            Random().nextDouble() * screenSize.width,
            Random().nextDouble() * screenSize.height,
          ),
        ),
      );
    }
  }
}
