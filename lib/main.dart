import 'package:flutter/material.dart';
import 'package:sensora_tes2/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sensora_tes2/localization/demo_localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        Locale('mn', 'MN'), // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      title: 'Sensora',
      theme: ThemeData(primaryColor: Colors.white),
      home: HomeScreen(),
    );
  }
}
