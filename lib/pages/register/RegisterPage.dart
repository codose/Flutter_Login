import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeInToLinear);

    _iconAnimation.addListener(() {
      this.setState(() {});
    });
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return registerForm();
  }

  Widget registerForm() {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
          image: AssetImage("assests/bg.jpg"),
          fit: BoxFit.cover,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          new FlutterLogo(
            size: _iconAnimation.value * 120,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.grey.shade900,
              child: Form(
                  child: Theme(
                data: ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.blue,
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle:
                            TextStyle(color: Colors.blue, fontSize: 16.0))),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0)),
                        labelText: "Enter FullName",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0)),
                        labelText: "Enter Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0)),
                            labelText: "Enter Password"),
                        keyboardType: TextInputType.text,
                        obscureText: true),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.blue,
                      onPressed: () {},
                      minWidth: double.infinity,
                      height: 48.0,
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 16),
                      ),
                      splashColor: Colors.lightBlue.shade100,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.grey,
                      onPressed: () {},
                      minWidth: double.infinity,
                      height: 48.0,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ),
                      splashColor: Colors.lightBlue.shade100,
                    )
                  ]),
                ),
              )),
            ),
          )
        ])
      ],
    ));
  }
}
