import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:my_game/game/configuration/configuration.dart';
import 'package:my_game/game/components/hero/hero.dart';
import 'package:my_game/game/dungeon_map.dart';

class DungeonWorld extends World with TapCallbacks {
  DungeonWorld({required this.mapFileName}) : super(children: []);
  String mapFileName;

  late DungeonMap map;
  late TiledComponent mapLevel;
  late DungeonMap background;
  late TiledComponent backgroundLevel;
  final List<DungeonMap> furniture = [];
  final List<TiledComponent> furnitureProps = [];
  @override
  FutureOr<void> onLoad() async {
    map = await DungeonMap.load(filename: mapFileName, tileSize: tileSize);
    mapLevel = TiledComponent(map.renderableTiledMap);

    final furnitureLayerNames = map.tiledMap.layers
        .where(
          (layer) =>
              layer.properties.byName[customTypeProp]?.value == furnitureType,
        )
        .map((layer) => layer.name);

    final backgroundTask = DungeonMap.load(
      filename: mapFileName,
      tileSize: tileSize,
      mapTransformer: (map) => map.layers.retainWhere(
        (layer) =>
            layer.properties.byName[customTypeProp]?.value == backgroundLayer,
      ),
    );

    final furnitureFutures = <Future<DungeonMap>>[];

    for (final layerName in furnitureLayerNames) {
      furnitureFutures.add(
        DungeonMap.load(
          filename: mapFileName,
          tileSize: tileSize,
          mapTransformer: (map) => map.layers.retainWhere(
            (layer) => layer.name == layerName,
          ),
        ),
      );
    }

    final futures = await Future.wait([backgroundTask, ...furnitureFutures]);
    background = futures[0];

    furniture.addAll(futures.sublist(1));

    backgroundLevel = TiledComponent(background.renderableTiledMap);

    add(backgroundLevel);

    for (final furnitureMap in furniture) {
      final originLayer =
          (furnitureMap.tiledMap.layers.single as Group).layers.firstWhere(
                (layer) => layer is ObjectGroup,
              )
              as ObjectGroup;

      // y-sorting: the origin's y position is the render priority.
      // grab all object y positions and average them to make the originY
      final originY =
          originLayer.objects.map((obj) => obj.y).reduce((a, b) => a + b) /
          originLayer.objects.length;

      final priority = originY.floor();

      final furnitureProp = TiledComponent(
        furnitureMap.renderableTiledMap,
        priority: priority,
      );

      furnitureProps.add(furnitureProp);

      add(furnitureProp);
    }

    add(mapLevel);
    _loadSpawnPoints();

    return super.onLoad();
  }

  void _loadSpawnPoints() {
    final spawnPointsLayer = mapLevel.tileMap.getLayer<ObjectGroup>(
      spawnPointObjectLayer,
    );
    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case spawnPointPlayerClass:
            final position = Vector2(spawnPoint.x, spawnPoint.y) * 2;

            // final position = Vector2(217, 58);
            // final colliderPosition =
            //     position + Vector2(0, spawnPoint.height + spawnPoint.width);
            // final colliderSize = Vector2.all(spawnPoint.width);
            // final hitbox = RectangleHitbox(size: colliderSize);
            // final collider = PlayerCollider(
            //   size: colliderSize,
            //   position: colliderPosition,
            //   hitbox: hitbox,
            // );
            final player = MainHero(
              character: 'conference_woman',
              position: position,
              // size: Vector2(spawnPoint.width, spawnPoint.height),
              size: Vector2.all(32),
            );
            // add(collider);
            add(player);
          default:
            throw UnimplementedError('${spawnPoint.class_} not implemented');
        }
      }
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    final hero = descendants().whereType<MainHero>().firstOrNull;
    if (hero != null) {
      hero.handleWorldTap(event.localPosition);
    }
  }
}
