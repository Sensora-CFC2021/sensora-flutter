import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensora_test2/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.select_language),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        bottom: PreferredSize(
            child: Container(
              child: Text("000000000000000000000000000000000"),
              color: Colors.grey,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/back_button.svg",
              height: 26,
              width: 26,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

enum SingingCharacter { english, mongolian }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SingingCharacter? _character;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<SingingCharacter>(
            title: Text(AppLocalizations.of(context)!.english),
            value: SingingCharacter.english,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                provider.setLocale(Locale("en"));
                _character = value;
              });
            },
            secondary: Text(
              "🇬🇧",
              style: TextStyle(fontSize: 26),
            )),
        RadioListTile<SingingCharacter>(
            title: Text(AppLocalizations.of(context)!.mongolian),
            value: SingingCharacter.mongolian,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                provider.setLocale(Locale("mn"));
                _character = value;
              });
            },
            secondary: Text(
              "🇲🇳",
              style: TextStyle(fontSize: 26),
            )),
      ],
    );
  }

  /*
  Widget builSingleCheckBox(Languages language) => RadioListTile(
        groupValue: language.value,
        title: Text(language.title),
        value: language.value,
        onChanged: (value) {
          final provider = Provider.of<LocaleProvider>(context, listen: false);
          final locale = provider.locale ?? Locale('en');
          setState(() {
            provider.setLocale(locale);
          });
        },
        secondary: Text(
          language.flag,
          style: TextStyle(fontSize: 26),
        ),
      );
      */
}
