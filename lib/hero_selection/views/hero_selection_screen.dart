import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:my_game/game/view/game_page.dart';
import 'package:my_game/hero_creation/hero_creation.dart';
import 'package:my_game/hero_selection/bloc/hero_selection_bloc.dart';
import 'package:my_game/l10n/l10n.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:statistics_repository/statistics_repository.dart';

class HeroSelectionScreen extends StatelessWidget {
  const HeroSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeroSelectionBloc(
        context.read<GameRepository>(),
        context.read<StatisticsRepository>(),
      ),
      child: _HeroSelectionScreen(),
    );
  }
}

class _HeroSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<HeroSelectionBloc, HeroSelectionState>(
          builder: (context, state) {
            return switch (state) {
              HeroSelectionInitial() => HeroCreationScreen(),
              LoadGameInprogress() => _LoadingGame(),
              LoadGameSuccess() => _LoadingGame(),
              LoadGameFailure() => HeroCreationScreen(),
            };
          },
          listener: (context, state) {
            if (state is LoadGameSuccess) {
              print('co vao day ko ');

              Navigator.of(
                context,
              ).push(GamePage.route());
            }
          },
        ),
      ),
    );
  }
}

class _LoadingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: NesContainer(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NesHourglassLoadingIndicator(),
            const SizedBox(height: 25),
            Text(
              context.l10n.createCustomGame,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
