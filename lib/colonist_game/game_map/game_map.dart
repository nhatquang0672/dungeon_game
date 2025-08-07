import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:my_game/colonist_game/colonist_game.dart';
import 'package:my_game/colonist_game/standard/int_vector2.dart';
import 'package:my_game/colonist_game/standard/range_extension.dart';
import 'package:my_game/colonist_game/terrain/grass.dart';
import 'package:my_game/colonist_game/terrain/terrain.dart';
import 'package:my_game/colonist_game/unit/worker.dart';
import 'package:my_game/game/configuration/configuration.dart';

class GameMap extends Component with HasGameReference<ColonistGame> {
  static const totalPositions = mapWidth * mapHeight;
  static final int workerSpread = (0.1 * totalPositions).toInt();

  static const double workerMinSpeed = 25;
  static const double workerMaxSpeed = 75;

  final mapPositions = List.generate(totalPositions, (index) => index)
    ..shuffle();

  @override
  FutureOr<void> onLoad() {
    for (var x = 0; x < mapWidth; x++) {
      for (var y = 0; y < mapHeight; y++) {
        addTerrain(IntVector2(x, y), Grass());
      }
    }

    for (final _ in 0.to(workerSpread))
      add(
        Worker(
          mapPositions[0] ~/ mapWidth,
          mapPositions.removeAt(0) % mapHeight,
          speed:
              Random().nextDouble() * (workerMaxSpeed - workerMinSpeed) +
              workerMinSpeed,
        ),
      );

    // game.camera.follow(worker);
  }

  final Map<IntVector2, Terrain> _terrains = {};

  void addTerrain(IntVector2 position, Terrain terrain) {
    _terrains[position] = terrain;
    add(
      terrain
        ..x = position.x * dTileSize
        ..y = position.y * dTileSize
        ..width = dTileSize
        ..height = dTileSize,
    );
  }
}
