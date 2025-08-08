import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:my_game/colonist_game/brains/path_finder.dart';
import 'package:my_game/colonist_game/brains/worker_brain.dart';
import 'package:my_game/colonist_game/game_map/game_map.dart';
import 'package:my_game/colonist_game/terrain/terrain.dart';
import 'package:my_game/colonist_game/unit/worker.dart';
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
  @override
  FutureOr<void> onLoad() async {
    await Flame.images.load('ant_walk.png');
    await add(WorkerBrain());
    await world.add(_currentMap = GameMap());
    camera.follow(_currentMap.worker);
  }

  Worker get worker => _currentMap.worker;
  PathFinderData get pathFinderData => _currentMap.pathFinderData;
  Terrain tileAtPosition(int x, int y) {
    return _currentMap.tileAtPosition(x, y);
  }
}
