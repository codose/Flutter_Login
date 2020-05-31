import 'package:flutter/material.dart';
import 'package:login_forms/data/DatabaseHelper.dart';
import 'package:login_forms/data/models/User.dart';
import 'package:login_forms/pages/home/HomePage.dart';
import 'package:login_forms/pages/register/RegisterPresenter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin
    implements RegisterPageContract {
  AnimationController _iconAnimationController;
  Animation _iconAnimation;
  BuildContext _ctx;
  bool _isLoading;
  var _username, _password, _fullname;
  User user;

  RegisterPresenter _presenter;

  _RegisterPageState() {
    _presenter = RegisterPresenter(this);
  }
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final db = DatabaseHelper();

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
        key: scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage("assests/bg.jpg"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                              key: formKey,
                              child: Theme(
                                data: ThemeData(
                                    brightness: Brightness.dark,
                                    primarySwatch: Colors.blue,
                                    inputDecorationTheme: InputDecorationTheme(
                                        labelStyle: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16.0))),
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(children: <Widget>[
                                    TextFormField(
                                      onSaved: (val) => _fullname = val,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0)),
                                        labelText: "Enter FullName",
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0)),
                                    TextFormField(
                                      onSaved: (val) => _username = val,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0)),
                                        labelText: "Enter Email",
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0)),
                                    TextFormField(
                                        onSaved: (val) => _password = val,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0)),
                                            labelText: "Enter Password"),
                                        keyboardType: TextInputType.text,
                                        obscureText: true),
                                    Padding(
                                        padding: EdgeInsets.only(top: 40.0)),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Colors.blue,
                                      onPressed: () {
                                        _submit();
                                      },
                                      minWidth: double.infinity,
                                      height: 48.0,
                                      child: Text(
                                        "Register",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      splashColor: Colors.lightBlue.shade100,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 12.0)),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Colors.grey,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
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
                    ]),
              ),
            )
          ],
        ));
  }

  @override
  void onRegisterError(String error) {
    _showSnackBar(error.toString());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onRegisterSuccess(User user) {
    _showSnackBar("User successfully created");
    setState(() {
      _isLoading = false;
    });
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(user)));
  }

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        user = User.register(_username, _password, _fullname);
        _isLoading = true;
        _presenter.registerUser(user);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
