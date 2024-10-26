import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_manager.dart';
class AppStyles{
  static TextStyle? appBarTextStyle= const TextStyle(
     fontSize: 22,fontWeight: FontWeight.w700,color: ColorsManager.whiteColor
  );
  static TextStyle? cardTitleTextStyle= const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color(0xFF5D9CEC));
  static TextStyle? cardHourTextStyle= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF363636));
  static TextStyle? settingsItemLabelTextStyle= GoogleFonts.poppins(
    fontSize: 16,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF303030)
  );
  static TextStyle? bottomSheetTitleStyle= GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xFF383838));
  static TextStyle? hintTextStyle= GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w400,color: Color(0xFFA9A9A99C));
  static TextStyle? bottomSheetTextStyle= GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w400,color: Color(0xFF383838));

  //const TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.w700,
  //     color: Color(0xFF303030));


}