// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  DialogBox({super.key, required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
      height: 200,
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter Task",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: onSave,
            child: Text("Add Task"),
          )
        ],
      ),
    ));
  }
}
