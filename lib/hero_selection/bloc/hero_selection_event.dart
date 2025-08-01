part of 'hero_selection_bloc.dart';

sealed class HeroSelectionEvent extends Equatable {
  const HeroSelectionEvent();

  @override
  List<Object> get props => [];
}

final class EnterDungeonPressed extends HeroSelectionEvent {
  EnterDungeonPressed({
    required this.name,
    required this.race,
    required this.heroClass,
  });

  final String name;
  final String race;
  final String heroClass;
}
