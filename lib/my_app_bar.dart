import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensora_test2/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sensora_test2/language_screen.dart';

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
  Size get preferredSize => const Size.fromHeight(100);
}
