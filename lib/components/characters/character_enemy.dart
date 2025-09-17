import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:goldrush_2d/commons/constants.dart';
import 'dart:math'; 
import 'package:goldrush_2d/components/characters/character.dart';

class EnemyCharacter extends Character {
  EnemyCharacter({
    required Offset position,
    required Size size,
    required double speed,
  }) : super(characterPosition: position,  characterSize: size,  characterSpeed: speed);

  void changeDirection() {
    Random random = Random();
    int newDirection = random.nextInt(4);

    switch (newDirection) {
      case DIRECTION_DOWN:
        animation = animDown;
        break;
      case DIRECTION_LEFT:
        animation = animLeft;
        break;
      case DIRECTION_UP:
        animation = animUp;
        break;
      case DIRECTION_RIGHT:
        animation = animRight;
        break;
    }

    currentDirection = newDirection;
  }
  
  @override
  void update(double deltaTime) {
    super.update(deltaTime);

    elapsedTime += deltaTime;
    if (elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }

    switch (currentDirection) {
      case DIRECTION_DOWN:
        position.y += speed * deltaTime;
        break;
      case DIRECTION_LEFT:
        position.x -= speed * deltaTime;
        break;
      case DIRECTION_UP:
        position.y -= speed * deltaTime;
        break;
      case DIRECTION_RIGHT:
        position.x += speed * deltaTime;
        break;
    }
  }

 @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
     if (other is ScreenHitbox) {
      switch (currentDirection) {
        case DIRECTION_DOWN:
          currentDirection = DIRECTION_UP;
          animation = animUp;
          break;
        case DIRECTION_LEFT:
          currentDirection = DIRECTION_RIGHT;
          animation = animRight;
          break;
        case DIRECTION_UP:
          currentDirection = DIRECTION_DOWN;
          animation = animDown;
          break;
        case DIRECTION_RIGHT:
          currentDirection = DIRECTION_LEFT;
          animation = animLeft;
          break;
      }

      elapsedTime = 0.0;
    }
  }
}
