
import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color Gray53 = fromHex("#878787");
  static Color HColor = fromHex("#B5B5B5");
  static Color lightOrange = fromHex("#FD7836");
  static Color buttonColor = fromHex("#FFDC3D");
  static Color circuleColor = fromHex("#FFF9E8");
  static Color greenCyan = fromHex("#34BFA3");
  static Color lavender = fromHex("#8677FE");
  static Color carnation = fromHex("#F4516C");
  static Color yellow = fromHex("#FFB800");
  static Color orange = fromHex("#FCAF19");
  static Color Gray71 = fromHex("#b5b5b5");
  static Color aliceblue = fromHex("#194BFC");
  static Color grren = fromHex("#00B929");
  static Color lightGray = fromHex("#E3E3E3");

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
