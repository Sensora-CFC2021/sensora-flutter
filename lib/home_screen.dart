import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensora_tes2/language.dart';
import 'bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(),
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

class Body extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              "Select the plants you grow",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
