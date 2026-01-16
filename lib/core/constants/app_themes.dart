import 'package:flutter/material.dart';

ThemeData buildTheme({
  required bool isDark,
  required Color accent,
  required double fontScale,
}) {
  final base = isDark ? ThemeData.dark() : ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: accent,
    ),
    textTheme: base.textTheme.apply(
      fontSizeFactor: fontScale,
    ),
  );
}
