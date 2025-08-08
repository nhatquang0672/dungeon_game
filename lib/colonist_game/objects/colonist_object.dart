import 'package:flame/components.dart';
import 'package:my_game/colonist_game/standard/int_vector2.dart';
import 'package:my_game/game/configuration/configuration.dart';

mixin ColonistsObject on PositionComponent {
  IntVector2 get tileSize;

  IntVector2 get tilePosition => IntVector2(
    x ~/ dTileSize,
    y ~/ dTileSize,
  );
}
