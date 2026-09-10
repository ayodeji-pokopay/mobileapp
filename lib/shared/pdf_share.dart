import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Writes [bytes] to a temp file and opens the OS share sheet.
Future<void> sharePdf(Uint8List bytes, {required String fileName}) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  await SharePlus.instance.share(
    ShareParams(files: [XFile(file.path, mimeType: 'application/pdf')]),
  );
}

Future<void> shareText(String text) =>
    SharePlus.instance.share(ShareParams(text: text));
