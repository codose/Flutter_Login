import 'package:login_forms/utils/NetworkUtil.dart';

class RestData{
  NetWorkUtil _netWorkUtil = NetWorkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL+"/";

  Future<User> login(String username, String password){
    return null;
  }

}