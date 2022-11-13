// 이재민 메인화면 (날씨정보 및 아이콘 등이 나옴)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ootd/API/location.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:ootd/model/model.dart';

const List<String> list = <String>['카카오톡 로그인','주간OOTD','알람'];

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}
enum RGB {a, b, c }
class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();

  var date = DateTime.now();
  Widget ?icon;

  String cityName = 'cityName';
  String weather = 'weather';
  double min_temp = 10;
  double max_temp = 10;
  double temp = 10;
  double pressure= 1000;
  double humidity= 50;
  double wind_speed = 1;
  double feel_temp = 10;
  Widget? airIcon;
  Widget? airCondition;
  double pm2_5 = 0;
  double pm10 = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateData(widget.parseWeatherData, widget.parseAirPollution);
  }
  String ?getSystemTime(){
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }
  void UpdateData(dynamic weatherData, dynamic airData){
    int condition = weatherData['weather'][0]['id'];
    temp = weatherData['main']['temp'];
    min_temp = weatherData['main']['temp_min'];
    max_temp = weatherData['main']['temp_max'];
    feel_temp = weatherData['main']['feels_like'];
    pressure = weatherData['main']['pressure'];
    humidity = weatherData['main']['humidity'];
    wind_speed = weatherData['wind']['speed'];
    weather = weatherData['weather'][0]['description'];
    cityName = weatherData['name'];

    int index =airData['list'][0]['main']['aqi'];  // 미세먼지 AQI(인덱스값)
    icon = model.getWeatherIcon(condition); // 날씨 아이콘 가져오기
    airCondition = model.getAirCondition(index);
    airIcon= model.getAirIcon(index);

    pm2_5 = airData['list'][0]['components']['pm2_5']; //초미세먼지
    pm10 = airData['list'][0]['components']['pm10']; //미세먼지

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text('메뉴'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: PopupMenuButton<RGB>(
          onSelected: (RGB result){
            setState(() {
             // if(result ==RGB.a)
               // Navigator.pushNamed(context, '/b');
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry <RGB>>[
            const PopupMenuItem<RGB>(
              value: RGB.a,
              child: Text('카카오톡 로그인'),
            ),
            const PopupMenuItem<RGB>(
              value: RGB.b,
              child: Text('주간OOTD'),
            ),
            const PopupMenuItem<RGB>(
              value: RGB.c,
              child: Text('알람'),
            ),
          ],
        ),
        actions:[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
            iconSize: 30.0,
          )
        ]
      ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Image.asset('background.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150.0,
                        ),
                        Text(
                          'Gumi',
                          style: GoogleFonts.lato(
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            TimerBuilder.periodic(
                                (Duration(minutes: 1)),
                            builder: (context){
                                  print('${getSystemTime()}');
                                  return Text(
                                      '${getSystemTime()}',
                                    style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: Colors.white
                                    ),
                                  );
                              },
                            ),
                            Text(
                              DateFormat(' - EEEE, ').format(date),
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              DateFormat('d MMM, yyy ').format(date),
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        Text  (
                          '$temp°C',
                          style: GoogleFonts.lato(
                              fontSize: 85.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text  (
                              '최대기온:',
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Text  (
                              '$max_temp°C',
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Text  (
                              '최저기온:',
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Text  (
                              '$min_temp°C',
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Text  (
                              '체감기온:',
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Text  (
                              '$feel_temp°C',
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ],
                        ),

                      ]
                    ),
                    Row(
                      children: [
                        icon!,
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                         '$weather',
                          style: GoogleFonts.lato(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 15.0,
                      thickness: 2.0,
                      color: Colors.white30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'SQI(대기질지수)',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            airIcon!,
                            airCondition!,
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '미세먼지',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$pm10',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '㎍/m³',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '초미세먼지',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$pm2_5',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '㎍/m³',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset('kakao_login_medium.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
