import 'package:flutter/material.dart';
import 'package:login_forms/data/models/User.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assests/img.jpg"),
                  ),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Text("My name is ${widget.user.fullname}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text("Email is ${widget.user.username}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ]),
          ),
        ));
  }
}
