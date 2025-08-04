import 'package:game_repository/src/models/dungeon_challenges.dart';

/// {@template game_repository}
/// Game repository
/// {@endtemplate}
class GameRepository {
  /// {@macro game_repository}
  const GameRepository();
  Future<DungeonChallenges> loadChallenges() async {
    await Future.delayed(const Duration(seconds: 2));
    return DungeonChallenges.mockChallenges;
  }

  // EscapeRoomChallenges _validateThatPuzzleOptionsContainAnswer(
  //   EscapeRoomChallenges challenges,
  // ) {
  //   return EscapeRoomChallenges(
  //     firstPuzzle: _validatePuzzle(challenges.firstPuzzle),
  //     secondPuzzle: _validatePuzzle(challenges.secondPuzzle),
  //     thirdPuzzle: _validatePuzzle(challenges.thirdPuzzle),
  //   );
  // }
  //
  // Puzzle _validatePuzzle(Puzzle puzzle) {
  //   if (puzzle.options.contains(puzzle.answer)) {
  //     return puzzle;
  //   } else {
  //     puzzle.options
  //       ..add(puzzle.answer)
  //       ..shuffle();
  //     return puzzle;
  //   }
  // }
}
