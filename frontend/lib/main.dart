import 'package:flutter/material.dart';
import 'package:frontend/locator.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/ui/views/auth/auth_form/auth_form_viewmodel.dart';
import 'package:frontend/ui/views/auth/auth_view/auth_view.dart';
import 'package:frontend/ui/views/auth_or_home_view.dart';
import 'package:frontend/ui/views/home/home_view.dart';
import 'package:frontend/ui/views/meditation_timer/meditation_timer_view.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const SentarNaCalma());
}

class SentarNaCalma extends StatelessWidget {
  const SentarNaCalma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthFormViewModel()),
        ChangeNotifierProvider(create: (_) => User()),
      ],
      child: MaterialApp(
        title: 'Sentar na Calma',
        theme: ThemeData(
          colorSchemeSeed: const Color(AppColors.purpleSeed),
          fontFamily: 'ModernSans',
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: AppRoutes.auth,
        routes: {
          AppRoutes.home: (_) => const HomeView(),
          AppRoutes.auth: (_) => const AuthView(),
          AppRoutes.meditationTimer: (_) => const MeditationTimerView(),
        },
      ),
    );
  }
}
