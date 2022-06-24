import 'package:flutter/material.dart';
import 'package:frontend/ui/views/auth/auth_form/auth_form_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AuthForm extends StatelessWidget {
  AuthForm({Key? key}) : super(key: key);

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    print("Método build foi chamado $counter");
    counter++;
    return ViewModelBuilder<AuthFormViewModel>.reactive(
      viewModelBuilder: () => AuthFormViewModel(),
      builder: (context, viewModel, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          key: ValueKey<bool>(viewModel.isLogin),
          child: Card(
            margin: const EdgeInsets.all(25),
            child: Form(
              key: viewModel.formKey,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (viewModel.isRegister)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Nome de Usuário"),
                          keyboardType: TextInputType.text,
                          controller: viewModel.usernameController,
                          onSaved: (username) =>
                              viewModel.saveUsername(username),
                          validator: (username) =>
                              viewModel.validateUsername(username),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "E-mail"),
                        controller: viewModel.emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (email) => viewModel.saveEmail(email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Senha",
                          suffixIcon: Container(
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              child: viewModel.displayVisibilityIcon(
                                viewModel.obscurePassword,
                              ),
                              onTap: viewModel.switchDisplayPasswordMode,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: viewModel.passwordController,
                        obscureText: viewModel.obscurePassword,
                        onSaved: (password) => viewModel.savePassword(password),
                      ),
                    ),
                    if (viewModel.isRegister)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Confirmar Senha",
                            suffixIcon: Container(
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                child: viewModel.displayVisibilityIcon(
                                  viewModel.obscurePasswordConfirm,
                                ),
                                onTap:
                                    viewModel.switchDisplayPasswordConfirmMode,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: viewModel.obscurePasswordConfirm,
                          controller: viewModel.passwordConfirmController,
                          onSaved: (password2) =>
                              viewModel.savePassword2(password2),
                          validator: (_password2) =>
                              viewModel.validatePasswordConfirmation(
                                  viewModel.passwordController.text,
                                  _password2),
                        ),
                      ),
                    TextButton(
                      onPressed: viewModel.switchAuthMode,
                      child: Text(
                        viewModel.authChangeText,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    if (viewModel.hasError)
                      Container(
                        padding: const EdgeInsets.only(bottom: 17.0),
                        child: Text(
                          viewModel.error(viewModel).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: const Color(0xffff3d44),
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "ModernSans"),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    viewModel.isBusy
                        ? CircularProgressIndicator(
                            color: Theme.of(context).primaryColor)
                        : ElevatedButton(
                            onPressed: () => viewModel.submit(context),
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              viewModel.submitActionText,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
