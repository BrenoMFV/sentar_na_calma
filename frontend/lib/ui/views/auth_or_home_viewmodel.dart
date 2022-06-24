import 'package:frontend/models/user.dart';
import 'package:frontend/ui/views/meditation_timer/meditation_timer_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:frontend/ui/views/auth/auth_view/auth_view.dart';

class AuthOrHomeViewModel extends BaseViewModel {
  Widget redirectView(bool userIsAuthenticated) =>
      userIsAuthenticated ? const MeditationTimerView() : const AuthView();
}
