import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  String? _email;
  String? _password1;
  String? _password2;
  String? _username;

  String? get email => _email;
  String? get password1 => _password1;
  String? get password2 => _password2;
  String? get username => _username;

  set email(String? email) {
    _email = email;
    notifyListeners();
  }

  set password1(String? password) {
    _password1 = password;
    notifyListeners();
  }

  set password2(String? password2) {
    _password2 = password2;
    notifyListeners();
  }

  set username(String? username) {
    _username = username;
    notifyListeners();
  }

  registerJson() {
    Map<String, dynamic> data = {};
    data['email'] = _email;
    data['password1'] = _password1;
    data['password2'] = _password2;
    data['username'] = _username;
    return data;
  }

  loginJson() {
    Map<String, dynamic> data = {};
    data['email'] = _email;
    data['password'] = _password1;
    return data;
  }

  void clear() {
    _email = '';
    _password1 = '';
    _password2 = '';
    _username = '';
  }
}
