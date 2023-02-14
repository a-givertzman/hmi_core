import 'package:hmi_core/src/core/text_file.dart';
///
class FakeTextFile implements TextFile {
  final String text;
  const FakeTextFile(this.text);
  @override
  Future<String> get content => Future.value(text);
}