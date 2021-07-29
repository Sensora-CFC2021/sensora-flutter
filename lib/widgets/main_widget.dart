import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  //final String location;
  final int temperature;
  final int temperatureFeelsLike;
  final String wxPhraseLong;
  final int relativeHumidity;
  final int windSpeed;

  MainWidget({
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.wxPhraseLong,
    required this.relativeHumidity,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
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
                  "${temperature.toString()} C",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                "Танд мэдрэгдэх : ${temperatureFeelsLike.toString()} C",
                style: TextStyle(
                  color: Color(0xff9e9e9e),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              )
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
                    subtitle: "${temperature.toString()} C"),
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
                    subtitle: "${windSpeed.toString()} км/ц"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
