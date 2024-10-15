import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';

class RoutesManager{
  static const String homeRoute='/';



  static Route<dynamic>? route(RouteSettings settings){
    switch(settings.name){
      case homeRoute:{
        return MaterialPageRoute(builder: (context) => HomeScreen(),);
      }
    }
  }
}