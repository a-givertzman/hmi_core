import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';
import 'full_paths_data.dart';

void main() {
  test('DsPointName correctly splits valid fullpath', () { 
    for(final data in fullPathsData) {
      final path = data['path'];
      final name = data['name'];
      final fullPath = '$path$name';
      final pointName = DsPointName(fullPath);
      expect(pointName.path, path, reason: 'DsPointName returns incorrect path');
      expect(pointName.name, name, reason: 'DsPointName returns incorrect name of full path');
    }
  });
  test('DsPointName correctly splits invalid fullpath', () { 
    for(final data in fullPathsWrongData) {
      final path = data['path'];
      final name = data['name'];
      final fullPath = '$path$name';
      expect(() => DsPointName(fullPath), throwsA(isA<Failure>()), reason: 'Full path format is incorrect');
    }
  });
}