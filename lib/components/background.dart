import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/components/characters/character_main.dart';

class Background extends PositionComponent with TapCallbacks {
  static final backgroundPaint = BasicPalette.blue.withAlpha(20).paint();
  late double screenWidth, screenHeight;
  final CharacterMain cMain;
  Background({required this.cMain});
  @override
  Future<void> onLoad() async {
    super.onLoad();
    Size screenSize = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single,
    ).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    position = Vector2(0, 0);
    size = Vector2(screenWidth, screenHeight);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromPoints(position.toOffset(), size.toOffset()),
      backgroundPaint,
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    cMain.moveToLocation(event);
  }
}
