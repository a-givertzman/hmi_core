import 'package:hmi_core/src/core/string_loader.dart';
///
class FakeTextFile implements StringLoader {
  final String text;
  const FakeTextFile(this.text);
  @override
  Future<String> load() => Future.value(text);
}