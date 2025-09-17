import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:goldrush_2d/commons/constants.dart';
import 'package:goldrush_2d/components/characters/character_skeleton.dart';
import 'package:goldrush_2d/components/characters/character_zombie.dart';
import 'package:goldrush_2d/components/hud/joystick.dart';
import 'package:goldrush_2d/components/hud/run_button.dart';
import 'package:goldrush_2d/components/hud/score_text.dart';
import 'package:goldrush_2d/utils/extension.dart';

class CharacterMain extends SpriteAnimationComponent with CollisionCallbacks {
  final Joystick joystick;
  final ScoreText scoreText;
  final RunButton runButton;
  double mainSpeed;
  final Offset mainPosition;
  final void Function(int) onAddEnemy;
  CharacterMain({
    required this.joystick,
    required this.runButton,
    required this.scoreText,
    required this.mainSpeed,
    required this.mainPosition,
    required this.onAddEnemy,
  });

  late SpriteAnimation animLeft,
      animUp,
      animRight,
      animDown,
      animIdleUp,
      animIdleDown,
      animIdleLeft,
      animIdleRight;

  late double walkingSpeed, runningSpeed;

  double elapsedTime = 0.0;
  int currentDirection = 0;

  late Vector2 targetLocation;
  bool movingToTouchedLocation = false;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    walkingSpeed = mainSpeed;
    runningSpeed = mainSpeed * 2;

    var bg = RectangleComponent(
      size: SIZE_MAIN_CHARACTER.toVector2(),
      paint: Paint()..color = Colors.amber.withAlpha(20),
    );
    var spriteImages = await Flame.images.load(PATH_CHARACTER_MEDIA);
    final spriteSheet = SpriteSheet(
      image: spriteImages,
      srcSize: SIZE_MAIN_CHARACTER.toVector2(),
    );
    // main run animation
    animDown = spriteSheet.createAnimationByColumn(column: 0, stepTime: 0.2);
    animLeft = spriteSheet.createAnimationByColumn(column: 1, stepTime: 0.2);
    animUp = spriteSheet.createAnimationByColumn(column: 2, stepTime: 0.2);
    animRight = spriteSheet.createAnimationByColumn(column: 3, stepTime: 0.2);

    // idle animation
    animIdleDown = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.2,
      from: 0,
      to: 1,
    );
    animIdleLeft = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.2,
      from: 1,
      to: 2,
    );
    animIdleUp = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.2,
      from: 2,
      to: 3,
    );
    animIdleRight = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.2,
      from: 3,
      to: 4,
    );

    animation = animDown;

    playing = false;
    anchor = Anchor.center;
    add(RectangleHitbox());
    add(bg);
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    mainSpeed = runButton.buttonPressed ? runningSpeed : walkingSpeed;
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * mainSpeed * deltaTime);
      playing = true;
      var angle = getAngle(position, targetLocation);

      switch (joystick.direction) {
        case JoystickDirection.up:
          animation = animUp;
          currentDirection = DIRECTION_UP;
          break;
        case JoystickDirection.right:
        case JoystickDirection.upRight:
        case JoystickDirection.downRight:
          animation = animRight;
          currentDirection = DIRECTION_RIGHT;
          break;
        case JoystickDirection.left:
        case JoystickDirection.upLeft:
        case JoystickDirection.downLeft:
          animation = animLeft;
          currentDirection = DIRECTION_LEFT;
          break;
        case JoystickDirection.down:
          animation = animDown;
          currentDirection = DIRECTION_DOWN;
          break;
        case JoystickDirection.idle:
          animation = null;
          break;
      }
    } else {
      if (movingToTouchedLocation) {
        print(
          "(targetLocation - position).normalized() = ${(targetLocation - position).normalized()}",
        );
        position +=
            (targetLocation - position).normalized() * (mainSpeed * deltaTime);
        double threshold = 1.0;
        var difference = targetLocation - position;
        if (difference.x.abs() < threshold && difference.y.abs() < threshold) {
          stopAnimations();
          movingToTouchedLocation = false;
          return;
        }
      } else {
        if (playing) {
          stopAnimations();
        }
      }
    }
  }

  void stopAnimations() {
    playing = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is CharacterZombie || other is CharacterSkeleton) {
      other.removeFromParent();
      scoreText.setScore(10);
    }
    Future.delayed(const Duration(seconds: 2), () {
      if (other is CharacterZombie) {
        onAddEnemy(0);
      } else if (other is CharacterSkeleton) {
        onAddEnemy(1);
      }
    });
  }

  void moveToLocation(TapUpEvent info) {
    movingToTouchedLocation = false;
    stopAnimations();
    targetLocation = info.localPosition;
    movingToTouchedLocation = true;
  }
}



// import 'dart:async';
// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/sprite.dart';
// import 'package:flutter/material.dart';
// import 'package:goldrush_2d/commons/constants.dart';
// import 'package:goldrush_2d/components/characters/character_skeleton.dart';
// import 'package:goldrush_2d/components/characters/character_zombie.dart';
// import 'package:goldrush_2d/components/hud/joystick.dart';
// import 'package:goldrush_2d/components/hud/run_button.dart';
// import 'package:goldrush_2d/components/hud/score_text.dart';
// import 'package:goldrush_2d/utils/extension.dart';

// class CharacterMain extends SpriteAnimationComponent with CollisionCallbacks {
//   final Joystick joystick;
//   final ScoreText scoreText;
//   final RunButton runButton;
//   final double mainSpeed;
//   final Offset mainPosition;
//   final void Function(int) onAddEnemy;
//   CharacterMain({
//     required this.joystick,
//     required this.runButton,
//     required this.scoreText,
//     required this.mainSpeed,
//     required this.mainPosition,
//     required this.onAddEnemy,
//   })
//   //  : super(
//   //        characterPosition: mainPosition,
//   //        characterSize: SIZE_MAIN_CHARACTER,
//   //        characterSpeed: mainSpeed,
//   //      )
//   ;

//   late SpriteAnimation animLeft,
//       animUp,
//       animRight,
//       animDown,
//       animIdleFront,
//       animIdleBack,
//       animIdleLeft,
//       animIdleRight;

//   late double walkingSpeed;
//   late double runningSpeed;

//   double elapsedTime = 0.0;
//   JoystickDirection currentDirection = JoystickDirection.idle;
//   @override
//   FutureOr<void> onLoad() async {
//     super.onLoad();
//     walkingSpeed = mainSpeed;
//     runningSpeed = mainSpeed * 2;
//     var bg = RectangleComponent(
//       size: SIZE_MAIN_CHARACTER.toVector2(),
//       paint: Paint()..color = Colors.amber.withAlpha(20),
//     );
//     var spriteImages = await Flame.images.load(PATH_CHARACTER_MEDIA);
//     final spriteSheet = SpriteSheet(
//       image: spriteImages,
//       srcSize: SIZE_MAIN_CHARACTER.toVector2(),
//     );
//     animDown = spriteSheet.createAnimationByColumn(column: 0, stepTime: 0.2);
//     animLeft = spriteSheet.createAnimationByColumn(column: 1, stepTime: 0.2);
//     animUp = spriteSheet.createAnimationByColumn(column: 2, stepTime: 0.2);
//     animRight = spriteSheet.createAnimationByColumn(column: 3, stepTime: 0.2);
//     animIdleFront = spriteSheet.createAnimation(
//       row: 0,
//       stepTime: 0.2,
//       from: 0,
//       to: 1,
//     );
//     animIdleBack = spriteSheet.createAnimation(
//       row: 2,
//       stepTime: 0.2,
//       from: 2,
//       to: 3,
//     );
//     animIdleLeft = spriteSheet.createAnimation(
//       row: 2,
//       stepTime: 0.2,
//       from: 1,
//       to: 2,
//     );
//     animIdleRight = spriteSheet.createAnimation(
//       row: 2,
//       stepTime: 0.2,
//       from: 3,
//       to: 4,
//     );
//     animation = animDown;
//     add(RectangleHitbox());
//     add(bg);
//   }

//   @override
//   void update(double deltaTime) {
//     super.update(deltaTime);
//     switch (joystick.direction) {
//       case JoystickDirection.down:
//         position.y += mainSpeed * deltaTime;
//         animation = animDown;
//         if (currentDirection != JoystickDirection.down) {
//           currentDirection = JoystickDirection.down;
//         }

//         break;
//       case JoystickDirection.downLeft:
//         position.y += mainSpeed * deltaTime;
//         position.x -= mainSpeed * deltaTime;
//         animation = animLeft;
//         if (currentDirection != JoystickDirection.downLeft) {
//           currentDirection = JoystickDirection.downLeft;
//         }

//         break;
//       case JoystickDirection.downRight:
//         position.y += mainSpeed * deltaTime;
//         position.x += mainSpeed * deltaTime;
//         animation = animRight;

//         if (currentDirection != JoystickDirection.downRight) {
//           currentDirection = JoystickDirection.downRight;
//         }
//         break;
//       case JoystickDirection.idle:
//         switch (currentDirection) {
//           case JoystickDirection.down:
//             animation = animIdleFront;
//             break;
//           case JoystickDirection.downLeft:
//             animation = animIdleLeft;
//             break;
//           case JoystickDirection.downRight:
//             animation = animIdleRight;
//             break;
//           case JoystickDirection.left:
//             animation = animIdleLeft;
//             break;
//           case JoystickDirection.right:
//             animation = animIdleRight;
//             break;
//           case JoystickDirection.up:
//             animation = animIdleBack;
//             break;
//           case JoystickDirection.upLeft:
//             animation = animIdleLeft;
//             break;
//           case JoystickDirection.upRight:
//             animation = animIdleRight;
//             break;
//           default:
//             break;
//         }

//         break;
//       case JoystickDirection.left:
//         position.x -= mainSpeed * deltaTime;
//         animation = animLeft;

//         if (currentDirection != JoystickDirection.left) {
//           currentDirection = JoystickDirection.left;
//         }
//         break;
//       case JoystickDirection.right:
//         position.x += mainSpeed * deltaTime;
//         animation = animRight;

//         if (currentDirection != JoystickDirection.right) {
//           currentDirection = JoystickDirection.right;
//         }
//         break;
//       case JoystickDirection.up:
//         position.y -= mainSpeed * deltaTime;
//         animation = animUp;
//         if (currentDirection != JoystickDirection.up) {
//           currentDirection = JoystickDirection.up;
//         }
//         break;
//       case JoystickDirection.upLeft:
//         position.y -= mainSpeed * deltaTime;
//         position.x -= mainSpeed * deltaTime;
//         animation = animLeft;

//         if (currentDirection != JoystickDirection.upLeft) {
//           currentDirection = JoystickDirection.upLeft;
//         }
//         break;
//       case JoystickDirection.upRight:
//         position.y -= mainSpeed * deltaTime;
//         position.x += mainSpeed * deltaTime;
//         animation = animRight;

//         if (currentDirection != JoystickDirection.upRight) {
//           currentDirection = JoystickDirection.upRight;
//         }
//         break;
//     }
//   }

//   @override
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
//     super.onCollision(intersectionPoints, other);
//     if (other is CharacterZombie || other is CharacterSkeleton) {
//       other.removeFromParent();
//       scoreText.setScore(10);
//     }
//     Future.delayed(const Duration(seconds: 2), () {
//       if (other is CharacterZombie) {
//         onAddEnemy(0);
//       } else if (other is CharacterSkeleton) {
//         onAddEnemy(1); 
//       }
//     });
//   }
// }
