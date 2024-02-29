import 'package:hmi_core/src/core/text_file.dart';
///
class FakeTextFile implements TextFile {
  final String text;
  final Future<void>? writeFuture;
  const FakeTextFile(this.text, {this.writeFuture});
  //
  @override
  Future<String> get content => Future.value(text);
  //
  @override
  Future<void> write(String text) => writeFuture ?? Future(() {return;});
}