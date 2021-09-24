import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sensora_test2/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

Future<WeatherInfo> fetchWeather() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium);

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
  var validTimeLocal = [];
  var temperature = [];
  var temperatureFeelsLike = [];
  var wxPhraseLong = [];
  var relativeHumidity = [];
  var windSpeed = [];
  var iconCode = [];
  var dayOfWeek = [];

  WeatherInfo({
    required this.validTimeLocal,
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.wxPhraseLong,
    required this.relativeHumidity,
    required this.windSpeed,
    required this.iconCode,
    required this.dayOfWeek,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      validTimeLocal: json['validTimeLocal'],
      temperature: json['temperature'],
      temperatureFeelsLike: json['temperatureFeelsLike'],
      wxPhraseLong: json['wxPhraseLong'],
      relativeHumidity: json['relativeHumidity'],
      windSpeed: json['windSpeed'],
      iconCode: json['iconCode'],
      dayOfWeek: json['dayOfWeek'],
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
  late String currentAddress;
  late SharedPreferences loginData;
  List<String>? selectedVegies = [];

  @override
  void initState() {
    super.initState();
    getAddress();
    futureWeather = fetchWeather();
  }

  void getAddress() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> p =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<WeatherInfo>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainWidget(
                  location: currentAddress,
                  temperature: snapshot.data!.temperature[0],
                  temperatureFeelsLike: snapshot.data!.temperatureFeelsLike[0],
                  wxPhraseLong: snapshot.data!.wxPhraseLong[0],
                  relativeHumidity: snapshot.data!.relativeHumidity[0],
                  windSpeed: snapshot.data!.windSpeed[0],
                  temps: snapshot.data!.temperature,
                  iconCode: snapshot.data!.iconCode[0],
                  weather_icons: snapshot.data!.iconCode,
                  dayOfWeek: snapshot.data!.dayOfWeek,
                  validTimeLocal: snapshot.data!.validTimeLocal,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              );
            }),
        bottomNavigationBar: MyBottomNavBar());
  }
}
