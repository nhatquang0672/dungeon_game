import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:my_game/colonist_game/game_map/game_map.dart';
import 'package:my_game/game/configuration/configuration.dart';

class ColonistGame extends FlameGame {
  ColonistGame()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  late final GameMap _currentMap;
  // final PositionComponent _cameraPosition = PositionComponent();
  @override
  FutureOr<void> onLoad() async {
    // await images.loadAll(['bread.png', 'ant_walk.png', 'cheese.png']);
    // await Flame.images.load('bread.png');
    await Flame.images.load('ant_walk.png');
    // await Flame.images.load('cheese.png');
    //
    // camera.follow(_cameraPosition);
    //
    // _cameraPosition.position = Vector2(
    //   mapWidth * dTileSize / 2,
    //   mapHeight * dTileSize / 2,
    // );
    // print(_cameraPosition.toString());
    // camera.viewfinder.anchor = Anchor.topLeft;
    await world.add(_currentMap = GameMap());
  }
}
