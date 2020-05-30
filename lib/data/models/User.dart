class User {
  String _username;
  String _password;
  String _fullname;
  User(this._username, this._password);
  User.register(this._username, this._password, this._fullname);

  User.map(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
    this._fullname = obj['fullname'];
  }

  String get username => _username;
  String get password => _password;
  String get fullname => _fullname;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["fullname"] = _fullname;
    return map;
  }
}
