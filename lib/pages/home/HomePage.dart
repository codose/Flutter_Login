import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      CircleAvatar(
        child: Image.asset("assests/bg.jpg"),
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(""), Text("")])
    ]));
  }
}
