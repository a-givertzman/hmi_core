import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/ds_point_name.dart';
import 'full_paths_data.dart';

void main() {
  test('DsPointName toString returns full path', () { 
    for(final data in fullPathsData) {
      final fullPath = '${data['path']}/${data['name']}';
      final pointName = DsPointName(fullPath: fullPath);
      expect(pointName.toString(), fullPath);
    }
  });
}