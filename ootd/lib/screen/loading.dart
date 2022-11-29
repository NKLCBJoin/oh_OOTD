// 이재민 로딩화면
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ootd/API/location.dart';
import 'package:ootd/API/network.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:ootd/screen/weather_screen.dart';

const apikey = '4293fbff2c2e4d5c80ce32cea6e1b5be';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}
enum RGB {red, green, blue }
class _LoadingState extends State<Loading> {


  String ?CityName;
  var a=0;
  void getLocation() async{
    MyLocation location = MyLocation();
    await location.getMyCurrentLocation();
    print(location.longtitude2);
    print(location.latitude2);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?'
        'lat=${location.latitude2}&lon=${location.longtitude2}&appid=$apikey&lang=en&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${location.latitude2}&lon=${location.longtitude2}&appid=$apikey',
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude2}&lon=${location.longtitude2}&appid=$apikey&units=metric');
    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    var hourData = await network.getHourData();
    print(hourData);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HomePageWidget(parseWeatherData: weatherData,
        parseAirPollution: airData, parseHourData: hourData,
      );
    }));
    /*Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));*/
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator()
              ],
          )
        )
    );
  }
}
