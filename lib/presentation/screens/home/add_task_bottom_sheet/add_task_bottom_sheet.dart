import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => AddTaskBottomSheetState();

  static Future show(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: AddTaskBottomSheet(),
      ),
    );
  }
}

class AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.5,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new task',
              style: Theme.of(context).textTheme.headlineLarge,
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
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 150,
            ),
            ElevatedButton(
                onPressed: () {
                  addTodoToFireStore();
                },
                child: Text(
                  'Add task',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: ColorsManager.whiteColor),
                ))
          ],
        ),
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

  void addTodoToFireStore() {
    if (formKey.currentState?.validate() == false) return;

    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName).doc(UserDM.user!.id).collection(TodoDM.collectionName);

    DocumentReference doc = todoCollection.doc();
    TodoDM todo=TodoDM(
      id: doc.id,
      title: titleController.text,
      description: descriptionController.text,
      date: userSelectedDate,
      isDone: false,
    );
    doc
        .set(todo.toJson())
        .then(
          (value) {
            if (mounted) {
              Navigator.pop(context);
            }
          },
        );
  }
}
