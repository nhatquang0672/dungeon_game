// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:statistics_repository/statistics_repository.dart';
import 'package:test/test.dart';

void main() {
  group('StatisticsRepository', () {
    test('can be instantiated', () {
      expect(StatisticsRepository(), isNotNull);
    });
  });
}
