// 이재민 로딩화면
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ootd/API/location.dart';
import 'package:ootd/API/network.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:ootd/screen/weather_screen.dart';

const apikey = '4293fbff2c2e4d5c80ce32cea6e1b5be';

class Loading2 extends StatefulWidget {
  const Loading2({Key? key}) : super(key: key);

  @override
  State<Loading2> createState() => _Loading2State();
}
enum RGB {red, green, blue }
class _Loading2State extends State<Loading2> {

  void getLocation2() async{
    MyLocation location = MyLocation();
    await location.getMyCurrentLocation();
    print(location.longtitude2);
    print(location.latitude2);

    Network2 network = Network2('https://pro.openweathermap.org/data/2.5/forecast/hourly?q=Gumi&appid=$apikey');
    var weatherData = await network.getHourWeatherData(); //시간대별 날씨정보

    print(weatherData);
    ;

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation2();
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
