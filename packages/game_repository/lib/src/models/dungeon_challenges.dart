import 'package:equatable/equatable.dart';
import 'package:game_repository/src/models/puzzle.dart';

class DungeonChallenges extends Equatable {
  const DungeonChallenges({
    required this.firstPuzzle,
    required this.secondPuzzle,
    required this.thirdPuzzle,
  });

  final Puzzle firstPuzzle;
  final Puzzle secondPuzzle;
  final Puzzle thirdPuzzle;

  @override
  // TODO: implement props
  List<Object?> get props => [firstPuzzle, secondPuzzle, thirdPuzzle];

  static const mockChallenges = DungeonChallenges(
    firstPuzzle: Puzzle(
      question: 'How many bits are in a byte?',
      answer: '8',
      hint: 'It is an even number.',
      options: ['1', '2', '3', '4', '5', '6', '7', '8'],
    ),
    secondPuzzle: Puzzle(
      question: 'What programming language powers Flutter?',
      answer: 'Dart',
      hint: 'It was created by Google.',
      options: ['Java', 'Swift', 'Dart', 'Kotlin', 'Go', 'Rust', 'C#', 'HTML'],
    ),
    thirdPuzzle: Puzzle(
      question: 'Where is Google Cloud Next taking place in 2024?',
      answer: 'Las Vegas',
      hint: 'City located in the US.',
      options: [
        'Seattle',
        'San Francisco',
        'Rome',
        'Tokyo',
        'Madrid',
        'Las Vegas',
        'Chicago',
        'Sidney',
      ],
    ),
  );
}
