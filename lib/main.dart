import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    runApp(MyApp());

}
