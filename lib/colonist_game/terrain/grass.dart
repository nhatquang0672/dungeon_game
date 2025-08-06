import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:my_game/colonist_game/terrain/terrain.dart';

class Grass extends PositionComponent with Terrain {
  static final _color = Paint()..color = const Color(0xff567d46);
  static final _debugColor = Paint()..color = Colors.red.withValues(alpha: 0.5);

  static final _borderPaint = Paint()
    ..color = Colors
        .white // Border color
    ..strokeWidth =
        2 // Border thickness
    ..style = PaintingStyle.stroke;

  late final _rect = size.toRect();
  late final _rect2 = Rect.fromCenter(
    center: _rect.center,
    height: 10,
    width: 10,
  );
  @override
  void render(Canvas canvas) {
    canvas.drawRect(_rect, _color);
    canvas.drawRect(_rect, _borderPaint);
    canvas.drawRect(_rect2, _debugColor);
  }

  @override
  double difficulty = 1.0;
}
