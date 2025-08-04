import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:my_game/game/components/dungeon_world.dart';
import 'package:my_game/game/configuration/configuration.dart';

class DungeonGame extends FlameGame {
  late final CameraComponent cam;
  @override
  Color backgroundColor() => gameBackgroundColor;

  @override
  final world = DungeonWorld(mapFileName: _levels.random());

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    cam = CameraComponent.withFixedResolution(
      width: gameHeight,
      height: gameHeight,
      world: world,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    await addAll([cam, world]);

    return super.onLoad();
  }

  static const _levels = [
    'escape-room-01.tmx',
    'escape-room-02.tmx',
    'escape-room-03.tmx',
    'escape-room-04.tmx',
    'escape-room-05.tmx',
    'escape-room-06.tmx',
    'escape-room-07.tmx',
    'escape-room-08.tmx',
    'escape-room-09.tmx',
    'escape-room-10.tmx',
  ];
}
