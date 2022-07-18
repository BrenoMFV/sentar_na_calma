import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/enums/enums.dart';
import 'package:frontend/locator.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/utils/custom_exceptions.dart';
import 'package:frontend/constants/auth_endpoints.dart';
import 'package:stacked/stacked.dart';

class AuthFormViewModel extends BaseViewModel {
  final AuthService _authService = locator.get<AuthService>();

  final NavigationService _navService = locator.get<NavigationService>();

  User user = User();

  AuthMode _authMode = AuthMode.login;

  AuthMode get authMode => _authMode;

  num get passwordMinLength => 8;

  void switchAuthMode() {
    setBusy(true);
    if (isLogin) {
      _authMode = AuthMode.register;
    } else {
      _authMode = AuthMode.login;
    }
    setBusy(false);
    notifyListeners();
  }

  bool get isRegister => _authMode == AuthMode.register;

  bool get isLogin => _authMode == AuthMode.login;

  String get _authEndpoint =>
      isRegister ? AuthEndpoint.register : AuthEndpoint.login;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  String get submitActionText =>
      _authMode == AuthMode.login ? 'Entrar' : 'Cadastrar';

  String get authChangeText =>
      _authMode == AuthMode.login ? 'Registrar' : 'Já possuo conta';

  // TextEditingController

  void saveEmail(String? email) {
    _authService.email = email;
  }

  void savePassword(String? password) {
    _authService.password1 = password;
  }

  void savePassword2(String? password2) {
    _authService.password2 = password2;
  }

  void saveUsername(String? username) {
    _authService.username = username;
  }

  final RegExp _passwordComplexity = RegExp(r'[a-zA-Z0-9]');

  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void switchDisplayPasswordMode() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  bool _obscurePasswordConfirm = true;

  bool get obscurePasswordConfirm => _obscurePasswordConfirm;

  void switchDisplayPasswordConfirmMode() {
    _obscurePasswordConfirm = !_obscurePasswordConfirm;
    notifyListeners();
  }

  Widget displayVisibilityIcon(bool obscuredField) {
    IconData icon = obscuredField ? Icons.visibility : Icons.visibility_off;
    return Icon(icon);
  }

  loginOrRegister() {
    return _authMode == AuthMode.login
        ? _authService.login()
        : _authService.register();
  }

  Future<void> submit(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    try {
      final bool isAuthenticated = await runBusyFuture(loginOrRegister());
      if (isAuthenticated) {
        _navService.redirectAfterLogin();
      }
    } on ObjectNotFoundException catch (e) {
      setError(e.toString());
    } on SocketException catch (e) {
      setError(e.toString());
    } on BadRequestException catch (e) {
      setError(e.toString());
    } on Exception catch (e) {
      setError(e.toString());
    } catch (e) {
      setError(e.toString());
    }
  }

  // VALIDAÇÕES DE CAMPO
  String emptyFieldMessage = "O campo deve ser preenchido";

  String? validateUsername(String? username) {
    String _username = username ?? '';
    if (_username.isEmpty) {
      return emptyFieldMessage;
    }
    return null;
  }

  String? validateEmail(String? email) {
    String _email = email ?? '';
    if (!_email.contains('@')) {
      return "Insira um e-mail válido";
    }
    if (_email.isEmpty) {
      return emptyFieldMessage;
    }
    return null;
  }

  String? validatePassword(String? password) {
    String _password = password ?? '';
    if (_password.isEmpty) {
      return emptyFieldMessage;
    }
    if (_password.length < passwordMinLength) {
      return 'A senha deve conter ao menos ${passwordMinLength.toString()} dígitos, com números e letras';
    }
    if (!_passwordComplexity.hasMatch(_password)) {
      return 'A senha deve conter ao menos ${passwordMinLength.toString()} dígitos, com números e letras';
    }
    return null;
  }

  String? validatePasswordConfirmation(String? password, String? password2) {
    final _password = password ?? '';
    final _password2 = password2 ?? '';
    if (_password2.isEmpty) {
      return "Por favor, confirme a senha,";
    }
    if (_password != _password2 &&
        _password.isNotEmpty &&
        _password2.isNotEmpty) {
      return "As senhas devem ser iguais.";
    }
    return null;
  }
}
