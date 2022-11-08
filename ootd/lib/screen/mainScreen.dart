//최지철 child: WeatherBg(weatherType: WeatherType.sunny,width: 300,height: 300,)
import 'package:flutter/widgets.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
class background extends StatelessWidget{
  const background({Key?key}):super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      child: WeatherBg(weatherType: WeatherType.thunder,width: 540,height: 932,)
    );
  }
}