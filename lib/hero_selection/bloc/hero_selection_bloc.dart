import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:statistics_repository/statistics_repository.dart';

part 'hero_selection_event.dart';
part 'hero_selection_state.dart';

class HeroSelectionBloc extends Bloc<HeroSelectionEvent, HeroSelectionState> {
  HeroSelectionBloc(this._gameRepository, this._statisticsRepository)
    : super(HeroSelectionInitial()) {
    on<EnterDungeonPressed>(_onEnterDungeonPressed);
  }
  final GameRepository _gameRepository;
  final StatisticsRepository _statisticsRepository;

  FutureOr<void> _onEnterDungeonPressed(
    EnterDungeonPressed event,
    Emitter<HeroSelectionState> emit,
  ) async {
    emit(LoadGameInprogress());
    try {
      final challenges = await _gameRepository.loadChallenges();
      _statisticsRepository.recordHeroInformation(
        Hero(name: event.name, race: event.race, heroClass: event.heroClass),
      );
      emit(LoadGameSuccess(challenges));
    } catch (_) {
      emit(LoadGameFailure());
    }
  }
}
