part of 'hero_selection_bloc.dart';

sealed class HeroSelectionState extends Equatable {
  const HeroSelectionState();

  @override
  List<Object> get props => [];
}

final class HeroSelectionInitial extends HeroSelectionState {}

final class LoadGameInprogress extends HeroSelectionState {}

final class LoadGameSuccess extends HeroSelectionState {
  const LoadGameSuccess(this.challenges);
  final DungeonChallenges challenges;

  @override
  List<Object> get props => [challenges];
}

final class LoadGameFailure extends HeroSelectionState {}
