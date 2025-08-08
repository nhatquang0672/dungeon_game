import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:my_game/colonist_game/colonist_game.dart';
import 'package:my_game/colonist_game/objects/colonist_object.dart';
import 'package:my_game/colonist_game/standard/int_vector2.dart';
import 'package:my_game/colonist_game/standard/pair.dart';
import 'package:my_game/colonist_game/unit/movable.dart';
import 'package:my_game/game/configuration/configuration.dart';

class Worker extends SpriteAnimationGroupComponent<MoveDirection>
    with HasGameReference<ColonistGame>, Movable, ColonistsObject {
  @override
  final double speed;

  Worker(num x, num y, {this.speed = 50}) {
    super.y = y * dTileSize + dTileSize / 2;
    super.x = x * dTileSize + dTileSize / 2;
    height = dTileSize;
    width = dTileSize;
    anchor = Anchor.center;

    final downRightAnimation = getSpriteAnimation(5);
    animations = {
      MoveDirection.idle: SpriteAnimation.spriteList(
        // Use the second frame from down-right animation
        [downRightAnimation.frames[1].sprite],
        stepTime: 1,
      ),
      MoveDirection.up: getSpriteAnimation(0),
      MoveDirection.upRight: getSpriteAnimation(7),
      MoveDirection.right: getSpriteAnimation(6),
      MoveDirection.downRight: downRightAnimation,
      MoveDirection.down: getSpriteAnimation(4),
      MoveDirection.upLeft: getSpriteAnimation(1),
      MoveDirection.left: getSpriteAnimation(2),
      MoveDirection.downLeft: getSpriteAnimation(3),
    };

    current = MoveDirection.idle;
  }

  SpriteAnimation getSpriteAnimation(int row) {
    return SpriteAnimation.fromFrameData(
      Flame.images.fromCache('ant_walk.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(64, 64),
        amountPerRow: 4,
        texturePosition: Vector2(0, 64.0 * row),
      ),
    );
  }

  Pair<IntVector2, List<IntVector2>>? _currentTask;

  @override
  void reachedDestination() {
    _currentTask = null;
  }

  bool get isIdle => _currentTask == null;

  @override
  void setCurrentDirection(MoveDirection direction) {
    current = direction;
  }

  void issueWork(IntVector2 des, List<IntVector2> path) {
    print('!!!! issueWork');
    walkPath(path);
    _currentTask = Pair(des, path);
  }

  @override
  IntVector2 get tileSize => const IntVector2(1, 1);
}
