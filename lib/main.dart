import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sensora_test2/bluetooth_conn.dart';
import 'language_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sensora_test2/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sensora_test2/provider/locale_provider.dart';
import 'package:provider/provider.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login/user_repository.dart';

import 'login/bloc/authentication_bloc.dart';
import 'login/splash.dart';
import '/login/login_page.dart';
import 'login/home.dart';
import 'login/create_account_button.dart';

void main() {
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  var userRepository = UserRepository();

  late BluetoothCharacteristic value;
  MyApp({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);
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
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationUninitialized) {
                  return SplashPage();
                }
                if (state is AuthenticationAuthenticated) {
                  return BluetoothConn();
                }
                if (state is AuthenticationUnauthenticated) {
                  return LoginPage(userRepository: userRepository);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      );
}
