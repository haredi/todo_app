import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/colors_manager.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin:const EdgeInsets.symmetric(vertical: 12,horizontal: 8),

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
              onPressed: (context) {},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
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
              onPressed: (context) {},
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
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
                  children: [
                    Text('Task Title',
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.lock_clock),
                        Text(
                          '10:30',
                          style: Theme.of(context).textTheme.titleSmall,
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
}
