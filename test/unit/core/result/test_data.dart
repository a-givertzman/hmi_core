final class ForTestOptionOnly {
  final String value;
  const ForTestOptionOnly(this.value);
}
const _maxInt64 =  0x7FFFFFFFFFFFFFFF;
const _minInt64 = -0x8000000000000000;
const testData = [
  _maxInt64,
  _minInt64,
  0,
  353465,
  45,
  -3456,
  ForTestOptionOnly('value'),
  ForTestOptionOnly(''),
  ForTestOptionOnly('123'),
  true,
  false,
  double.maxFinite,
  double.minPositive
  -double.maxFinite,
  0.0,
  1.234,
  234.4,
  -0.45676,
  -346.786,
];