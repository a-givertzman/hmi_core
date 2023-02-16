import 'value_object.dart';
import 'value_validation.dart';

class ValueString extends ValueObject<String> {
  final List<ValueValidation>? _validationList;
  const ValueString(
    String value,
    {List<ValueValidation>? validationList,}
  ):
    _validationList = validationList,
    super(value);
  //
  @override
  String toString() {
    return super.value;
  }
  ///
  bool isEmpty() {
    return super.value.isEmpty;
  }
  ///
  bool isNotEmpty() {
    return super.value.isNotEmpty;
  }
  ///
  String valid() {
    final vList = _validationList;
    if (vList == null) {
      return '';
    }
    return vList.map(
      (validation) => validation.validate(value),
    ).join('; ') ;
  }
  //
  @override
  ValueObject<String> toDomain(String value) {
    return ValueString(value);
  }
}
