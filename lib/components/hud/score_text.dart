import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class ScoreText extends HudMarginComponent {
  final EdgeInsets stMargin;
  ScoreText({required this.stMargin}) : super(margin: stMargin);
  int score = 0;
  String scoreText = "Score: ";
  late TextPaint _regularPaint;
  late TextComponent scoreTextComponent;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    TextStyle textStyle = TextStyle(
      color: BasicPalette.lightBlue.color,
      fontSize: 30,
    );
    _regularPaint = TextPaint(style: textStyle);

    scoreTextComponent = TextComponent(
      text: scoreText + score.toString(),
      textRenderer: _regularPaint,
    );
    add(scoreTextComponent);
  }

  void setScore(int score) {
    this.score += score;
    scoreTextComponent.text = scoreText + this.score.toString();
  }
}
