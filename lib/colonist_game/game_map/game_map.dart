import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:my_game/colonist_game/brains/path_finder.dart';
import 'package:my_game/colonist_game/brains/worker_brain.dart';
import 'package:my_game/colonist_game/colonist_game.dart';
import 'package:my_game/colonist_game/standard/int_vector2.dart';
import 'package:my_game/colonist_game/terrain/grass.dart';
import 'package:my_game/colonist_game/terrain/terrain.dart';
import 'package:my_game/colonist_game/unit/worker.dart';
import 'package:my_game/game/configuration/configuration.dart';

class GameMap extends Component
    with HasGameReference<ColonistGame>, TapCallbacks {
  static const double workerMinSpeed = 25;
  static const double workerMaxSpeed = 75;

  final Map<IntVector2, Terrain> _terrain = {};

  void addTerrain(IntVector2 position, Terrain terrain) {
    _terrain[position] = terrain;
    add(
      terrain
        ..x = position.x * dTileSize
        ..y = position.y * dTileSize
        ..width = dTileSize
        ..height = dTileSize,
    );
  }

  @override
  FutureOr<void> onLoad() {
    for (var x = 0; x < mapWidth; x++) {
      for (var y = 0; y < mapHeight; y++) {
        addTerrain(IntVector2(x, y), Grass());
      }
    }

    worker = Worker(
      mapWidth / 2,
      mapHeight / 2,
      speed:
          Random().nextDouble() * (workerMaxSpeed - workerMinSpeed) +
          workerMinSpeed,
    );
    add(worker);
  }

  late final Worker worker;

  @override
  void onTapDown(TapDownEvent event) {
    print('game tap: ' + event.toString());
    final brain = game.descendants().whereType<WorkerBrain>().firstOrNull;
    if (brain != null) {
      final worldPosition = game.camera.globalToLocal(
        event.canvasPosition,
      );
      print('do we have brain ?');
      brain.calculateTasks(worldPosition);
    }
  }

  PathFinderData get pathFinderData => PathFinderData.fromWorld(
    terrain: _terrain,
    worldObjects: [],
  );

  @override
  bool containsLocalPoint(Vector2 point) {
    return (point.x >= 0) &&
        (point.y >= 0) &&
        (point.x < mapWidth * dTileSize) &&
        (point.y < mapHeight * dTileSize);
  }

  Terrain tileAtPosition(int x, int y) {
    return _terrain[IntVector2(x, y)]!;
  }
}
