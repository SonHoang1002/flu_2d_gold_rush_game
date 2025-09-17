import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class RunButton extends HudButtonComponent with TapCallbacks {
  final PositionComponent runButton;
  final PositionComponent? runButtonDown;
  final EdgeInsets? runMargin;
  final Vector2? runPosition;
  final Vector2? runSize;
  @override
  final void Function()? onPressed;
  Anchor runAnchor;
  RunButton({
    required this.runButton,
    this.runButtonDown,
    this.runMargin,
    this.runPosition,
    this.runSize,
    this.runAnchor = Anchor.center,
    this.onPressed,
  }) : super(
         button: runButton,
         buttonDown: runButtonDown,
         margin: runMargin,
         position: runPosition,
         size: runSize ?? runButton.size,
         anchor: runAnchor,
         onPressed: onPressed,
       );
  bool buttonPressed = false;

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    buttonPressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    buttonPressed = false;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    buttonPressed = false;
  }
}
