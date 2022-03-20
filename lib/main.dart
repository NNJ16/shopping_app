import 'package:flutter/material.dart';
import 'package:shopping_app/screens/admin/admin_screen.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdminScreen(),
    );
  }
}   