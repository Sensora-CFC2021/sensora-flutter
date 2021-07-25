import 'dart:ffi';

import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'bottom_nav_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: HomeScreenBody(),
        bottomNavigationBar: MyBottomNavBar());
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<HomeScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  void initState() {
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

    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    final animationPercentage = animationController.value * 0.34;
    final textPercentage = animationController.value * 34;
    final tempPercentage = animationController.value * 25;
    final humidPercentage = animationController.value * 28;
    return Column(
      children: <Widget>[
        new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                height: 175,
                width: 175,
                child: LiquidCircularProgressIndicator(
                  value: animationPercentage,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  center: Text(
                    '${textPercentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade200),
                  ),
                  borderColor: Colors.lightBlue.shade400,
                  borderWidth: 2.0,
                  direction: Axis.vertical,
                  backgroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
        new Center(
            child: Text(
          "Soil Moisture",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue.shade400),
        )),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              progressColor: Colors.lightBlue.shade400,
              percent: 28 / 100,
              animation: true,
              animationDuration: 1600,
              radius: 130,
              lineWidth: 9,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '${humidPercentage.toStringAsFixed(0)}%',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600),
              ),
              footer: Text(
                "Humidity",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue.shade400),
              ),
            ),
            CircularPercentIndicator(
              progressColor: Colors.redAccent,
              percent: 36 / 100,
              animation: true,
              animationDuration: 1600,
              radius: 130,
              lineWidth: 9,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '${tempPercentage.toStringAsFixed(0)}°C',
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
        )
      ],
    );
  }
}
