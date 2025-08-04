import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:my_game/game/components/hero/hero.dart';
import 'package:my_game/game/dungeon_game.dart';

class TapMovingBehavior extends TappableBehavior<Hero>
    with HasGameReference<DungeonGame> {
  @override
  void onTapDown(TapDownEvent event) {
    print(event.toString());
  }
}
