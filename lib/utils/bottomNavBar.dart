import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget{
  int _index = 0;


  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_index) {
      case 0:
       // child = FlutterLogo();
        break;
      case 1:
       // child = FlutterLogo(colors: Colors.orange);
        break;
      case 2:
        //child = FlutterLogo(colors: Colors.red);
        break;
    }
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: "call",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "camera"
        )
      ]
    );
  }
}