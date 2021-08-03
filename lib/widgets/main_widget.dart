import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  //final String location;
  final int temperature;
  final int temperatureFeelsLike;
  final String wxPhraseLong;
  final int relativeHumidity;
  final int windSpeed;
  final int iconCode;
  var temps = [];
  var weather_icons = [];
  var dayOfWeek = [];
  var validTimeLocal = [];

  MainWidget({
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.wxPhraseLong,
    required this.relativeHumidity,
    required this.windSpeed,
    required this.temps,
    required this.iconCode,
    required this.weather_icons,
    required this.dayOfWeek,
    required this.validTimeLocal,
  });

  @override
  Widget build(BuildContext context) {
    String asset =
        'assets/icons/weather_icons/icon' + iconCode.toString() + '.png';
    final dateTime = DateTime.now();
    final formatedString = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    final double metrSec = windSpeed / 3.6;
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4.5,
          width: MediaQuery.of(context).size.width,
          color: Color(0xfff1f1f1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Улаанбаатар",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              _popupScreen(context, validTimeLocal, temps,
                                  weather_icons, dayOfWeek);
                            },
                            child: (Text(
                              "${temperature.toString()}° C",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w900),
                            )),
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(left: 10),
                          height: 50,
                          child: Image.asset(asset),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${formatedString.toString()}",
                style: TextStyle(
                  color: Color(0xff9e9e9e),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (var i = 0; i < 15; i++)
                forecastElement(validTimeLocal[i], temps[i], weather_icons[i]),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                WeatherTile(
                    icon: Icons.thermostat_outlined,
                    title: "Танд мэдрэгдэх",
                    subtitle: "${temperatureFeelsLike.toString()}° C"),
                WeatherTile(
                    icon: Icons.filter_drama_outlined,
                    title: "Гадаа",
                    subtitle: "${wxPhraseLong.toString()}"),
                WeatherTile(
                    icon: Icons.wb_sunny,
                    title: "Агаарын чийгшил",
                    subtitle: "${relativeHumidity.toString()}%"),
                WeatherTile(
                    icon: Icons.waves_outlined,
                    title: "Салхины хурд",
                    subtitle: "${metrSec.toStringAsFixed(1)} м/с"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _popupScreen(context, validTimeLocal, temps, weather_icons, dayOfWeek) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .6,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (var i = 0; i < 47; i++)
                  forecastElementforBottomsheet(validTimeLocal[i], temps[i],
                      weather_icons[i], dayOfWeek[i]),
              ],
            ),
          ),
        );
      });
}

Widget forecastElement(validTimeLocal, temp, weather_icons) {
  String asset =
      'assets/icons/weather_icons/icon' + weather_icons.toString() + '.png';
  var dateTime = DateTime.parse(validTimeLocal).toLocal();
  var oneHourFromNow = DateFormat("HH:mm").format(dateTime);
  return Padding(
    padding: const EdgeInsets.only(left: 12.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              asset,
              height: 50,
            ),
            Text(
              temp.toString() + "° C",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            Text(
              oneHourFromNow,
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget forecastElementforBottomsheet(
    validTimeLocal, temp, weather_icons, dayOfWeek) {
  String asset =
      'assets/icons/weather_icons/icon' + weather_icons.toString() + '.png';
  var dateTime = DateTime.parse(validTimeLocal).toLocal();
  var oneHourFromNow = DateFormat("HH:mm").format(dateTime);

  return Padding(
    padding: const EdgeInsets.only(left: 0),
    child: Container(
        padding: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: (Container(
                child: (Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayOfWeek.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      oneHourFromNow,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
              )),
            ),
            Expanded(
                flex: 1,
                child: (Text(
                  temp.toString() + "° C",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ))),
            Expanded(
              flex: 1,
              child: (Image.asset(
                asset,
                height: 50,
              )),
            )
          ],
        )),
  );
}
