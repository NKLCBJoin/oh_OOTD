// 이재민 로딩화면
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ootd/API/location.dart';
import 'package:ootd/API/network.dart';
import 'package:ootd/API/setlocation.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:ootd/screen/weather_screen.dart';
import 'package:ootd/model/model.dart';
import 'package:ootd/screen/weekootdScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apikey = '4293fbff2c2e4d5c80ce32cea6e1b5be';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}
enum RGB {red, green, blue }
class _LoadingState extends State<Loading> {

  void getLocation() async {
    location_func location2 =  location_func();

    if(location.loding_value ==1){
      await location2.Nowlocation();
      await location2.geolocation_func();
    }
    else if(location.loding_value==2){
      await location2.fetchData();
      location.loding_value=1;
    }




    // MyLocation location = MyLocation();
    // await location.getMyCurrentLocation();
    // print(location.longtitude2);
    // print(location.latitude2);

    Network network = Network(
        Language.En ? 'https://api.openweathermap.org/data/2.5/weather?'
            'lat=${location.y_pos}&lon=${location.x_pos}&appid=$apikey&lang=en&units=metric' :
        'https://api.openweathermap.org/data/2.5/weather?'
            'lat=${location.y_pos}&lon=${location.x_pos}&appid=$apikey&lang=kr&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${location.y_pos}&lon=${location.x_pos}&appid=$apikey',
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.y_pos}&lon=${location.x_pos}&appid=$apikey&units=metric');
    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    var hourData = await network.getHourData();
    print(hourData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
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
    void getLocation2() async{
      MyLocation location = MyLocation();
      await location.getMyCurrentLocation();
      print(location.longtitude2);
      print(location.latitude2);

      Network2 network = Network2('https://api.openweathermap.org/data/2.5/forecast?lat='
          '${location.latitude2}&lon=${location.longtitude2}&appid=$apikey&units=metric');

      var dailyData = await network.getDailyData();
      print(dailyData);

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return WeekootdPage(parseDailyData: dailyData,
        );
      }));
    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingData.Lol? getLocation2() : getLocation();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  DarkMode.DarkOn? Color(0xff485563) :Color(0xffc2e9fb),
        body: Center(
          child: SpinKitFadingFour(
            color: DarkMode.DarkOn? Colors.white:Color(0xff485563),
            size: 80,
          ),
          ),
      );
  }
}
