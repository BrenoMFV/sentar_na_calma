import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:frontend/constants/auth_endpoints.dart';
import 'package:frontend/locator.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/api_service.dart';

class AuthService with ChangeNotifier {
  final ApiService _api = locator.get<ApiService>();
  final User user = User();

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

  _authenticate(endpoint, data) async {
    final dynamic response;
    try {
      response = await _api.post(AuthEndpoint.login, data: data);
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
    final currentUserData = await (_api.get(
      AuthEndpoint.fetchUser,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Token ${response['key']}",
      },
    ));
    bool hasUser = currentUserData != null;
    if (hasUser) {
      user.storeCurrentUser(currentUserData);
    }
    return hasUser;
  }

  Future<bool> login() async {
    return _authenticate(AuthEndpoint.login, loginJson());
  }

  Future<bool> register() async {
    return _authenticate(AuthEndpoint.register, registerJson());
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
