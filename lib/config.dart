import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KColors {
  static Color kPrimaryColor = const Color(0xFF5A37E0);
  static Color kDarkColor = const Color(0xFF222F3E);
  static Color kLightColor = const Color(0xFFE5E5E5);
}

class KTextTheme {
  static TextTheme textTheme = TextTheme(
      headline1: TextStyle(
          fontFamily: GoogleFonts.libreBaskerville().fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade500),
      bodyText1: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: KColors.kDarkColor));
}

class InpBorder {
  static InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade400, width: .5));
}

class TextFieldTheme {
  static InputDecorationTheme textFieldTheme = InputDecorationTheme(
      suffixIconColor: KColors.kDarkColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      enabledBorder: InpBorder.inputBorder,
      focusedBorder: InpBorder.inputBorder,
      errorBorder: InpBorder.inputBorder
          .copyWith(borderSide: BorderSide(color: KColors.kPrimaryColor)));
}
