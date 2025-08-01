// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:game_repository/game_repository.dart';
import 'package:test/test.dart';

void main() {
  group('GameRepository', () {
    test('can be instantiated', () {
      expect(GameRepository(), isNotNull);
    });
  });
}
