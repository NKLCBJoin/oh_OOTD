
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
        'lat=${location.latitude2}&lon=${location.longtitude2}&appid=$apikey&units=metric');
    var weatherData = await network.getJsonData();
    print(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              PopupMenuButton<RGB>(
                onSelected: (RGB result){
                  setState(() {
                    if(result ==RGB.red)
                      Navigator.pushNamed(context, '/b');
                    else if(result==RGB.blue)
                      getLocation();
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry <RGB>>[
                  const PopupMenuItem<RGB>(
                    value: RGB.red,
                    child: Text('카카오톡 로그인'),
                  ),
                  const PopupMenuItem<RGB>(
                    value: RGB.green,
                    child: Text('지도'),
                  ),
                  const PopupMenuItem<RGB>(
                    value: RGB.blue,
                    child: Text('위치 받기'),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(10),
              ),
            ],
          )
        )
    );
  }
}
