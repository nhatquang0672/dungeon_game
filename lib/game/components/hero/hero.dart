import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:my_game/game/components/hero/behaviors/new_tap_moving_behavior.dart';
import 'package:my_game/game/components/hero/behaviors/tap_moving_behavior.dart';
import 'package:my_game/game/configuration/configuration.dart';
import 'package:my_game/game/dungeon_game.dart';

enum PlayerOrientation {
  down(row: 0),
  idleDown(row: 0),
  up(row: 3),
  idleUp(row: 3),
  right(row: 2),
  idleRight(row: 2),
  left(row: 1),
  idleLeft(row: 1);

  const PlayerOrientation({required this.row});

  final int row;
}

class Hero extends SpriteAnimationGroupComponent<PlayerOrientation>
    with HasGameRef<DungeonGame>, EntityMixin {
  Hero({
    required this.character,
    // required this.collider,
    required Vector2 position,
    required this.continuePropagation,
    required super.size,
  }) : super(
         position: position,
         priority: position.y.toInt() ~/ tileSize.y,
         children: [
           // PropagatingCollisionBehavior(
           //   NonPhysicsHitbox(size: collider.hitbox.size),
           // ),
           NewTapMovingBehavior(),
           // PuzzleChallengeBehavior(),
         ],
       ) {
    // Y-sorting based on the player's position. This allows us to show up
    // behind objects that are positioned further down the y axis than us.
    this.position.addListener(() {
      final pos = absolutePosition.y.toInt();
      final newPriority = pos;

      if (newPriority != priority) {
        priority = newPriority;
      }
    });
  }

  // final PlayerCollider collider;

  final String character;
  final bool continuePropagation;

  late final SpriteAnimation _rightOrientationAnimation;
  late final SpriteAnimation _idleRightOrientationAnimation;
  late final SpriteAnimation _leftOrientationAnimation;
  late final SpriteAnimation _idleLeftOrientationAnimation;
  late final SpriteAnimation _upOrientationAnimation;
  late final SpriteAnimation _idleUpOrientationAnimation;
  late final SpriteAnimation _downOrientationAnimation;
  late final SpriteAnimation _idleDownOrientationAnimation;

  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;

  @override
  FutureOr<void> onLoad() async {
    _loadPlayerAnimations();
    return super.onLoad();
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   // TODO: implement onTapDown
  //   print('hero' + event.toString());
  // }

  void _loadPlayerAnimations() {
    final image = game.images.fromCache('characters/$character.png');
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: playerSpriteSheetSize,
    );
    _rightOrientationAnimation = _loadAnimation(
      PlayerOrientation.right,
      spriteSheet,
    );
    _leftOrientationAnimation = _loadAnimation(
      PlayerOrientation.left,
      spriteSheet,
    );
    _upOrientationAnimation = _loadAnimation(PlayerOrientation.up, spriteSheet);
    _downOrientationAnimation = _loadAnimation(
      PlayerOrientation.down,
      spriteSheet,
    );
    _idleRightOrientationAnimation = _loadAnimation(
      PlayerOrientation.idleRight,
      spriteSheet,
      to: 1,
    );
    _idleLeftOrientationAnimation = _loadAnimation(
      PlayerOrientation.idleLeft,
      spriteSheet,
      to: 1,
    );
    _idleUpOrientationAnimation = _loadAnimation(
      PlayerOrientation.idleUp,
      spriteSheet,
      to: 1,
    );
    _idleDownOrientationAnimation = _loadAnimation(
      PlayerOrientation.idleDown,
      spriteSheet,
      to: 1,
    );
    animations = {
      PlayerOrientation.right: _rightOrientationAnimation,
      PlayerOrientation.idleRight: _idleRightOrientationAnimation,
      PlayerOrientation.left: _leftOrientationAnimation,
      PlayerOrientation.idleLeft: _idleLeftOrientationAnimation,
      PlayerOrientation.up: _upOrientationAnimation,
      PlayerOrientation.idleUp: _idleUpOrientationAnimation,
      PlayerOrientation.down: _downOrientationAnimation,
      PlayerOrientation.idleDown: _idleDownOrientationAnimation,
    };
    current = PlayerOrientation.idleRight;
  }

  SpriteAnimation _loadAnimation(
    PlayerOrientation orientation,
    SpriteSheet spriteSheet, {
    int to = playerSpriteSheetFrames,
  }) {
    return spriteSheet.createAnimation(
      row: orientation.row,
      stepTime: playerStepTimeAnimation,
      to: to,
    );
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   // TODO: implement onTapDown
  //   print('hero: ' + event.toString());
  // }

  void handleWorldTap(Vector2 tapPosition) {
    // Move or act based on tap
    print('Hero received tap at $tapPosition');

    findBehavior<NewTapMovingBehavior>()?.onKeyEvent(tapPosition);
    // e.g., moveTo(tapPosition);
  }
}
