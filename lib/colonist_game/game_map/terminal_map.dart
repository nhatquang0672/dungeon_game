import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:malison/malison.dart' as malison;
import 'package:my_game/colonist_game/terrain/retro_terminal.dart';

/// Terminal size in characters.
const int width = 80;
const int height = 30;

/// A Flame component that renders a malison RetroTerminal to the Flutter canvas.
class TerminalMap extends Component {
  late final RetroTerminal _terminal;
  final List<_Ball> _balls = [];
  bool _staticDrawn = false;

  @override
  Future<void> onLoad() async {
    _terminal = RetroTerminal.dos(width, height);

    final colors = <malison.Color>[
      malison.Color.red,
      malison.Color.orange,
      malison.Color.gold,
      malison.Color.yellow,
      malison.Color.green,
      malison.Color.aqua,
      malison.Color.blue,
      malison.Color.purple,
    ];

    final random = math.Random();
    for (final char in '0123456789'.codeUnits) {
      for (final color in colors) {
        _balls.add(
          _Ball(
            color,
            char,
            random.nextDouble() * _Ball.pitWidth,
            random.nextDouble() * (_Ball.pitHeight / 2.0),
            random.nextDouble() + 0.2,
            0.0,
          ),
        );
      }
    }
  }

  @override
  void update(double dt) {
    for (final ball in _balls) {
      ball.update();
    }
  }

  @override
  void render(Canvas canvas) {
    // Compose frame contents into the terminal without clearing static content.

    if (!_staticDrawn) {
      void colorBar(
        int y,
        String name,
        malison.Color light,
        malison.Color medium,
        malison.Color dark,
      ) {
        _terminal.writeAt(2, y, name, malison.Color.gray);
        _terminal.writeAt(10, y, 'light', light);
        _terminal.writeAt(16, y, 'medium', medium);
        _terminal.writeAt(23, y, 'dark', dark);

        _terminal.writeAt(28, y, ' light ', malison.Color.black, light);
        _terminal.writeAt(35, y, ' medium ', malison.Color.black, medium);
        _terminal.writeAt(43, y, ' dark ', malison.Color.black, dark);
      }

      _terminal.writeAt(10, 10, 'Predefined colors:');
      colorBar(
        1,
        'gray',
        malison.Color.lightGray,
        malison.Color.gray,
        malison.Color.darkGray,
      );
      colorBar(
        2,
        'red',
        malison.Color.lightRed,
        malison.Color.red,
        malison.Color.darkRed,
      );
      colorBar(
        3,
        'orange',
        malison.Color.lightOrange,
        malison.Color.orange,
        malison.Color.darkOrange,
      );
      colorBar(
        4,
        'gold',
        malison.Color.lightGold,
        malison.Color.gold,
        malison.Color.darkGold,
      );
      colorBar(
        5,
        'yellow',
        malison.Color.lightYellow,
        malison.Color.yellow,
        malison.Color.darkYellow,
      );
      colorBar(
        6,
        'green',
        malison.Color.lightGreen,
        malison.Color.green,
        malison.Color.darkGreen,
      );
      colorBar(
        7,
        'aqua',
        malison.Color.lightAqua,
        malison.Color.aqua,
        malison.Color.darkAqua,
      );
      colorBar(
        8,
        'blue',
        malison.Color.lightBlue,
        malison.Color.blue,
        malison.Color.darkBlue,
      );
      colorBar(
        9,
        'purple',
        malison.Color.lightPurple,
        malison.Color.purple,
        malison.Color.darkPurple,
      );
      colorBar(
        10,
        'brown',
        malison.Color.lightBrown,
        malison.Color.brown,
        malison.Color.darkBrown,
      );

      _terminal.writeAt(0, 12, 'Code page 437:');
      final lines = <String>[
        ' ☺☻♥♦♣♠•◘○◙♂♀♪♫☼',
        '►◄↕‼¶§▬↨↑↓→←∟↔▲▼',
        ' !"#\$%&\'()*+,-./',
        '0123456789:;<=>?',
        '@ABCDEFGHIJKLMNO',
        'PQRSTUVWXYZ[\\]^_',
        '`abcdefghijklmno',
        'pqrstuvwxyz{|}~⌂',
        'ÇüéâäàåçêëèïîìÄÅ',
        'ÉæÆôöòûùÿÖÜ¢£¥₧ƒ',
        'áíóúñÑªº¿⌐¬½¼¡«»',
        '░▒▓│┤╡╢╖╕╣║╗╝╜╛┐',
        '└┴┬├─┼╞╟╚╔╩╦╠═╬╧',
        '╨╤╥╙╘╒╓╫╪┘┌█▄▌▐▀',
        'αßΓπΣσµτΦΘΩδ∞φε∩',
        '≡±≥≤⌠⌡÷≈°∙·√ⁿ²■',
      ];

      var y = 13;
      for (final line in lines) {
        _terminal.writeAt(3, y++, line, malison.Color.lightGray);
      }

      _staticDrawn = true;
    }

    for (final ball in _balls) {
      // Erase previous position (if any) to avoid trails when not clearing).
      if (ball.prevCellX != null && ball.prevCellY != null) {
        _terminal.drawChar(
          ball.prevCellX!,
          ball.prevCellY!,
          malison.CharCode.space,
          malison.Color.white,
          malison.Color.black,
        );
      }

      final currentCellX = 24 + ball.x.toInt();
      final currentCellY = 13 + ball.y.toInt();

      _terminal.drawChar(
        currentCellX,
        currentCellY,
        ball.charCode,
        ball.color,
      );

      ball.prevCellX = currentCellX;
      ball.prevCellY = currentCellY;
    }

    // Draw the terminal to the Flutter canvas.
    _terminal.paintTo(canvas);
  }
}

class _Ball {
  static const double pitWidth = 56.0;
  static const double pitHeight = 17.0;

  final malison.Color color;
  final int charCode;

  double x, y, h, v;

  int? prevCellX;
  int? prevCellY;

  _Ball(this.color, this.charCode, this.x, this.y, this.h, this.v);

  void update() {
    x += h;
    if (x < 0.0) {
      x = -x;
      h = -h;
    } else if (x > pitWidth) {
      x = pitWidth - x + pitWidth;
      h = -h;
    }

    v += 0.03;
    y += v;
    if (y > pitHeight) {
      y = pitHeight - y + pitHeight;
      v = -v;
    }
  }

  void render(malison.Terminal terminal) {
    terminal.drawChar(24 + x.toInt(), 13 + y.toInt(), charCode, color);
  }
}
