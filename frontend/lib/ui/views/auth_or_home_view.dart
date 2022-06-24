import 'package:frontend/models/user.dart';
import 'package:frontend/ui/views/auth_or_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class AuthOrHomeView extends StatelessWidget {
  const AuthOrHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return ViewModelBuilder<AuthOrHomeViewModel>.reactive(
      viewModelBuilder: () => AuthOrHomeViewModel(),
      builder: (context, viewModel, _) =>
          viewModel.redirectView(user.isAuthenticated),
    );
  }
}
