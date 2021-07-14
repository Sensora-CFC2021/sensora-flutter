import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensora_tes2/language.dart';
import 'bottom_nav_bar.dart';
import 'package:path/path.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                "assets/icons/mongolia.svg",
                height: 26,
                width: 26,
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
        ),
        bottomNavigationBar: MyBottomNavBar());
  }
}
