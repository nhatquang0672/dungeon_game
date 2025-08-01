import 'package:equatable/equatable.dart';

class Puzzle extends Equatable {
  const Puzzle({
    required this.question,
    required this.answer,
    required this.hint,
    required this.options,
  });

  final String question;
  final String answer;
  final String hint;
  final List<String> options;

  @override
  List<Object?> get props => [question, answer, hint, options];
}
