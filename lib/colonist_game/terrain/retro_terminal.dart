import 'dart:ui' as ui;

import 'package:flutter/services.dart' show rootBundle;
import 'package:malison/malison.dart' as malison;
import 'package:piecemeal/piecemeal.dart';

import 'package:malison/src/unicode_map.dart';

/// A [RenderableTerminal] that draws to a canvas using the old school DOS
/// [code page 437][font] font.
///
/// [font]: http://en.wikipedia.org/wiki/Code_page_437
class RetroTerminal extends malison.RenderableTerminal {
  final malison.Display _display;

  ui.Canvas? _canvas;
  ui.Image? _font;

  /// The drawing scale, used to adapt to device pixel ratio.
  final double _scale;

  bool _imageLoaded = false;

  final int _charWidth;
  final int _charHeight;

  final String _imageAssetPath;

  final Map<malison.Color, ui.Paint> _fontPaintCache = {};

  late final List<malison.Glyph> _glyphBuffer;

  @override
  int get width => _display.width;

  @override
  int get height => _display.height;

  @override
  Vec get size => _display.size;

  /// Creates a new terminal using a built-in DOS-like font.
  factory RetroTerminal.dos(
    int width,
    int height,
  ) => RetroTerminal(
    width,
    height,
    'assets/fonts/dos.png',
    charWidth: 9,
    charHeight: 16,
  );

  /// Creates a new terminal using a short built-in DOS-like font.
  factory RetroTerminal.shortDos(
    int width,
    int height,
  ) => RetroTerminal(
    width,
    height,
    'assets/fonts/dos-short.png',
    charWidth: 9,
    charHeight: 13,
  );

  /// Creates a new terminal using a font image at [imageUrl].
  factory RetroTerminal(
    int width,
    int height,
    String imageAssetPath, {
    required int charWidth,
    required int charHeight,
    double? scale,
  }) {
    final display = malison.Display(width, height);
    return RetroTerminal._(
      display,
      charWidth,
      charHeight,
      imageAssetPath,
      scale ?? 1.0,
    );
  }

  RetroTerminal._(
    this._display,
    this._charWidth,
    this._charHeight,
    this._imageAssetPath,
    this._scale,
  ) {
    _loadFontImage();
    _glyphBuffer = List<malison.Glyph>.filled(
      _display.width * _display.height,
      const malison.Glyph.fromCharCode(malison.CharCode.space),
      growable: false,
    );
  }

  /// Call this from your Flutter `CustomPainter.paint` before invoking `render()`.
  void paintTo(ui.Canvas canvas) {
    _canvas = canvas;
    render();
  }

  @override
  void drawGlyph(int x, int y, malison.Glyph glyph) {
    _display.setGlyph(x, y, glyph);
    final int index = y * _display.width + x;
    if (index >= 0 && index < _glyphBuffer.length) {
      _glyphBuffer[index] = glyph;
    }
  }

  @override
  void render() {
    if (!_imageLoaded) return;
    if (_canvas == null) return;

    final canvas = _canvas!;
    final font = _font!;

    for (var y = 0; y < _display.height; y++) {
      for (var x = 0; x < _display.width; x++) {
        final malison.Glyph glyph = _glyphBuffer[y * _display.width + x];

        var char = glyph.char;
        char = unicodeMap[char] ?? char;

        final double dx = x * _charWidth * _scale;
        final double dy = y * _charHeight * _scale;
        final ui.Rect dst = ui.Rect.fromLTWH(
          dx,
          dy,
          _charWidth * _scale,
          _charHeight * _scale,
        );

        final ui.Paint backPaint = ui.Paint()..color = _toUiColor(glyph.back);
        canvas.drawRect(dst, backPaint);

        if (char == 0 || char == malison.CharCode.space) continue;

        final int sx = (char % 32) * _charWidth;
        final int sy = (char ~/ 32) * _charHeight;
        final ui.Rect src = ui.Rect.fromLTWH(
          sx.toDouble(),
          sy.toDouble(),
          _charWidth.toDouble(),
          _charHeight.toDouble(),
        );

        final ui.Paint forePaint = _getGlyphPaint(glyph.fore);
        canvas.drawImageRect(font, src, dst, forePaint);
      }
    }
  }

  @override
  Vec pixelToChar(Vec pixel) =>
      Vec(pixel.x ~/ _charWidth, pixel.y ~/ _charHeight);

  Future<void> _loadFontImage() async {
    final data = await rootBundle.load(_imageAssetPath);
    final bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    _font = frame.image;
    _imageLoaded = true;
  }

  ui.Paint _getGlyphPaint(malison.Color color) {
    final cached = _fontPaintCache[color];
    if (cached != null) return cached;

    final ui.Paint paint = ui.Paint()
      ..isAntiAlias = false
      ..filterQuality = ui.FilterQuality.none
      ..colorFilter = ui.ColorFilter.mode(
        _toUiColor(color),
        ui.BlendMode.srcIn,
      );
    _fontPaintCache[color] = paint;
    return paint;
  }

  static ui.Color _toUiColor(malison.Color color) =>
      ui.Color.fromARGB(0xFF, color.r, color.g, color.b);
}

// import 'dart:ui' as ui;
//
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:malison/malison.dart' as malison;
// import 'package:piecemeal/piecemeal.dart';
//
// import 'package:malison/src/unicode_map.dart';
//
// /// A [RenderableTerminal] that draws to a canvas using the old school DOS
// /// [code page 437][font] font.
// ///
// /// [font]: http://en.wikipedia.org/wiki/Code_page_437
// class RetroTerminal extends malison.RenderableTerminal {
//   final malison.Display _display;
//
//   ui.Canvas? _canvas;
//   ui.Image? _font;
//
//   /// The drawing scale, used to adapt to device pixel ratio.
//   final double _scale;
//
//   bool _imageLoaded = false;
//
//   final int _charWidth;
//   final int _charHeight;
//
//   final String _imageAssetPath;
//
//   final Map<malison.Color, ui.Paint> _fontPaintCache = {};
//
//   late final List<malison.Glyph> _glyphBuffer;
//
//   @override
//   int get width => _display.width;
//
//   @override
//   int get height => _display.height;
//
//   @override
//   Vec get size => _display.size;
//
//   /// Creates a new terminal using a built-in DOS-like font.
//   factory RetroTerminal.dos(
//     int width,
//     int height,
//   ) => RetroTerminal(
//     width,
//     height,
//     "assets/fonts/dos.png",
//     charWidth: 9,
//     charHeight: 16,
//   );
//
//   /// Creates a new terminal using a short built-in DOS-like font.
//   factory RetroTerminal.shortDos(
//     int width,
//     int height,
//   ) => RetroTerminal(
//     width,
//     height,
//     "assets/fonts/dos-short.png",
//     charWidth: 9,
//     charHeight: 13,
//   );
//
//   /// Creates a new terminal using a font image at [imageUrl].
//   factory RetroTerminal(
//     int width,
//     int height,
//     String imageAssetPath, {
//     required int charWidth,
//     required int charHeight,
//     double? scale,
//   }) {
//     final display = malison.Display(width, height);
//     return RetroTerminal._(
//       display,
//       charWidth,
//       charHeight,
//       imageAssetPath,
//       scale ?? 1.0,
//     );
//   }
//
//   RetroTerminal._(
//     this._display,
//     this._charWidth,
//     this._charHeight,
//     this._imageAssetPath,
//     this._scale,
//   ) {
//     _loadFontImage();
//     _glyphBuffer = List<malison.Glyph>.filled(
//       _display.width * _display.height,
//       const malison.Glyph.fromCharCode(malison.CharCode.space),
//       growable: false,
//     );
//   }
//
//   /// Call this from your Flutter `CustomPainter.paint` before invoking `render()`.
//   void paintTo(ui.Canvas canvas) {
//     _canvas = canvas;
//     render();
//   }
//
//   @override
//   void drawGlyph(int x, int y, malison.Glyph glyph) {
//     _display.setGlyph(x, y, glyph);
//     final int index = y * _display.width + x;
//     if (index >= 0 && index < _glyphBuffer.length) {
//       _glyphBuffer[index] = glyph;
//     }
//   }
//
//   @override
//   void render() {
//     if (!_imageLoaded) return;
//     if (_canvas == null) return;
//
//     final canvas = _canvas!;
//     final font = _font!;
//
//     for (var y = 0; y < _display.height; y++) {
//       for (var x = 0; x < _display.width; x++) {
//         final malison.Glyph glyph = _glyphBuffer[y * _display.width + x];
//
//         var char = glyph.char;
//         char = unicodeMap[char] ?? char;
//
//         final double dx = x * _charWidth * _scale;
//         final double dy = y * _charHeight * _scale;
//         final ui.Rect dst = ui.Rect.fromLTWH(
//           dx,
//           dy,
//           _charWidth * _scale,
//           _charHeight * _scale,
//         );
//
//         final ui.Paint backPaint = ui.Paint()..color = _toUiColor(glyph.back);
//         canvas.drawRect(dst, backPaint);
//
//         if (char == 0 || char == malison.CharCode.space) continue;
//
//         final int sx = (char % 32) * _charWidth;
//         final int sy = (char ~/ 32) * _charHeight;
//         final ui.Rect src = ui.Rect.fromLTWH(
//           sx.toDouble(),
//           sy.toDouble(),
//           _charWidth.toDouble(),
//           _charHeight.toDouble(),
//         );
//
//         final ui.Paint forePaint = _getGlyphPaint(glyph.fore);
//         canvas.drawImageRect(font, src, dst, forePaint);
//       }
//     }
//   }
//
//   @override
//   Vec pixelToChar(Vec pixel) =>
//       Vec(pixel.x ~/ _charWidth, pixel.y ~/ _charHeight);
//
//   Future<void> _loadFontImage() async {
//     final data = await rootBundle.load(_imageAssetPath);
//     final bytes = data.buffer.asUint8List();
//     final ui.Codec codec = await ui.instantiateImageCodec(bytes);
//     final ui.FrameInfo frame = await codec.getNextFrame();
//     _font = frame.image;
//     _imageLoaded = true;
//   }
//
//   ui.Paint _getGlyphPaint(malison.Color color) {
//     final cached = _fontPaintCache[color];
//     if (cached != null) return cached;
//
//     final ui.Paint paint = ui.Paint()
//       ..isAntiAlias = false
//       ..filterQuality = ui.FilterQuality.none
//       ..colorFilter = ui.ColorFilter.mode(
//         _toUiColor(color),
//         ui.BlendMode.srcIn,
//       );
//     _fontPaintCache[color] = paint;
//     return paint;
//   }
//
//   static ui.Color _toUiColor(malison.Color color) =>
//       ui.Color.fromARGB(0xFF, color.r, color.g, color.b);
// }
