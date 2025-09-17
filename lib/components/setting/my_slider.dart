import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/components/customs/rounded_rectangle_component.dart';

class SliderComponent extends PositionComponent with DragCallbacks {
  final List<double> listNormalizeSnapPoint;
  final double normalizedThresholdToSnap;

  SliderComponent({
    this.listNormalizeSnapPoint = const [],
    this.normalizedThresholdToSnap = 0.0,
  });

  late RoundedRectangleComponent track;
  late RoundedRectangleComponent knob;
  late TextComponent textValue;
  late TextComponent textValueDemo;

  final double width = 200;
  final double height = 3;
  double _value = 0.5;

  double get getValue => _value;

  Vector2 startVector = Vector2.zero(), startKnobVector = Vector2.zero();

  void _updateValue(double newX) {
    double nearestX = getNearestSnapValue(newX, listVectorSnap);

    if (checkSnap(newX, nearestX, threshold)) {
      knob.position.x = nearestX;
    } else {
    knob.position.x = newX;
    }
    _value = (knob.position.x + knob.size.x / 2) / (width);
    textValue.text = _value.toStringAsFixed(2);
  }

  double getNearestSnapValue(double value, List<double> snapValues) {
    double result = snapValues[0];
    double smallestDifference = (value - result).abs();
    for (var snapValue in snapValues) {
      double currentDifference = (value - snapValue).abs();
      if (currentDifference < smallestDifference) {
        result = snapValue;
        smallestDifference = currentDifference;
      }
    }
    return result;
  }

  bool checkSnap(double currentX, double nearestX, double threshold) {
    return (currentX - nearestX).abs() < threshold;
  }

  List<double> get listVectorSnap {
    return listNormalizeSnapPoint.map((e) {
      return e * width;
    }).toList();
  }

  double get threshold => 20; //normalizedThresholdToSnap * width;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    size = Vector2(width, height + 20);
    Vector2 trackSize = Vector2(width, height);
    Vector2 thumbSize = Vector2(height * 5, height * 5);
    Vector2 textComponentSize = Vector2(height * 7, height * 7);

    // Track chính
    track = RoundedRectangleComponent(
      cSize: trackSize,
      cPaint: Paint()..color = Colors.grey,
      borderRadius: 999,
    );

    // Vẽ các marker từ listVectorSnap
    for (final snapX in listVectorSnap) {
      final marker = RectangleComponent(
        position: Vector2(snapX - 1, 0), // trừ 1 để căn giữa marker
        size: Vector2(2, height), // vệt đỏ nhỏ
        paint: Paint()..color = Colors.red,
      );
      track.add(marker); // add marker vào trong track
    }

    // Knob
    knob = RoundedRectangleComponent(
      cSize: thumbSize,
      cPaint: Paint()..color = Colors.red,
      borderRadius: 999,
      cPosition: Vector2(
        -thumbSize.y / 2 + trackSize.y / 2 + getValue * width,
        -thumbSize.y / 2 + trackSize.y / 2,
      ),
    );

    textValue = TextComponent(
      text: getValue.toString(),
      size: textComponentSize,
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      position: Vector2(
        width + textComponentSize.x,
        -textComponentSize.y / 2 + trackSize.y / 2,
      ),
    );

    textValueDemo = TextComponent(
      text: knob.position.toString(),
      size: textComponentSize,
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      position: Vector2(width / 2, -30),
    );

    add(track);
    add(knob);
    add(textValue);
    add(textValueDemo);
  }

  @override
  void update(double dt) {
    textValueDemo.text = knob.position.toStringWithMaxPrecision(2);
  }
  
  @override
  bool onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    startVector = event.localPosition;
    startKnobVector = knob.position;
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    final localDelta = event.localDelta;
    double newX = knob.position.x + localDelta.x;
    newX = newX.clamp(-knob.size.x / 2, width - knob.size.x / 2);
    print(
      "newXnewX = ${startKnobVector}, ${event.localStartPosition}, ${event.localEndPosition}",
    );
    _updateValue(newX);
    return true;
  }

  @override
  bool onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    return true;
  }
}
