import 'package:flutter/material.dart';
import 'package:sensora_test2/bottom_nav_bar.dart';
import 'package:sensora_test2/my_app_bar.dart';
import 'widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_blue/flutter_blue.dart';

Future<WeatherInfo> fetchWeather() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  final requestUrl = "https://api.weather.com/v3/wx/forecast/hourly/2day?geocode=" +
      position.latitude.toString() +
      "," +
      position.longitude.toString() +
      "&format=json&units=m&language=mn&apiKey=8042786b38064cbb82786b3806fcbbf9";

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Aldaa");
  }
}

class WeatherInfo {
  var temperature = [];
  var temperatureFeelsLike = [];
  var wxPhraseLong = [];
  var relativeHumidity = [];
  var windSpeed = [];

  WeatherInfo({
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.wxPhraseLong,
    required this.relativeHumidity,
    required this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: json['temperature'],
      temperatureFeelsLike: json['temperatureFeelsLike'],
      wxPhraseLong: json['wxPhraseLong'],
      relativeHumidity: json['relativeHumidity'],
      windSpeed: json['windSpeed'],
    );
  }
}

class WeatherApp extends StatefulWidget {
  BluetoothCharacteristic weatherValue;
  WeatherApp(this.weatherValue);
  @override
  State<StatefulWidget> createState() {
    return _WeatherApp(weatherValue);
  }
}

class _WeatherApp extends State<WeatherApp> {
  BluetoothCharacteristic weatherValue;
  _WeatherApp(this.weatherValue);
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: FutureBuilder<WeatherInfo>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainWidget(
                  temperature: snapshot.data!.temperature[0],
                  temperatureFeelsLike: snapshot.data!.temperatureFeelsLike[0],
                  wxPhraseLong: snapshot.data!.wxPhraseLong[0],
                  relativeHumidity: snapshot.data!.relativeHumidity[0],
                  windSpeed: snapshot.data!.windSpeed[0],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return CircularProgressIndicator();
            }),
        bottomNavigationBar: MyBottomNavBar(weatherValue));
  }
}
