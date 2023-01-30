import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/ds_point_name.dart';

import 'full_paths_data.dart';

void main() {
  test('DsPointName correctly splits fullpath', () { 
    for(final data in fullPathsData) {
      final path = data['path'];
      final name = data['name'];
      final fullPath = '$path$name';
      final pointName = DsPointName(fullPath: fullPath);
      expect(pointName.path, path);
      expect(pointName.name, name);
    }
  });
}