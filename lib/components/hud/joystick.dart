import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Joystick extends JoystickComponent {
  @override
  final PositionComponent knob;
  @override
  final PositionComponent? background;
  @override
  final EdgeInsets? margin;
  Joystick({required this.knob, this.background, this.margin})
    : super(knob: knob, background: background, margin: margin);
}
