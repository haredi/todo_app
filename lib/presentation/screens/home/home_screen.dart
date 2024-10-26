import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List<Widget> tabs=[
  TasksTab(),
  SettingsTab(),
];

int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
extendBody: true,
      appBar: AppBar(
        title:const Text('To Do List'),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
AddTaskBottomSheet.show(context);      },
      child:const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked   ,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex=index;
              setState(() {
        
              });
            },
        
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.list,),label: 'Tasks',),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
        ]),
      ),

      body: tabs[selectedIndex] ,
    );
  }
}
