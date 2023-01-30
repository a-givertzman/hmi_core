import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/ds_point_name.dart';

import 'full_paths_data.dart';

void main() {
  test('DsPointName comparation', () { 
    for(final data in fullPathsData) {
      final fullPath = '${data['path']}/${data['name']}';
      expect(DsPointName(fullPath: fullPath) == DsPointName(fullPath: fullPath), true);
    }
    final fullPath0 = '${fullPathsData[0]['path']}/${fullPathsData[0]['name']}';
    final fullPath1 = '${fullPathsData[1]['path']}/${fullPathsData[1]['name']}';
    expect(DsPointName(fullPath: fullPath0) == DsPointName(fullPath: fullPath1), false);
  });
}