import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_game/hero_selection/hero_selection.dart';
import 'package:my_game/l10n/l10n.dart';
import 'package:my_game/loading/loading.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:statistics_repository/statistics_repository.dart';

class App extends StatelessWidget {
  const App(this.gameRepository, this.statisticsRepository, {super.key});
  final GameRepository gameRepository;
  final StatisticsRepository statisticsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PreloadCubit(
            Images(prefix: ''),
            AudioCache(prefix: ''),
          )..loadSequentially(),
        ),
        RepositoryProvider.value(value: gameRepository),
        RepositoryProvider.value(value: statisticsRepository),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: flutterNesTheme(brightness: Brightness.light),
        home: const LoadingPage(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider(
  //         create: (_) =>
  //             PreloadCubit(Images(prefix: ''), AudioCache(prefix: ''))
  //               ..loadSequentially(),
  //       ),
  //     ],
  //     child: const _old_AppView(),
  //   );
  // }
}

class _old_AppView extends StatelessWidget {
  const _old_AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2A48DF),
        appBarTheme: const AppBarTheme(color: Color(0xFF2A48DF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF2A48DF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFF2A48DF)),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoadingPage(),
    );
  }
}
