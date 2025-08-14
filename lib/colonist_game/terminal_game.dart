import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:my_game/colonist_game/brains/hero_brain.dart';
import 'package:my_game/colonist_game/brains/path_finder.dart';
import 'package:my_game/colonist_game/brains/worker_brain.dart';
import 'package:my_game/colonist_game/game_map/game_map.dart';
import 'package:my_game/colonist_game/game_map/terminal_map.dart';
import 'package:my_game/colonist_game/terrain/terrain.dart';
import 'package:my_game/colonist_game/unit/shero.dart';
import 'package:my_game/colonist_game/unit/worker.dart';
import 'package:my_game/game/configuration/configuration.dart';

class TerminalGame extends FlameGame {
  TerminalGame()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  late final TerminalMap _terminalMap;
  @override
  FutureOr<void> onLoad() async {
    // await Flame.images.load('fonts/dos-short.png');
    // await Flame.images.load('fonts/dos.png');

    await world.add(_terminalMap = TerminalMap());
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewfinder.zoom = 1.5;
    // camera.follow(_currentMap.sHero);
  }
}
