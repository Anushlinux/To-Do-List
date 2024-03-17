// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, library_private_types_in_public_api, use_super_parameters, unnecessary_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/data/database.dart';
import 'package:myapp/util/dialog_box.dart';
import 'package:myapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.openBox('mybox');
  ToDoDataBase db = ToDoDataBase();

  Future<void> initializeHiveData() async {
    final myBox = await _mybox;
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  @override
  void initState() {
    initializeHiveData(); // Call the new method without awaiting
    super.initState();
  }

  final controller = TextEditingController();

  void saveNewTask() {
    setState(() {
      db.toDoList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
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
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(219, 255, 255, 255),
      appBar: AppBar(
        title: Text("TO DO LIST"),
        elevation: 0.0,
        toolbarHeight: 70,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 59, 59, 59),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(200, 0, 173, 181),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 115, 217, 230),
              Color.fromARGB(255, 0, 238, 255)
            ],
          ),
        ),
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: createNewTask,
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(206, 208, 208, 208),
          foregroundColor: Color.fromARGB(197, 225, 0, 0),
          elevation: 20,
        ),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (bool? value) {
                setState(() {
                  db.toDoList[index][1] = value!;
                });
                db.updateDatabase();
              },
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
