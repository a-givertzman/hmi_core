import 'package:hmi_core/src/core/result/result.dart';
import 'package:hmi_core/src/core/text_file.dart';
///
class FakeTextFile implements TextFile {
  String text;
  final Future<void> Function(String value)? writeFuture;
  FakeTextFile(this.text, {this.writeFuture});
  //
  @override
  Future<ResultF<String>> get content => Future.value(Ok(text));
  //
  @override
  Future<void> write(String text) async {
    await writeFuture?.call(text);
    this.text = text;
  }
}
