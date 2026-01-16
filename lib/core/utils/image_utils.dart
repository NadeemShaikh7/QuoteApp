import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<File> captureWidget(GlobalKey key) async {
    final boundary =
    key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image =
    await boundary.toImage(pixelRatio: 3.0);

    final byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);

    final bytes = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/quote_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    await file.writeAsBytes(bytes);
    return file;
  }
}
