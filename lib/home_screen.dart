import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' show utf8;
import 'my_app_bar.dart';
import 'bottom_nav_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomeScreen extends StatelessWidget {
  BluetoothCharacteristic value;
  HomeScreen(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: HomeScreenBody(value),
        bottomNavigationBar: MyBottomNavBar());
  }
}

class HomeScreenBody extends StatefulWidget {
  BluetoothCharacteristic value;
  HomeScreenBody(this.value);

  @override
  State<HomeScreenBody> createState() => _MyStatefulWidgetState(value);
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<HomeScreenBody>
    with SingleTickerProviderStateMixin {
  BluetoothCharacteristic value;
  _MyStatefulWidgetState(this.value);
  late AnimationController animationController;
  late Animation animation;
  late String temp;

  void asyncMethod() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await value.write(utf8.encode("temp"));
      final decoded = await value.read();
      setState(() {
        temp = utf8.decode(decoded).toString();
      });
    });
  }

  late SharedPreferences vegiesData;
  late List<String>? selectedVegiesId;

  void initState() {
    super.initState();
    asyncMethod();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
      animationBehavior: AnimationBehavior.normal,
      lowerBound: 1.0,
    );
    animationController.repeat();
    animationController.addListener(() {
      setState(() {});
    });
    initial();
    super.initState();
  }

  void initial() async {
    vegiesData = await SharedPreferences.getInstance();
    setState(() {
      selectedVegiesId = vegiesData.getStringList('selectedList');
    });
    print(vegiesData);
  }

  @override
  Widget build(BuildContext context) {
    var tempNumber = "0";
    if (temp.length > 4) {
      tempNumber = temp.substring(4);
    }
    print(tempNumber);
    double number = double.parse(tempNumber);
    final animationPercentage = animationController.value * 0.34;
    final textPercentage = animationController.value * 34;
    final tempPercentage = animationController.value * number;
    final humidPercentage = animationController.value * 28;

    return Column(
      children: <Widget>[
        new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularPercentIndicator(
                progressColor: Colors.redAccent,
                percent: number / 100,
                animation: true,
                animationDuration: 1600,
                radius: 130,
                lineWidth: 9,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '$tempPercentage°C',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600),
                ),
                footer: Text(
                  "Temperature",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
