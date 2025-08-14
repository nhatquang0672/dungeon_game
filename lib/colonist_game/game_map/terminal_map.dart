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

  void renderColorBar(RetroTerminal _terminall) {
    void colorBar(
      int y,
      String name,
      malison.Color light,
      malison.Color medium,
      malison.Color dark,
    ) {
      _terminall.writeAt(2, y, name, malison.Color.gray);
      _terminall.writeAt(10, y, 'light', light);
      _terminall.writeAt(16, y, 'medium', medium);
      _terminall.writeAt(23, y, 'dark', dark);

      _terminall.writeAt(28, y, ' light ', malison.Color.black, light);
      _terminall.writeAt(35, y, ' medium ', malison.Color.black, medium);
      _terminall.writeAt(43, y, ' dark ', malison.Color.black, dark);
    }

    _terminall.writeAt(10, 10, 'Predefined colors:');
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

    _terminall.writeAt(0, 12, 'Code page 437:');
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
      _terminall.writeAt(3, y++, line, malison.Color.lightGray);
    }
  }

  @override
  void render(Canvas canvas) {
    // Pass 1: clear and flush so Display's baseline becomes spaces.
    _terminal.clear();
    _terminal.paintTo(canvas);

    // Pass 2: draw static UI and dynamic balls, then flush again.
    renderColorBar(_terminal);
    for (final ball in _balls) {
      final currentCellX = 24 + ball.x.toInt();
      final currentCellY = 13 + ball.y.toInt();
      _terminal.drawChar(currentCellX, currentCellY, ball.charCode, ball.color);
    }
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
