import 'package:flutter_test/flutter_test.dart';

import 'package:hmi_core/hmi_core.dart';

void main() {
  const debug = true;
  test('adds one to input values', () {
    const result = true;
    log(debug, 'result: $result');
    expect(result, true);
  });
}
