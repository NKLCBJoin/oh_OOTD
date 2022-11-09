import 'dart:html';

import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData});
  final dynamic parseWeatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = 'cityName';
  String weather = 'weather';
  double min_temp = 10;
  double max_temp = 10;
  double temp = 10;
  double pressure= 1000;
  double humidity= 50;
  double wind_speed = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateData(widget.parseWeatherData);
  }
  void UpdateData(dynamic weatherData){
    temp = weatherData['main']['temp'];
    min_temp = weatherData['main']['temp_min'];
    max_temp = weatherData['main']['temp_max'];
    pressure = weatherData['main']['pressure'];
    humidity = weatherData['main']['humidity'];
    wind_speed = weatherData['wind']['speed'];
    weather = weatherData['weather'][0]['main'];
    cityName = weatherData['name'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '도시이름: $cityName',
                style: TextStyle(
                  fontSize: 30.0
                ),
              ),
              Text(
                '날씨: $weather',
                style: TextStyle(
                    fontSize: 30.0
                ),
              ),
              Text(
                '온도: $temp 최대온도: $max_temp 최소온도: $min_temp',
                style: TextStyle(
                    fontSize: 30.0
                ),
              ),
              Text(
                '기압: $pressure hpa',
                style: TextStyle(
                    fontSize: 30.0
                ),
              ),
              Text(
                '습도: $humidity %',
                style: TextStyle(
                    fontSize: 30.0
                ),
              ),Text(
                '바람속도: $wind_speed m/s',
                style: TextStyle(
                    fontSize: 30.0
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
