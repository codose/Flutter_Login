import 'package:flutter/material.dart';
import 'package:login_forms/data/DatabaseHelper.dart';
import 'package:login_forms/data/models/User.dart';
import 'package:login_forms/pages/home/HomePage.dart';
import 'package:login_forms/pages/login/LoginPresenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin
    implements LoginPageContract {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  BuildContext _ctx;
  bool _isLoading;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var _username, _password;

  LoginPresenter _presenter;

  _LoginPageState() {
    _presenter = LoginPresenter(this);
  }
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
    _ctx = context;
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
            Column(
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
                                        color: Colors.blue, fontSize: 16.0))),
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(children: <Widget>[
                                TextFormField(
                                  onSaved: (val) => _username = val,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.0)),
                                    labelText: "Enter Email",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                ),
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
                                Padding(padding: EdgeInsets.only(top: 20.0)),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: Colors.blue,
                                  onPressed: () {
                                    _submit();
                                  },
                                  minWidth: double.infinity,
                                  height: 48.0,
                                  child: Text(
                                    "Login",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  splashColor: Colors.lightBlue.shade100,
                                ),
                                Padding(padding: EdgeInsets.only(top: 12.0)),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: Colors.grey,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed("/register");
                                  },
                                  minWidth: double.infinity,
                                  height: 48.0,
                                  child: Text(
                                    "Register",
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

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    print(user.username);
    setState(() {
      _isLoading = false;
    });
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(user)));
  }

  void _submit() {
    final form = formKey.currentState;
    var user;
    if (form.validate()) {
      setState(() {
        form.save();
        user = User(_username, _password);
        _isLoading = true;
        _presenter.loginUser(user);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
