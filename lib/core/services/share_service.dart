import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ShareService {
  // -----------------------------
  // Share as TEXT
  // -----------------------------
  static Future<void> shareText({
    required String quote,
    required String author,
  }) async {
    await Share.share(
      '"$quote"\n\n— $author',
    );
  }

  // -----------------------------
  // Share IMAGE
  // -----------------------------
  static Future<void> shareImage(File file) async {
    await Share.shareXFiles([XFile(file.path)]);
  }
}
