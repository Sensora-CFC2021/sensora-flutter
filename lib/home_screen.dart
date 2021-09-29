import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensora_test2/user_info.dart';
import 'dart:convert' show utf8;
import 'my_app_bar.dart';
import 'bottom_nav_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomeScreen extends StatelessWidget {
  BluetoothCharacteristic value;
  HomeScreen(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: UserInfo(),
        appBar: MyAppBar(),
        body: HomeScreenBody(value),
        bottomNavigationBar: MyBottomNavBar(value));
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
  late String temp = "";
  late String humid = "";
  late String soilm = "";

  void asyncMethod() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await value.write(utf8.encode("temp"));
      final decodedTemp = await value.read();
      await value.write(utf8.encode("humid"));
      final decodedHumid = await value.read();
      await value.write(utf8.encode("soilm"));
      final decodedSoilm = await value.read();

      setState(() {
        temp = utf8.decode(decodedTemp).toString();
        humid = utf8.decode(decodedHumid).toString();
        soilm = utf8.decode(decodedSoilm).toString();
      });
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    if (temp.isEmpty && humid.isEmpty && soilm.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    if (temp.contains("nan") || humid.contains("nan")) {
      return Center(child: CircularProgressIndicator());
    }
    var tempNumber = "0";
    if (temp.length > 4) {
      tempNumber = temp.substring(4);
    }
    var humidNumber = "0";
    if (humid.length > 5) {
      humidNumber = humid.substring(5);
    }
    var soilmNumber = "0";
    if (soilm.length > 5) {
      soilmNumber = soilm.substring(5);
    }

    double tempnumber = 0.0;
    tempnumber = double.parse(tempNumber);
    double humidnumber = 0.0;
    humidnumber = double.parse(humidNumber);
    double soilmnumber = 0.0;
    soilmnumber = double.parse(soilmNumber);

    double dry = 511;
    double wet = 160;
    //double percentageSoilm = array.map(soilmnumber, wet, dry, 100, 0);
    double percentageSoilm =
        100 + (0 - 100) * (soilmnumber - wet) / (dry - wet);
    final soilmPercentage = animationController.value * (percentageSoilm / 100);
    final textPercentage =
        animationController.value.toInt() * percentageSoilm.round();
    final tempPercentage = animationController.value * tempnumber;
    final humidPercentage = animationController.value * humidnumber;

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
                  value: soilmPercentage,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  center: Text(
                    '$textPercentage%',
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
              progressColor: Colors.redAccent,
              percent: tempnumber / 100,
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
            CircularPercentIndicator(
              progressColor: Colors.lightBlue.shade400,
              percent: humidnumber / 100,
              animation: true,
              animationDuration: 1600,
              radius: 130,
              lineWidth: 9,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '$humidPercentage%',
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
          ],
        ),
      ],
    );
  }
}
