import 'package:flutter/material.dart';
import 'package:sensora_test2/bottom_nav_bar.dart';
import 'package:sensora_test2/my_app_bar.dart';
import 'widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

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

class WeatherData {
  var temperature = [];
  var temperatureFeelsLike = [];
  var wxPhraseLong = [];
  var relativeHumidity = [];
  var windSpeed = [];
  var validTimeLocal = [];
}

class WeatherInfo {
  var temperature = [];
  var temperatureFeelsLike = [];
  var wxPhraseLong = [];
  var relativeHumidity = [];
  var windSpeed = [];
  var validTimeLocal = [];

  WeatherInfo({
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.wxPhraseLong,
    required this.relativeHumidity,
    required this.windSpeed,
    required this.validTimeLocal,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: json['temperature'],
      temperatureFeelsLike: json['temperatureFeelsLike'],
      wxPhraseLong: json['wxPhraseLong'],
      relativeHumidity: json['relativeHumidity'],
      windSpeed: json['windSpeed'],
      validTimeLocal: json['validTimeLocal'],
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherApp();
  }
}

class _WeatherApp extends State<WeatherApp> {
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
                  validTimeLocal: snapshot.data!.validTimeLocal[0],
                  temperature: snapshot.data!.temperature[0],
                  temperatureFeelsLike: snapshot.data!.temperatureFeelsLike[0],
                  wxPhraseLong: snapshot.data!.wxPhraseLong[0],
                  relativeHumidity: snapshot.data!.relativeHumidity[0],
                  windSpeed: snapshot.data!.windSpeed[0],
                  temps: snapshot.data!.temperature,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }),
        bottomNavigationBar: MyBottomNavBar());
  }
}
