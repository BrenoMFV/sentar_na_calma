import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String? _username;
  String? _email;
  String? _token;

  User();

  String? get token => _token ?? '';

  String? get username => _username ?? '';

  String? get email => _email ?? '';

  bool get isAuthenticated {
    if (_token == null) {
      return false;
    }
    return _token!.isNotEmpty;
  }

  set username(String? username) {
    _username = username ?? '';
    notifyListeners();
  }

  set email(String? email) {
    _email = email ?? '';
    notifyListeners();
  }

  set token(String? token) {
    _token = token ?? '';
    notifyListeners();
  }

  void storeCurrentUser(Map<String, dynamic> data) {
    _username = data['username'];
    _email = data['email'];
    _token = data['token'];
    notifyListeners();
  }

  @override
  String toString() {
    return '$username ($email): $token';
  }
}
