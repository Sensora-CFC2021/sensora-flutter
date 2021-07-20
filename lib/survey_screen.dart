import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensora_test2/language_screen.dart';
import 'bottom_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sensora_test2/l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Body(),
        bottomNavigationBar: MyBottomNavBar());
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);
    return AppBar(
      title: TextField(
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.enter_message,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 100,
      leading: IconButton(
          icon: Text(
            flag,
            style: TextStyle(fontSize: 28),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LanguageScreen()),
            );
          }),
      actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/search_icon.svg",
              height: 24,
              width: 24,
            )),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/tune_icon.svg",
              height: 24,
              width: 24,
            ))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}

class Body extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              AppLocalizations.of(context)!.select_plants,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
