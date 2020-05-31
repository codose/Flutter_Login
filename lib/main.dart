import 'package:flutter/material.dart';
import 'package:login_forms/pages/home/HomePage.dart';
import 'package:login_forms/pages/login/LoginPage.dart';
import 'package:login_forms/pages/register/RegisterPage.dart';

void main() {
  runApp(MyApp());
}

final routes = {
  "/login": (BuildContext context) => LoginPage(),
  "/register": (BuildContext context) => RegisterPage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      home: LoginPage(),
    );
  }
}
