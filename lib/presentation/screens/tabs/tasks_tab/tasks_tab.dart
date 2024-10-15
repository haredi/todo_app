import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          headerProps: const EasyHeaderProps(
            padding: EdgeInsets.symmetric(horizontal: 8,),
            monthPickerType: MonthPickerType.dropDown,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            height: 80,
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
                dayStrStyle: TextStyle(color: ColorsManager.blueColor,fontSize: 18,fontWeight: FontWeight.w600),

              dayNumStyle: TextStyle(color: ColorsManager.blueColor,fontSize: 18,fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
             color: Colors.white

              ),
            ),
            inactiveDayStyle:DayStyle(
              dayStrStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),

              dayNumStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white

              ),
            ),
          ),
        ),
          TaskItem(),
      ],),
    );
  }
}
