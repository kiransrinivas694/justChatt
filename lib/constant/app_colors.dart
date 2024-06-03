import 'package:flutter/material.dart';

class AppColorConstant {
  static const Color black = Color(0xFF000000);
  static const Color black1 = Color(0xFF212121);
  static const Color black2 = Color(0xFF0C0C0C);
  static const Color black3 = Color(0xFF1f1f1f);
  static const Color blue2 = Color(0xFF615EF0);
  static const Color blue1 = Color(0xFF2F80ED);
  static const Color appWhite = Color(0xFFFFFFFF);
  static const Color appWhite2 = Color(0xFFFFFDFD);
  static const Color appBlack = Color(0xFF000000);
  static const Color grey1 = Color(0xFFBDBDBD);
  static const Color red = Color(0xFFEB5757);

  static Color hex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
