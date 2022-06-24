import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

import '../auth_form/auth_form_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(AppColors.backgroundComponent)
                          .withOpacity(0.6),
                      theme.backgroundColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: theme.backgroundColor.withOpacity(0.75),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const FittedBox(
                        child: Text(
                          "Sentar Na Calma",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            shadows: [
                              BoxShadow(
                                color: Color(0x89777777),
                                offset: Offset(0, 2),
                                blurRadius: 5,
                              )
                            ],
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            fontFamily: 'Comfortaa',
                            color: Color(0x42022CFF),
                          ),
                        ),
                      ),
                    ),
                    AuthForm()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
