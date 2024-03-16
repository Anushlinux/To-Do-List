// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/util/dialog_box.dart';
import 'package:myapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  final List toDoList = [
    ['Nigga', false],
    ['lmao', false],
  ];

  void saveNewTask() {
    setState(() {
      toDoList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(controller: controller, onSave: saveNewTask);
        });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(198, 255, 255, 255),
      appBar: AppBar(
        title: Text("TO DO LIST"),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 29, 63, 130),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(200, 0, 173, 181),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNewTask, child: Icon(Icons.add)),
      body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: toDoList[index][0],
              taskCompleted: toDoList[index][1],
              onChanged: (bool? value) {
                setState(() {
                  toDoList[index][1] = value!;
                });
              },
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
