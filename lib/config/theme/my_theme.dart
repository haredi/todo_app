import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/my_text_styles.dart';

class MyTheme{
  static  ThemeData lightThem=ThemeData(
    useMaterial3: false,
    primaryColor: ColorsManager.blueColor,
    dividerColor: ColorsManager.blueColor,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.blueColor,
    primary: ColorsManager.blueColor,
      onPrimary: ColorsManager.whiteColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 5,
      centerTitle: true,
      titleTextStyle:  AppStyles.appBarTextStyle
    ),
    scaffoldBackgroundColor: ColorsManager.scaffoldBgColor,
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
      titleMedium: AppStyles.cardTitleTextStyle,
      titleSmall: AppStyles.cardHourTextStyle,
      labelSmall: AppStyles.settingsItemLabelTextStyle,
    ),


  );
}