import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class UItheme {
  static const Color primaryColor = Color(0xFF3474E0);
  static const Color secondaryColor = Color(0xFFEE8B60);
  static const Color tertiaryColor = Color(0xFFFFFFFF);

  static const Color richBlackFOGRA29 = Color(0xFF001219);
  static const Color blueSapphire = Color(0xFF005F73);
  static const Color viridianGreen = Color(0xFF0A9396);
  static const Color middleBlueGreen = Color(0xFF94D2BD);
  static const Color mediumChampagne = Color(0xFFE9D8A6);
  static const Color gamboge = Color(0xFFEE9B00);
  static const Color alloyOrange = Color(0xFFCA6702);
  static const Color mahogany = Color(0xFFBB3E03);
  static const Color rufous = Color(0xFFAE2012);
  static const Color rubyRed = Color(0xFF9B2226);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';

  static TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: const Color(0xFF303030),
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: const Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: const Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: const Color(0xFF757575),
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: const Color(0xFF616161),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: const Color(0xFF303030),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: const Color(0xFF424242),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {required String fontFamily,
          required Color color,
          required double fontSize,
          required FontWeight fontWeight,
          required FontStyle fontStyle}) =>
      GoogleFonts.getFont(
        fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
}
