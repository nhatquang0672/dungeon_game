// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/background.mp3
  String get background => 'assets/audio/background.mp3';

  /// File path: assets/audio/effect.mp3
  String get effect => 'assets/audio/effect.mp3';

  /// List of all assets
  List<String> get values => [background, effect];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/characters
  $AssetsImagesCharactersGen get characters =>
      const $AssetsImagesCharactersGen();

  /// Directory path: assets/images/modern_office
  $AssetsImagesModernOfficeGen get modernOffice =>
      const $AssetsImagesModernOfficeGen();

  /// File path: assets/images/unicorn_animation.png
  AssetGenImage get unicornAnimation =>
      const AssetGenImage('assets/images/unicorn_animation.png');

  /// List of all assets
  List<AssetGenImage> get values => [unicornAnimation];
}

class $AssetsLicensesGen {
  const $AssetsLicensesGen();

  /// Directory path: assets/licenses/poppins
  $AssetsLicensesPoppinsGen get poppins => const $AssetsLicensesPoppinsGen();
}

class $AssetsTilesGen {
  const $AssetsTilesGen();

  /// File path: assets/tiles/Digital Nightmare Escape Room.tiled-project
  String get digitalNightmareEscapeRoomTiledProject =>
      'assets/tiles/Digital Nightmare Escape Room.tiled-project';

  /// File path: assets/tiles/Digital Nightmare Escape Room.tiled-session
  String get digitalNightmareEscapeRoomTiledSession =>
      'assets/tiles/Digital Nightmare Escape Room.tiled-session';

  /// File path: assets/tiles/escape-room-01.tmx
  String get escapeRoom01 => 'assets/tiles/escape-room-01.tmx';

  /// File path: assets/tiles/escape-room-02.tmx
  String get escapeRoom02 => 'assets/tiles/escape-room-02.tmx';

  /// File path: assets/tiles/escape-room-03.tmx
  String get escapeRoom03 => 'assets/tiles/escape-room-03.tmx';

  /// File path: assets/tiles/escape-room-04.tmx
  String get escapeRoom04 => 'assets/tiles/escape-room-04.tmx';

  /// File path: assets/tiles/escape-room-05.tmx
  String get escapeRoom05 => 'assets/tiles/escape-room-05.tmx';

  /// File path: assets/tiles/escape-room-06.tmx
  String get escapeRoom06 => 'assets/tiles/escape-room-06.tmx';

  /// File path: assets/tiles/escape-room-07.tmx
  String get escapeRoom07 => 'assets/tiles/escape-room-07.tmx';

  /// File path: assets/tiles/escape-room-08.tmx
  String get escapeRoom08 => 'assets/tiles/escape-room-08.tmx';

  /// File path: assets/tiles/escape-room-09.tmx
  String get escapeRoom09 => 'assets/tiles/escape-room-09.tmx';

  /// File path: assets/tiles/escape-room-10.tmx
  String get escapeRoom10 => 'assets/tiles/escape-room-10.tmx';

  /// File path: assets/tiles/office_items.tsx
  String get officeItems => 'assets/tiles/office_items.tsx';

  /// File path: assets/tiles/room_builder.tsx
  String get roomBuilder => 'assets/tiles/room_builder.tsx';

  /// List of all assets
  List<String> get values => [
    digitalNightmareEscapeRoomTiledProject,
    digitalNightmareEscapeRoomTiledSession,
    escapeRoom01,
    escapeRoom02,
    escapeRoom03,
    escapeRoom04,
    escapeRoom05,
    escapeRoom06,
    escapeRoom07,
    escapeRoom08,
    escapeRoom09,
    escapeRoom10,
    officeItems,
    roomBuilder,
  ];
}

class $AssetsImagesCharactersGen {
  const $AssetsImagesCharactersGen();

  /// File path: assets/images/characters/conference_woman.png
  AssetGenImage get conferenceWoman =>
      const AssetGenImage('assets/images/characters/conference_woman.png');

  /// List of all assets
  List<AssetGenImage> get values => [conferenceWoman];
}

class $AssetsImagesModernOfficeGen {
  const $AssetsImagesModernOfficeGen();

  /// File path: assets/images/modern_office/office_items.png
  AssetGenImage get officeItems =>
      const AssetGenImage('assets/images/modern_office/office_items.png');

  /// File path: assets/images/modern_office/room_builder.png
  AssetGenImage get roomBuilder =>
      const AssetGenImage('assets/images/modern_office/room_builder.png');

  /// List of all assets
  List<AssetGenImage> get values => [officeItems, roomBuilder];
}

class $AssetsLicensesPoppinsGen {
  const $AssetsLicensesPoppinsGen();

  /// File path: assets/licenses/poppins/OFL.txt
  String get ofl => 'assets/licenses/poppins/OFL.txt';

  /// List of all assets
  List<String> get values => [ofl];
}

class Assets {
  const Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLicensesGen licenses = $AssetsLicensesGen();
  static const $AssetsTilesGen tiles = $AssetsTilesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
