import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';
import 'package:my_game/game/components/hero/hero.dart';
import 'package:my_game/game/configuration/configuration.dart';
import 'package:my_game/game/dungeon_game.dart';

class NewTapMovingBehavior extends Behavior<MainHero>
    with HasGameRef<DungeonGame> {
  double _horizontalMovement = 0;
  double _verticalMovement = 0;
  final Vector2 _velocity = Vector2.zero();
  final _inputVector = Vector2.zero();
  final _destination = Vector2.zero();
  Vector2? tapDes;
  final _nextPosition = Vector2.zero();
  // final PlayerCollider collider;

  void onKeyEvent(Vector2 tapPosition) {
    _horizontalMovement = 0;
    _verticalMovement = 0;
    final isLeftKeyPressed = false;
    final isRightKeyPressed = true;
    final isUpKeyPressed = false;
    final isDownKeyPressed = false;
    _updatePlayerOrientation(
      isLeftKeyPressed: isLeftKeyPressed,
      isRightKeyPressed: isRightKeyPressed,
      isUpKeyPressed: isUpKeyPressed,
      isDownKeyPressed: isDownKeyPressed,
    );
    _horizontalMovement += isLeftKeyPressed ? -1 : 0;
    _horizontalMovement += isRightKeyPressed ? 1 : 0;
    _verticalMovement += isDownKeyPressed ? 1 : 0;
    _verticalMovement += isUpKeyPressed ? -1 : 0;
    tapDes = tapPosition;

    _inputVector
      ..setValues(_horizontalMovement, _verticalMovement)
      ..normalize();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!game.overlays.activeOverlays.isNotEmpty && tapDes != null) {
      _updatePlayerMovement(dt);
      _updateIfIdle();
    }
  }

  void _updatePlayerMovement(double dt) {
    _velocity.setFrom(_inputVector * playerMoveSpeed * dt);

    _destination.setValues(
      parent.position.x + _velocity.x,
      parent.position.y + _velocity.y,
    );

    // Determines the next position we can actually move to if we were to try
    // to move directly to _destination this frame.
    // collider.calculateNextPosition(_destination, _nextPosition);

    parent.position.setFrom(tapDes ?? Vector2.zero());
  }

  void _updatePlayerOrientation({
    required bool isLeftKeyPressed,
    required bool isRightKeyPressed,
    required bool isUpKeyPressed,
    required bool isDownKeyPressed,
  }) {
    if (isLeftKeyPressed) {
      parent.current = PlayerOrientation.left;
    } else if (isRightKeyPressed) {
      parent.current = PlayerOrientation.right;
    } else if (isUpKeyPressed) {
      parent.current = PlayerOrientation.up;
    } else if (isDownKeyPressed) {
      parent.current = PlayerOrientation.down;
    }
  }

  void _updateIfIdle() {
    if (_velocity.isZero()) {
      if (parent.current case PlayerOrientation.down) {
        parent.current = PlayerOrientation.idleDown;
      } else if (parent.current case PlayerOrientation.up) {
        parent.current = PlayerOrientation.idleUp;
      } else if (parent.current case PlayerOrientation.left) {
        parent.current = PlayerOrientation.idleLeft;
      } else if (parent.current case PlayerOrientation.right) {
        parent.current = PlayerOrientation.idleRight;
      }
    }
  }
}
