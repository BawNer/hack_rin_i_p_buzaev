import 'dart:io';

import 'package:centr_invest_app/core/database.dart';
import 'package:centr_invest_app/injector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await initDatabase();

  const ruLocale = Locale('ru');
  const enLocale = Locale('en');
  const locales = [ruLocale, enLocale];

  final String defaultLocale = Platform.localeName.split('_')[0];
  final int localeIndex = locales.indexOf(Locale(defaultLocale));

  runApp(EasyLocalization(
    supportedLocales: locales,
    path: 'assets/i18n',
    useFallbackTranslations: true,
    fallbackLocale: localeIndex == -1 ? ruLocale : locales[localeIndex],
    child: const Application(),
  ));
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        applyElevationOverlayColor: true,
        primaryColor: const Color(0xFF50b848),
        cardTheme: const CardTheme(
          surfaceTintColor: Colors.white,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge:
              GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.bold),
          titleMedium:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.montserrat(fontSize: 14),
          displaySmall: GoogleFonts.roboto(),
        ),
      ),
      initialRoute: '/',
      home: const RootScreen(),
      builder: (context, child) {
        if (child != null) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
            child: child,
          );
        }
        return child ?? const SizedBox();
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    Injector().user.isValid.then((value) => {
      if (value) {
        Navigate.openHomeScreen(context)
      } else {
        Navigate.openAuthScreen(context)
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(tr('loading')),
            )
          ],
        ),
      ),
    );
  }
}
