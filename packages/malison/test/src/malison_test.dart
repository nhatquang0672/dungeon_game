// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:malison/malison.dart';
import 'package:test/test.dart';

void main() {
  group('Malison', () {
    test('can be instantiated', () {
      expect(Malison(), isNotNull);
    });
  });
}
