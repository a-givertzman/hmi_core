import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/src/core/entities/ds_point_name.dart';
import 'full_paths_data.dart';
import 'package:hmi_core/hmi_core_log.dart';


void main() {
  test('DsPointName toString returns full path', () { 
    Log.initialize(level: LogLevel.all);
    const log = Log('UserPassword');
    for(final data in fullPathsData) {
      final fullPath = '${data['path']}${data['name']}';
      final pointName = DsPointName(fullPath);
      log.debug('fullPath: $fullPath');
      log.debug('pointName: $pointName');
      log.debug('pointName.path: ${pointName.path}');
      log.debug('pointName.name: ${pointName.name}');
      expect(pointName.toString(), fullPath);
    }
  });
}