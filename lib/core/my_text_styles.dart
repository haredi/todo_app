import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_manager.dart';
class AppStyles{
  static TextStyle? lightAppBarTextStyle= const TextStyle(
     fontSize: 22,fontWeight: FontWeight.w700,color: ColorsManager.whiteColor
  );
  static TextStyle? darkAppBarTextStyle= const TextStyle(
     fontSize: 22,fontWeight: FontWeight.w700,color: ColorsManager.darkScaffoldBg
  );
  static TextStyle? cardTitleTextStyle= const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color(0xFF5D9CEC));
  static TextStyle? cardHourTextStyle= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF363636));
  static TextStyle? settingsItemLabelTextStyle= GoogleFonts.inter(
    fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF5D9CEC)
  );


}