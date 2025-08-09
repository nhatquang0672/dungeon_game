import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:my_game/colonist_game/colonist_game.dart';
import 'package:my_game/colonist_game/objects/colonist_object.dart';
import 'package:my_game/colonist_game/standard/int_vector2.dart';
import 'package:my_game/colonist_game/standard/pair.dart';
import 'package:my_game/colonist_game/unit/movable.dart';
import 'package:my_game/game/configuration/configuration.dart';

class SHero extends SpriteComponent
    with HasGameReference<ColonistGame>, Movable, ColonistsObject {
  @override
  final double speed;

  SHero(num x, num y, {this.speed = 50}) {
    super.y = y * dTileSize + dTileSize / 2;
    super.x = x * dTileSize + dTileSize / 2;
    height = dTileSize;
    width = dTileSize;
    anchor = Anchor.center;
  }

  Pair<IntVector2, List<IntVector2>>? _currentTask;

  @override
  FutureOr<void> onLoad() {
    final image = Flame.images.fromCache('gervais_32x32.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 128,
      rows: 30,
    );
    sprite = sheet.getSprite(4, 1);

    return super.onLoad();
  }

  @override
  void onMount() {
    super.onMount();
    // Now `game` is guaranteed to be non-null
  }

  @override
  void reachedDestination() {
    _currentTask = null;
  }

  bool get isIdle => _currentTask == null;

  @override
  void setCurrentDirection(MoveDirection direction) {
    print('lala: ' + direction.toString());
  }

  void issueWork(IntVector2 des, List<IntVector2> path) {
    walkPath(path);
    _currentTask = Pair(des, path);
  }

  @override
  IntVector2 get tileSize => const IntVector2(1, 1);
}
