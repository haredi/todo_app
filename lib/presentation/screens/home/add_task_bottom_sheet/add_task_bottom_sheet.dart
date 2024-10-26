import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/my_text_styles.dart';

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Text('Add new task',style: AppStyles.bottomSheetTitleStyle,textAlign: TextAlign.center,),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter task title',
                hintStyle: AppStyles.hintTextStyle,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter task description',
                hintStyle:AppStyles.hintTextStyle ,
              ),
            ),
            Text('Selected Date',style: AppStyles.bottomSheetTextStyle,),
            Text('26/10/2024',style: AppStyles.hintTextStyle,textAlign: TextAlign.center,),
            ElevatedButton(onPressed: () {

            }, child: Text('Add task'))
      ],),
    );
  }

  static void show(BuildContext context){
    showModalBottomSheet(
      context: context, builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
        child: AddTaskBottomSheet(),
      ),);
  }
}
