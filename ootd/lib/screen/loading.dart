// 이재민 로딩화면
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ootd/API/location.dart';
import 'package:ootd/API/network.dart';
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
  void getLocation() async{
    MyLocation location = MyLocation();
    await location.getMyCurrentLocation();
    print(location.longtitude2);
    print(location.latitude2);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?'
        'lat=${location.latitude2}&lon=${location.longtitude2}&appid=$apikey&lang=kr&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${location.latitude2}&lon=${location.longtitude2}&appid=$apikey');
    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
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
