import 'package:hmi_core/src/core/result_new/result.dart';
import 'package:hmi_core/src/core/text_file.dart';
///
class FakeTextFile implements TextFile {
  final String text;
  final Future<void>? writeFuture;
  const FakeTextFile(this.text, {this.writeFuture});
  //
  @override
  Future<ResultF<String>> get content => Future.value(Ok(text));
  //
  @override
  Future<void> write(String text) => writeFuture ?? Future(() {return;});
}