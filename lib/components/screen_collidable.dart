// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame/game.dart';

// class ScreenCollidable extends Component with CollisionCallbacks {
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();

//     // Tạo hitbox bao quanh toàn bộ màn hình
//     add(ScreenHitbox());
//   }

//   @override
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
//     super.onCollision(intersectionPoints, other);
//     // In ra log khi có va chạm với màn hình
//     print('Va chạm với cạnh màn hình: ${other.runtimeType}');
//   }
// }
