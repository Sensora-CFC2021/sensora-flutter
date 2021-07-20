import 'package:flutter/material.dart';
import 'package:sensora_test2/survey_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sensora_test2/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sensora_test2/provider/locale_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate
            ],
            debugShowCheckedModeBanner: false,
            title: 'Sensora',
            theme: ThemeData(primaryColor: Colors.white),
            home: HomeScreen(),
          );
        },
      );
}
