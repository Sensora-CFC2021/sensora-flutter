import 'package:flutter/material.dart';
import 'my_app_bar.dart';
import 'bottom_nav_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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

  String dropdownValue = 'Soil Moisture';
  @override
  Widget build(BuildContext context) {
    final percentage = animationController.value * 100;
    return Column(
      children: <Widget>[
        new Center(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.blueAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Soil Moisture', 'Temperature', 'Humidity']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
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
                        color: Colors.grey.shade300),
                  ),
                  direction: Axis.vertical,
                  backgroundColor: Colors.white,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
