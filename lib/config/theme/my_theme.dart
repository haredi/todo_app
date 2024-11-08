import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/my_text_styles.dart';

class MyTheme{
  static  ThemeData light=ThemeData(
    useMaterial3: false,
    primaryColor: ColorsManager.blueColor,
    dividerColor: ColorsManager.blueColor,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.blueColor,
    primary: ColorsManager.blueColor,
      onPrimary: ColorsManager.whiteColor,
      secondary: const Color(0xFF363636),
      onSecondary: ColorsManager.lightScaffoldBg,

    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle:  AppStyles.lightAppBarTextStyle
    ),
    scaffoldBackgroundColor: ColorsManager.lightScaffoldBg,
    bottomAppBarTheme: const BottomAppBarTheme(
    color: ColorsManager.whiteColor,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    cardTheme: const CardTheme(
      color: Colors.transparent,
elevation: 0,
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedIconTheme: IconThemeData(size: 38),
      unselectedIconTheme: IconThemeData(size: 33),
      selectedItemColor: ColorsManager.blueColor,
      backgroundColor: Colors.transparent,
      unselectedItemColor: ColorsManager.greyColor ,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(
          side: BorderSide(width: 3,color: Colors.white),
      ),
      backgroundColor: ColorsManager.blueColor,
      iconSize: 26,

    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      )
    ),

    textTheme: TextTheme(
      labelMedium: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w400,color: Color(0xFFA9A9A99C),),
      labelLarge:  GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xFF383838),),
      headlineLarge:  GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xFF5D9CEC),),
      titleMedium: AppStyles.cardTitleTextStyle,
      titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF363636)),
    ),


  );

  static  ThemeData dark=ThemeData(
    useMaterial3: false,
    primaryColor: ColorsManager.blueColor,
    dividerColor: ColorsManager.blueColor,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.blueColor,
    primary: ColorsManager.blueColor,
      onPrimary: Color(0xFF141922),
      secondary: Color(0xFFFFFFFF),
       onSecondary:  ColorsManager.darkScaffoldBg,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle:  AppStyles.darkAppBarTextStyle
    ),
    scaffoldBackgroundColor: ColorsManager.darkScaffoldBg,
    bottomAppBarTheme: const BottomAppBarTheme(
    color: ColorsManager.blackAccent,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    cardTheme: const CardTheme(
      color: ColorsManager.blackAccent,
elevation: 0,
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedIconTheme: IconThemeData(size: 38),
      unselectedIconTheme: IconThemeData(size: 33),
      selectedItemColor: ColorsManager.blueColor,
      backgroundColor: Colors.transparent,
      unselectedItemColor: ColorsManager.greyColor ,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(
          side: BorderSide(width: 3,color: ColorsManager.blackAccent),
      ),
      backgroundColor: ColorsManager.blueColor,
      iconSize: 26,

    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorsManager.blackAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      )
    ),

    textTheme: TextTheme(
      labelMedium: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w400,color: Color(0xFFCDCACAE8),),
      labelLarge:  GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xFFFFFFFF),),
      headlineLarge:  GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xFFFFFFFF),),
      titleMedium: AppStyles.cardTitleTextStyle,
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFFFFFFFF)),
    ),


  );
}