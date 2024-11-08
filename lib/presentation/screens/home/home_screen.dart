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

  GlobalKey<TasksTabState> tasksTabKey=GlobalKey();
  List<Widget> tabs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(key: tasksTabKey,),
      SettingsTab(),
    ];
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Text(selectedIndex == 1 ? 'Settings' : 'To Do List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await AddTaskBottomSheet.show(context);
          tasksTabKey.currentState?.readTodosFromFireStore();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items:const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ]),
      ),
      body: tabs[selectedIndex],
    );
  }
}
