import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/hero_creation/bloc/hero_creation_bloc.dart';
import 'package:my_game/hero_selection/bloc/hero_selection_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class HeroCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HeroCreationBloc(),
      child: _HeroCreationScreen(),
    );
  }
}

class _HeroCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NesButton(
      type: NesButtonType.success,
      child: Text('Enter Dungeon'),
      onPressed: () {
        context.read<HeroSelectionBloc>().add(
          EnterDungeonPressed(name: 'quang', race: 'human', heroClass: 'mage'),
        );
      },
    );
  }
}
