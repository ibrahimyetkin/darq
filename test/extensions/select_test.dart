import 'package:darq/darq.dart';
import 'package:test/test.dart';

void main() {
  group('select', () {
    test('Basic mapping', () {
      final list = ['a', 'b', 'c', 'd', 'e'];
      final result = list.select((c, i) => c.codeUnits[0]);
      expect(result, orderedEquals([97, 98, 99, 100, 101]));
    });

    test('Mapping using index', () {
      final list = ['a', 'b', 'c', 'd', 'e'];
      final result = list.select((c, i) => '${i}_${c.codeUnits[0]}');
      expect(result, orderedEquals(['0_97', '1_98', '2_99', '3_100', '4_101']));
    });

    test('Error: null selector', () {
      final list = ['a', 'b', 'c', 'd', 'e'];
      final task = () => list.select(null);
      expect(task, throwsA(isA<ArgumentError>()));
    });
  });
}
