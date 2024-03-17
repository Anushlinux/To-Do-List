// ignore_for_file: prefer_const_constructors, unused_local_variable, camel_case_types

import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:myapp/pages/home_page.dart";

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox("mybox");

  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
