import 'package:flutter/material.dart';
import 'package:flutter_app/screen/homeScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenApp(),
      debugShowCheckedModeBanner: true,
    );
  }
}