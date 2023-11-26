import 'package:centr_invest_app/injector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../navigate.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          'ЦентрИнвест',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Center(
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    Injector().user.logout().then((value) => {
                      Navigate.openAuthScreen(context)
                    });
                  },
                  child: const Text('Выход из аккаунта'),
                ),
              ),
              Column(
                children: [
                  Text('Язык системы'),
                  SizedBox(
                    width: 200.0,
                    child: DropdownButton(
                      value: context.locale.toString(),
                      items: context.supportedLocales
                          .fold<List<DropdownMenuItem<String>>>(
                        [],
                            (prev, element) => List.from(prev)
                          ..add(DropdownMenuItem(
                            value: element.toString(),
                            child: Text(element.toString()),
                          )),
                      ),
                      onChanged: (dynamic value) async {
                        await context.setLocale(Locale(value));
                        setState((){});
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}

