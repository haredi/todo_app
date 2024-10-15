import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/my_text_styles.dart';

class MyTheme{
  static  ThemeData lightThem=ThemeData(
    primaryColor: ColorsManager.blueColor,
    dividerColor: ColorsManager.blueColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 5,
      centerTitle: true,
      titleTextStyle:  MyTextStyles.appBarTextStyle
    ),
    scaffoldBackgroundColor: ColorsManager.scaffoldBgColor,
    bottomAppBarTheme: const BottomAppBarTheme(
    color: ColorsManager.whiteColor,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    cardTheme: CardTheme(
      color: ColorsManager.whiteColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

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

    )


  );
}