import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:todo_app/presentation/screens/home/edit_task/edit_task.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.todo, required this.onDeletedTask});
  Function onDeletedTask;
  TodoDM todo;
  GlobalKey<TasksTabState> taskTabKey = GlobalKey();

  @override
  State<TaskItem> createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .2,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // All actions are defined in the children parameter.
          children: [
            SlidableAction(
              flex: 1,
              autoClose: true,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                deleteTask();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: .2,

          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              autoClose: true,
              flex: 1,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                 editTask();
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 62,
                  width: 4,
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.todo.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      height: 12,
                    ),
                    Text(widget.todo.description,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18,fontWeight: FontWeight.w700)),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_clock,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          widget.todo.date.toFormattedHour,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16,fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorsManager.blueColor),
                  child: Icon(Icons.check_sharp,
                      size: 30, color: ColorsManager.whiteColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask() async {
    DialogUtils.showLoadingDialog(context, message: 'waiting...');
    var tasksCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.user!.id)
        .collection(TodoDM.collectionName);

    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(context,
        title: 'Delete task',
        content: 'Do you want to delete task?',
        posActionTitle: 'Ok', posAction: () async {
      await tasksCollection.doc(widget.todo.id).delete();
      widget.onDeletedTask();
    }, negActionTitle: 'No', negAction: () {});
  }

  Future<void> editTask() async {
    DialogUtils.showMessageDialog(
      context,
      content: 'Do you want to edit task',
      title: 'Edit Task',
      posActionTitle: 'Edit',
      posAction: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTask(
                todo: widget.todo,
              ),
            ));
        //widget.taskTabKey.currentState?.readTodosFromFireStore();
      },
      negActionTitle: 'No',
      negAction: () {},
    );
  }
}
