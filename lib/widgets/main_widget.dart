import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  //final String location;
  final String validTimeLocal;
  final int temperature;
  final int temperatureFeelsLike;
  final String wxPhraseLong;
  final int relativeHumidity;
  final int windSpeed;
  var temps = [];

  MainWidget({
    required this.validTimeLocal,
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.wxPhraseLong,
    required this.relativeHumidity,
    required this.windSpeed,
    required this.temps,
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now();
    final format = DateFormat('yyyy:MM:dd HH:mm');
    final formatedString = format.format(dateTime);
    final double metrSec = windSpeed / 3.6;
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          color: Color(0xfff1f1f1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                //"${location.toString()}",
                "Улаанбаатар",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "${temperature.toString()}° C",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                "Танд мэдрэгдэх : ${temperatureFeelsLike.toString()}° C",
                style: TextStyle(
                  color: Color(0xff9e9e9e),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
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
              for (var i = 1; i < 14; i++) forecastElement(i, temps[i]),
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
                    title: "Цаг агаар",
                    subtitle: "${temperature.toString()}° C"),
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

class Temps {
  var temperature = [];
}

Widget forecastElement(daysFromNow, temp) {
  var now = new DateTime.now();
  var oneHourFromNow = now.add(new Duration(hours: daysFromNow));
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
            Text(
              temp.toString() + "° C",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            Text(
              new DateFormat.H().format(oneHourFromNow) + ":00",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ],
        ),
      ),
    ),
  );
}
