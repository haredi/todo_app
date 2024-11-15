import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';


class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todosList = [];
  //GlobalKey<TaskItemState> taskItemKey=GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTodosFromFireStore();// function gets tasks from firestore
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 22,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Container(
                    color: ColorsManager.blueColor,
                  )),
                  Expanded(
                      child: Container(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ))
                ],
              ),
              buildCalender(),
            ],
          ),
        ),
        Expanded(
          flex: 78,
          child: ListView.builder(
            itemBuilder: (context, index) => TaskItem(
              todo: todosList[index],
              onDeletedTask: readTodosFromFireStore),
            itemCount: todosList.length,
          ),
        ),
      ],
    );
  }

  void readTodosFromFireStore() async {
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName).doc(UserDM.user!.id).collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map(
      (docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDM todo = TodoDM.fromJson(json);
        return todo;
      },
    ).toList();
    todosList = todosList
        .where(
          (todo) =>
              todo.date.day == calenderSelectedDate.day &&
              todo.date.month == calenderSelectedDate.month &&
              todo.date.year == calenderSelectedDate.year,
        )
        .toList();
     setState(() {});
  }

  Widget buildCalender() {
    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      focusDate: calenderSelectedDate,
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
      },

      itemBuilder: (context, date, isSelected, onTap) =>
          InkWell(
        onTap: () {
          calenderSelectedDate = date;
          readTodosFromFireStore(); //it gets tasks based on calender selected date.
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Theme.of(context).colorScheme.onPrimary,
          elevation: 12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.getDayName,
                style: TextStyle(
                    color: isSelected
                        ? ColorsManager.blueColor
                        : Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '${date.day}',
                style: TextStyle(
                    color: isSelected
                        ? ColorsManager.blueColor
                        : Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),





    );

  }

}
