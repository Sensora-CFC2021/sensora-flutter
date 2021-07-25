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
      duration: Duration(seconds: 15),
    );
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat();
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    final percentage = animationController.value * 100;
    return Column(
      children: <Widget>[
        new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                height: 175,
                width: 175,
                child: LiquidCircularProgressIndicator(
                  value: .50,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  center: Text(
                    '${percentage.toStringAsFixed(0)}%',
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
        new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CircularPercentIndicator(
                progressColor: Colors.lightBlue.shade400,
                percent: 64/100,
                animation: true,
                animationDuration: 1600,
                radius: 130,
                lineWidth: 9,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                    '${percentage.toStringAsFixed(0)}%',
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
                        color: Colors.lightBlue.shade400),),
              ),
              CircularPercentIndicator(
                progressColor: Colors.redAccent,
                percent: 36/100,
                animation: true,
                animationDuration: 1600,
                radius: 130,
                lineWidth: 9,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                    '${percentage.toStringAsFixed(0)}%',
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
                        color: Colors.redAccent),),
              ),
            ])
      ],
    );
  }
}
