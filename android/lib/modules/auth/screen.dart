import 'package:centr_invest_app/core/ui/button.dart';
import 'package:centr_invest_app/core/ui/input.dart';
import 'package:centr_invest_app/core/ui/input_password.dart';
import 'package:centr_invest_app/modules/auth/contract.dart';
import 'package:centr_invest_app/modules/auth/presenter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/ui/padding.dart';
import '../../navigate.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> implements AuthContract {
  late final AuthPresenter _presenter = AuthPresenter(this);

  final _authForm = GlobalKey<FormState>();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: insets(all: 10),
          child: Form(
            key: _authForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tr('auth'),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                InputFieldWidget(
                    controller: _loginController,
                    label: tr("login"),
                    onChanged: (String v) {}),
                PasswordFieldWidget(
                  controller: _passwordController,
                  label: tr("password"),
                ),
                Padding(
                  padding: insets(vertical: 10.0),
                  child: _presenter.isLoading
                      ? Container(
                          width: 48,
                          height: 48,
                          padding: insets(all: 2.0),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                            strokeWidth: 3,
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: loginButton(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => ButtonPrimary(
      onPressed: () async {
        final form = _authForm.currentState!;
        if (form.validate()) {
          await _presenter
              .login(_loginController.text, _passwordController.text)
              .then((value) => Navigate.openHomeScreen(context))
              .catchError((onError) => ScaffoldMessenger.of(context)
                ..showSnackBar(SnackBar(
                  content: Text(tr("auth.fail")),
                  backgroundColor: Colors.red,
                )));
        }
      },
      label: Text(tr("next")));

  @override
  void render() {
    setState(() {});
  }
}
