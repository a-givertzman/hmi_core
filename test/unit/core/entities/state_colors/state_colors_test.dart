import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmi_core/hmi_core.dart';

void main() {
  test('StateColors test', () {
    final colors = {
      'error': Color(0xAA000001),
      'obsolete': Color(0xAA000002),
      'invalid': Color(0xAA000003),
      'timeInvalid': Color(0xAA000004),
      'lowLevel': Color(0xAA000005),
      'alarmLowLevel': Color(0xAA000006),
      'highLevel': Color(0xAA000007),
      'alarmHighLevel': Color(0xAA000008),
      'off': Color(0xAA000009),
      'on': Color(0xAA0000010),
    };
    final stateColors = StateColors(
      error: colors['error']!,
      obsolete: colors['obsolete']!,
      invalid: colors['invalid']!,
      timeInvalid: colors['timeInvalid']!,
      lowLevel: colors['lowLevel']!,
      alarmLowLevel: colors['alarmLowLevel']!,
      highLevel: colors['highLevel']!,
      alarmHighLevel: colors['alarmHighLevel']!,
      off: colors['off']!,
      on: colors['on']!,
    );
    expect(stateColors, isA<StateColors>());
    expect(stateColors.error, colors['error']!);
    expect(stateColors.obsolete, colors['obsolete']!);
    expect(stateColors.invalid, colors['invalid']!);
    expect(stateColors.timeInvalid, colors['timeInvalid']!);
    expect(stateColors.lowLevel, colors['lowLevel']!);
    expect(stateColors.alarmLowLevel, colors['alarmLowLevel']!);
    expect(stateColors.highLevel, colors['highLevel']!);
    expect(stateColors.alarmHighLevel, colors['alarmHighLevel']!);
    expect(stateColors.off, colors['off']!);
    expect(stateColors.on, colors['on']!);
  });
}