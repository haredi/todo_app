import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).dividerColor,
              height: 62,
              width: 4,
            ),
            SizedBox(width: 25,),
            Column(
              children: [
                Text(
                  'Tassk Title',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5D9CEC)),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.lock_clock),
                    Text(
                      '10:30',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF363636)),
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3,horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsManager.blueColor
                ),
                child: Icon(Icons.check_sharp,size: 30,color: ColorsManager.whiteColor),)
          ],
        ),
      ),
    );
  }
}
