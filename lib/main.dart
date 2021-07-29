import 'package:flutter/material.dart';
import 'package:flutter_test_project/screens/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}
