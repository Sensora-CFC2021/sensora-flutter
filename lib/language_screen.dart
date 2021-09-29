import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sensora_test2/home_screen.dart';
import 'package:sensora_test2/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'bluetooth_conn.dart';

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
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: <Widget>[],
      )),
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
    return SingleChildScrollView(
      child: Column(
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
      ),
    );
  }
}
