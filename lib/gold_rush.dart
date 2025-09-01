import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:goldrush_2d/components/player.dart';

class GoldRush extends FlameGame with HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(Player());
    add(ScreenHitbox());// not yet
  }
}
