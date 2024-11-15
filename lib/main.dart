import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/lang_provider.dart';
import 'package:todo_app/provider/theme_provider.dart';

import 'my_app/my_app.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options:const FirebaseOptions(apiKey: 'AIzaSyA7WZByZZ6gy0KbgcGNNePwB3cc1cibiqE',
          appId: 'com.example.todo_app',
          messagingSenderId: '',
          projectId: 'todo-app-d0668'
      )
    );
    //await FirebaseFirestore.instance.disableNetwork();
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()..getTheme(),),
          ChangeNotifierProvider(create: (context) => LangProvider()..getLang(),),

        ],
        child: MyApp()));

}
