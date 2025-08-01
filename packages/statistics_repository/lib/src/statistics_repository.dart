import 'package:statistics_repository/src/statistics.dart';

/// {@template statistics_repository}
/// My new Dart package
/// {@endtemplate}
class StatisticsRepository {
  /// {@macro statistics_repository}
  StatisticsRepository();

  Statistics statistics = const Statistics();

  void recordHeroInformation(Hero hero) {
    statistics = statistics.copyWith(hero: hero);
  }

  void recordGameEvent(GameEvent event) {
    final allEvents = [...statistics.events, event];
    statistics = statistics.copyWith(events: allEvents);
  }

  void resetStatistics() {
    statistics = const Statistics();
  }
}
