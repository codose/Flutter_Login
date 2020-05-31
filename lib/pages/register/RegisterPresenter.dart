import 'package:login_forms/data/DatabaseHelper.dart';
import 'package:login_forms/data/RestData.dart';
import 'package:login_forms/data/models/User.dart';

abstract class RegisterPageContract {
  void onRegisterSuccess(User user) {}
  void onRegisterError(String error) {}
}

class RegisterPresenter {
  RegisterPageContract _view;
  RestData api = RestData();

  RegisterPresenter(this._view);

  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((value) => _view.onRegisterSuccess(value))
        .catchError((onError) => _view.onRegisterError(onError));
  }

  registerUser(User user) {
    DatabaseHelper db = DatabaseHelper();
    db.saveUser(user).then((value) {
      _view.onRegisterSuccess(user);
    }).catchError((onError) => _view.onRegisterError(onError));
  }
}
