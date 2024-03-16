// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:myapp/pages/home_page.dart";

void main() {
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
