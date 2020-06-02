import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData getDarkTheme(TextTheme textTheme) {
    return ThemeData(
      textTheme: GoogleFonts.muliTextTheme(textTheme).copyWith(
        headline1: GoogleFonts.muli(color: CustomColors.grey),
        bodyText1: GoogleFonts.muli(color: CustomColors.white),
        bodyText2: GoogleFonts.muli(color: CustomColors.grey),
        subtitle1: GoogleFonts.muli(color: CustomColors.white),
        subtitle2: GoogleFonts.muli(color: CustomColors.white),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: CustomColors.white,
        contentTextStyle: GoogleFonts.muli(color: CustomColors.darkRed),
      ),
      primaryColor: CustomColors.grey,
      backgroundColor: CustomColors.black,
      accentColor: CustomColors.darkYellow,
      iconTheme: IconThemeData(color: CustomColors.darkYellow),
      errorColor: CustomColors.errorColor,
      hintColor: CustomColors.grey,
      cardColor: CustomColors.darkRed,
    );
  }
}
