import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensora_tes2/change_languages.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
      appBar: AppBar(
        title: Text('Choose your Language'),
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

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final languages = [
    Languages(title: "English", flag: "🇬🇧"),
    Languages(title: "Mongolian", flag: "🇲🇳")
  ];

  void _changeLanguage(Languages language) {
    print(language.title);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [...languages.map(builSingleCheckBox)],
    );
  }

  Widget builSingleCheckBox(Languages language) => CheckboxListTile(
        title: Text(language.title),
        value: language.value,
        onChanged: (value) {
          _changeLanguage(language);
          setState(() {
            language.value = value!;
          });
        },
        secondary: Text(
          language.flag,
          style: TextStyle(fontSize: 26),
        ),
      );
}
