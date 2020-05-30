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
}
