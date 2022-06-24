import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/enums/enums.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/custom_exceptions.dart';
import 'package:frontend/constants/auth_endpoints.dart';
import 'package:stacked/stacked.dart';

class AuthFormViewModel extends BaseViewModel {
  Auth auth = Auth();

  User user = User();

  ApiService _apiService = ApiService();

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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  TextEditingController get usernameController => _usernameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get passwordConfirmController =>
      _passwordConfirmController;

  void saveEmail(String? email) {
    auth.email = email;
  }

  void savePassword(String? password) {
    auth.password1 = password;
  }

  void savePassword2(String? password2) {
    auth.password2 = password2;
  }

  void saveUsername(String? username) {
    auth.username = username;
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
    final dynamic response;
    if (_authMode == AuthMode.login) {
      response = _apiService.post(_authEndpoint, data: auth.loginJson());
    } else {
      response = _apiService.post(_authEndpoint, data: auth.registerJson());
    }
    return response;
  }

  Future<void> submit(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    try {
      final response = await runBusyFuture(loginOrRegister());
      if (response != null) {
        final currentUserData = await runBusyFuture(_apiService.get(
          AuthEndpoint.fetchUser,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Token ${response['key']}",
          },
        ));
        user.storeCurrentUser(currentUserData);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Sucesso"),
              content: Text("Seja bem vindo(a), ${user.username}!"),
            );
          },
        );
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
