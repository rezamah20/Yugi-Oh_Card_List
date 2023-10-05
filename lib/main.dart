import 'package:flutter/material.dart';
import 'package:flutter_app/screen/homeScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Yugi-oh card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Yugi-oh All Card'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key? key, required this.title}) :super(key: key);
  final String title;
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeScreenApp(),
        debugShowCheckedModeBanner: true,
      );
    }
}
