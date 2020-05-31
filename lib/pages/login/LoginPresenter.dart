import 'package:login_forms/data/DatabaseHelper.dart';
import 'package:login_forms/data/RestData.dart';
import 'package:login_forms/data/models/User.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User user) {}
  void onLoginError(String user) {}
}

class LoginPresenter {
  LoginPageContract _view;
  RestData api = RestData();

  LoginPresenter(this._view);

  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((value) => _view.onLoginSuccess(value))
        .catchError((onError) => _view.onLoginError(onError));
  }

  loginUser(User user) {
    DatabaseHelper db = DatabaseHelper();
    db.getUser(user).then((value) {
      if (value != null) {
        _view.onLoginSuccess(value);
      } else {
        _view.onLoginError("Error Occured");
      }
    }).catchError((onError) => _view.onLoginError(onError));
  }
}
