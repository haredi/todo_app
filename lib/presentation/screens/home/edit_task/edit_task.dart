import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/date_utils.dart';

import '../../../../core/colors_manager.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../database_manager/model/todo_dm.dart';
import '../../../../database_manager/model/user_dm.dart';

class EditTask extends StatefulWidget {
  TodoDM? todo;
  EditTask({super.key, this.todo});

  @override
  State<EditTask> createState() => EditTaskState();
}

class EditTaskState extends State<EditTask> {
  DateTime userSelectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
      userSelectedDate = widget.todo!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          'To Do List',
        ),
        centerTitle: false,
      ),
      body: Stack(
        alignment: Alignment(0, -1),
        children: [
          Column(
            children: [
              Expanded(
                  flex: 10,
                  child: Container(
                    color: ColorsManager.blueColor,
                  )),
              Expanded(
                  flex: 90,
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ))
            ],
          ),
          Container(
            margin: EdgeInsets.all(15),
            color: Theme.of(context).colorScheme.onPrimary,
            height: MediaQuery.of(context).size.height * 0.55,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Edit Task',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'please, Enter Title';
                      }
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter task title',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'please, Enter Description';
                      }
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter task description',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Selected Date',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                      onTap: () {
                        showTaskDatePicker();
                      },
                      child: Text(
                        userSelectedDate.toFormattedDate,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 14),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    height: 150,
                  ),
                  ElevatedButton(
                      onPressed: ()  {
                         editTodoInFireStore();
                      },
                      child: Text(
                        'Save Changes',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: ColorsManager.whiteColor),
                      )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showTaskDatePicker() async {
    userSelectedDate = await showDatePicker(
            context: context,
            barrierDismissible: false,
            selectableDayPredicate: (day) => day.day != 30,
            confirmText: 'Done',
            cancelText: 'unSelect',
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        userSelectedDate;
    setState(() {});
  }

  Future<void> editTodoInFireStore() async {
    if (formKey.currentState?.validate() == false) return;
    DialogUtils.showLoadingDialog(context, message: 'Loading...');

    try {
      CollectionReference todoCollection = FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(UserDM.user!.id)
          .collection(TodoDM.collectionName);

      DocumentReference doc = todoCollection.doc(widget.todo!.id);

      await doc.update({
        "title": titleController.text,
        "description": descriptionController.text,
        "date": userSelectedDate
      });

      if (mounted) {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessageDialog(
          context,
          content: 'Done editing',
          posAction: () {
            Navigator.pop(context);
          },
          posActionTitle: 'Ok',
        );
      }
    } catch (error) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        content: 'Failed: ${error.toString()}',
        posActionTitle: 'Ok',
      );
    }

  }


}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_app/core/colors_manager.dart';
// import 'package:todo_app/core/utils/date_utils.dart';
// import 'package:todo_app/database_manager/model/todo_dm.dart';
// import 'package:todo_app/database_manager/model/user_dm.dart';
// import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
//
// import '../../../../core/utils/dialog_utils.dart';

// class EditTask extends StatefulWidget {
//
//   String taskId;
//   String title;
//   String description;
//   DateTime date;
//    EditTask({super.key,required this.title,required this.description, required this.date, required this.taskId});
//   @override
//   State<EditTask> createState() => EditTaskState();
//
//   static Future show(BuildContext context,
//       String taskId,
//       String newTitle,
//       String newDescription,
//       DateTime newDate,
//       ) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) => Padding(
//         padding: MediaQuery.of(context).viewInsets,
//         child: EditTask(title: newTitle,description: newDescription,date: newDate,taskId: taskId,),
//       ),
//     );
//   }
// }
//
// class EditTaskState extends State<EditTask> {
//   DateTime userSelectedDate = DateTime.now();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   GlobalKey<TasksTabState> tabKey = GlobalKey<TasksTabState>();
//   bool isSaving=false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     titleController.text= widget.title;
//     descriptionController.text= widget.description;
//     userSelectedDate= widget.date;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.55,
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//       child: Form(
//         key: formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Edit task',
//               style: Theme.of(context).textTheme.headlineLarge,
//               textAlign: TextAlign.center,
//             ),
//             TextFormField(
//               validator: (input) {
//                 if (input == null || input.trim().isEmpty) {
//                   return 'please, Enter Editing Title';
//                 }
//               },
//               controller: titleController,
//               decoration: InputDecoration(
//                 hintText: 'Edit task title',
//                 hintStyle: Theme.of(context).textTheme.labelMedium,
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             TextFormField(
//               validator: (input) {
//                 if (input == null || input.trim().isEmpty) {
//                   return 'please, Enter Description';
//                 }
//               },
//               controller: descriptionController,
//               decoration: InputDecoration(
//                 hintText: 'Edit task description',
//                 hintStyle: Theme.of(context).textTheme.labelMedium,
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             Text(
//               'Selected Date',
//               style: Theme.of(context).textTheme.labelLarge,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             InkWell(
//                 onTap: () {
//                   showTaskDatePicker();
//                 },
//                 child: Text(
//                   userSelectedDate.toFormattedDate,
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelMedium
//                       ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
//                   textAlign: TextAlign.center,
//                 )),
//             const SizedBox(
//               height: 150,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                     editTodoInFireStore(
//                       titleController.text,
//                       descriptionController.text,
//                       userSelectedDate
//                   );
//                     tabKey.currentState?.readTodosFromFireStore();
//
//
//                 },
//                 child: Text(
//                   'Edit task',
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelLarge
//                       ?.copyWith(color: ColorsManager.whiteColor),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
//   void showTaskDatePicker() async {
//     userSelectedDate = await showDatePicker(
//             context: context,
//             barrierDismissible: false,
//             selectableDayPredicate: (day) => day.day != 30,
//             confirmText: 'Done',
//             cancelText: 'unSelect',
//             firstDate: DateTime.now(),
//             lastDate: DateTime.now().add(const Duration(days: 365))) ??
//         userSelectedDate;
//     setState(() {});
//   }
//
//   Future<void> editTodoInFireStore(
//       String? newTitle, String? newDescription, DateTime newDate) async{
//     if (formKey.currentState?.validate() == false) return;
// String? message;
// DialogUtils.showLoadingDialog(context,message: 'Loading...');
//     CollectionReference todoCollection = FirebaseFirestore.instance
//         .collection(UserDM.collectionName)
//         .doc(UserDM.user!.id)
//         .collection(TodoDM.collectionName);
//
//     DocumentReference doc = todoCollection.doc(widget.taskId);
//     // TodoDM todo=TodoDM(
//     //   id: doc.id,
//     //   title: titleController.text,
//     //   description: descriptionController.text,
//     //   date: userSelectedDate,
//     //   isDone: false,
//     // );
//       doc.update({
//       "title": newTitle,
//       "description": newDescription,
//       "date": Timestamp.fromMillisecondsSinceEpoch(newDate.millisecondsSinceEpoch)
//     }).then((value) {
//       DialogUtils.hideDialog(context);
//         if (mounted) {
//           Navigator.pop(context);
//         }
//         tabKey.currentState?.readTodosFromFireStore();
//
//       message='Done editing';
//       DialogUtils.showMessageDialog(context,posActionTitle: 'Ok',content: message,
//           posAction: (){
//           });
//     }).catchError((error) => message='Failed: $error');
//
//   }
// }
