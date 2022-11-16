//최지철 발표용 임시 Ui디자인 스크린임다~
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter/material.dart';
class tempHomePageWidget extends StatefulWidget {
  const tempHomePageWidget({Key? key}) : super(key: key);

  @override
  _tempHomePageWidgetState createState() => _tempHomePageWidgetState();
}

class _tempHomePageWidgetState extends State<tempHomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: GridView(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.sunny,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.thunder,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.sunnyNight,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),

              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.overcast,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.lightSnow,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.dusty,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.hazy,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.heavyRainy,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.heavySnow,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.lightRainy,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.lightSnow,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                child: (
                    WeatherBg(weatherType: WeatherType.middleRainy,width: 100,height: 150,)
                ),
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
