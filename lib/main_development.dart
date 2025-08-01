import 'package:game_repository/game_repository.dart';
import 'package:my_game/app/app.dart';
import 'package:my_game/bootstrap.dart';
import 'package:statistics_repository/statistics_repository.dart';

void main() {
  final gameRepository = GameRepository();
  final statisticsRepository = StatisticsRepository();
  bootstrap(() => App(gameRepository, statisticsRepository));
}
