import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensora_test2/weather_screen.dart';
import 'home_screen.dart';
import '../constant.dart';
import 'bluetooth_conn.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatefulWidget {
  BluetoothCharacteristic secondValue;
  MyBottomNavBar(this.secondValue, {Key? key}) : super(key: key);

  _MyBottomNavBarState createState() => _MyBottomNavBarState(secondValue);
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  BluetoothCharacteristic secondValue;
  _MyBottomNavBarState(this.secondValue);

  @override
  Widget build(BuildContext context) {
    print(secondValue);
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/shape_icon.svg"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BluetoothConn()));
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/home_icon.svg"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(secondValue)));
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/weather_icon.svg"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherApp(secondValue)));
            },
          ),
        ],
      ),
    );
  }
}
