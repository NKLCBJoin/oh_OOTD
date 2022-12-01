import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ootd/API/kakao.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/model/model.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:dart_date/dart_date.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
as smooth_page_indicator;

import 'dart:math';

import 'package:timer_builder/timer_builder.dart';
//최지철
class WeekootdPage extends StatefulWidget {
  WeekootdPage({this.parseDailyData});//재민 날짜별 날씨데이터 가져오기
  final dynamic parseDailyData;


  @override
  _WeekootdPageState createState() => _WeekootdPageState();
}

class _WeekootdPageState extends State<WeekootdPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? pageViewController;
  List <dynamic> tomorrows = [];
  Model model = Model();
  List <Widget> icons = []; // icon리스트
  //var day1 = List <double>.filled(4, 0.0); //json 파일에 오늘(09시~21시 3시간 간격 4개로 이루어짐) 내일부터 4일차까지는 00시부터 21시까지 7개
  var date = DateTime.now();

  String day1_time = '';


  var day = List <double>.filled(25, 10.0);
  List <double> day_max_t= [];
  List <int> i_max = [0,0,0,0];
  List <double> day_min_t= [0.0,0.0,0.0,0.0];
  List <int> i_min = [0,0,0,0];

//4 7 7 7
  void UpdateData (dynamic dailyData) async{

    //print("Yesterday: " + (Date.today - Duration(days: 1)).toString());
    // print(date);
    // var dates = date.toString().split(' ')[0].split('-')[2];
    for(var i = 0; i<7; i++)
      tomorrows.add(Date.today + Duration(days: i));
    var conditions = List<int>.filled(25, 0);
    for (var i = 0; i<25; i++)
    {
      conditions[i] = dailyData['list'][i]['weather'][0]['id'];
      print(conditions[i]);
    }


    day1_time = dailyData['list'][1]['dt_txt'].split(' ')[0];

    for (var i = 0; i < 25; i++) {
      day[i] = dailyData['list'][i]['main']['temp'].toDouble();
      print('day[${i}]: ${day[i]}');
    }


    for (var i = 0; i<1; i++)
      {
        day_max_t.add(max_s(day ,i_max[i], 4, 0)[0]);  // 1일차 최대온도 day_max_t[0] ~ 4일차 day_max_t[3]
        i_max[i] = max_s(day ,i_max[i], 4, 0)[1]; // 최대 온도의 아이콘을 가져오기 위한 순서 배열
        day_min_t[i] = min_s(day ,i_min[i], 4, 0)[0]; // 1일차 최저온도 day_min_t[0] ~ 4일차 day_min_t[3]
        i_min[i] = min_s(day,  i_min[i], 4, 0)[1];// 최저 온도의 아이콘을 가져오기 위한 순서 배열
      }
    for (var i = 1; i<4; i++)
    {
      day_max_t.add(max_s(day ,i_max[i], 4+7*i, 4+7*(i-1))[0]);
      i_max[i] = max_s(day ,i_max[i], 4+7*i, 4+7*(i-1))[1];
      day_min_t[i] = min_s(day ,i_min[i], 4+7*i, 4+7*(i-1))[0];
      i_min[i] = min_s(day,  i_min[i], 4+7*i, 4+7*(i-1))[1];
    }

    for(var i=0; i<4; i++)
      print("day_max_t[$i]: ${day_max_t[i]}");
    for(var i=0; i<4; i++)
      print("day_min_t[$i]: ${day_min_t[i]}");
    for(var i= 0; i<4; i++)
    {
      icons.add(model.getWeatherIcon(conditions[i_max[i]])!); //아이콘배열에 각 최대/최저 온도에 따른 아이콘 추가
      icons.add(model.getWeatherIcon(conditions[i_min[i]])!);
    }
    for(var i=0; i<4; i++)
      print("i_max: ${i_max[i]}");
    for(var i=0; i<4; i++)
      print("i_min: ${i_min[i]}");

  }
  dynamic max_s(List day, int temp, int length, int start){
    double maxdata= -10;
    for (var i = start; i < length; i++){
      maxdata = max(day[i],maxdata);
      if(maxdata == day[i])
        temp= i;
    }
    List <dynamic> a = [maxdata, temp];
    return a;
  }
  dynamic min_s(List day, int temp2, int length, int start){
    double mindata = 10;
    for (var i = start; i < length; i++){
      mindata = min(day[i],mindata);
      if(mindata == day[i])
        temp2= i;
    }
    List <dynamic> b = [mindata, temp2];
    return b;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateData(widget.parseDailyData);
  }
  String ?getSystemTime(){
    var now = DateTime.now();
    //var tomorrow = DateTime();
    return DateFormat("h:mm a").format(now);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            LoadingData.Lol = false;
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
          },
        ),
        //신근재/공유하기 버튼
        actions:<Widget> [
          KakaoShare()
        ],
        centerTitle: false,
      ),

      body: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      DarkMode.DarkOn? Color(0xff29323c) : Color(0xffa1c4fd), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                      DarkMode.DarkOn? Color(0xff485563) :Color(0xffc2e9fb),
                    ]
                )
            ),
            child: ListView(
              padding: EdgeInsetsDirectional.fromSTEB(10, 65, 10, 10),
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  width:MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: PageView(
                    controller: pageViewController ??=
                        PageController(initialPage: 0),
                   // padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Color(0xff2c4057) :Color(0xffeef5ff), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: DarkMode.DarkOn? Color(0xff29323c).withOpacity(0.9) :Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 6.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  children: [
                                    Text(
                                      'Today', //----첫째날
                                      style: GoogleFonts.kanit(
                                          fontSize: 30.0,
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              Language.En?'High${double.parse(day_max_t[0].toStringAsFixed(1))}°':'최고${double.parse(day_max_t[0].toStringAsFixed(1))}°',
                                              //'최고${double.parse(day_max_t[0].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[0]!,
                                            Text(
                                              '/',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              Language.En?'Low${double.parse(day_min_t[0].toStringAsFixed(1))}°':'최저${double.parse(day_min_t[0].toStringAsFixed(1))}°',
                                              //'최저${double.parse(day_min_t[0].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[1]!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, 0),
                                child:Icon(
                                  Icons.arrow_forward_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                  shadows: [
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Color(0xff2c4057) :Color(0xffeef5ff), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: DarkMode.DarkOn? Color(0xff29323c).withOpacity(0.9) :Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 6.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  children: [
                                    Text(
                                      //tomorrow.format(' EEEE '),
                                      DateFormat(' EEEE ').format(tomorrows[1]), //----둘째날
                                      style: GoogleFonts.kanit(
                                          fontSize: 30.0,
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              Language.En?'High${double.parse(day_max_t[1].toStringAsFixed(1))}°':'최고${double.parse(day_max_t[1].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[2]!,
                                            Text(
                                              '/',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              Language.En?'Low${double.parse(day_min_t[1].toStringAsFixed(1))}°':'최저${double.parse(day_min_t[1].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[3]!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child:Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, 0),
                                child:Icon(
                                  Icons.arrow_forward_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Color(0xff2c4057) :Color(0xffeef5ff), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: DarkMode.DarkOn? Color(0xff29323c).withOpacity(0.9) :Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 6.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat(' EEEE ').format(tomorrows[2]),//----셋째날
                                      style: GoogleFonts.kanit(
                                          fontSize: 30.0,
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              Language.En?'High${double.parse(day_max_t[2].toStringAsFixed(1))}°':'최고${double.parse(day_max_t[2].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[4]!,
                                            Text(
                                              '/',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              Language.En?'Low${double.parse(day_min_t[2].toStringAsFixed(1))}°':'최저${double.parse(day_min_t[2].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[5]!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child:Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, 0),
                                child:Icon(
                                  Icons.arrow_forward_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Color(0xff2c4057) :Color(0xffeef5ff), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: DarkMode.DarkOn? Color(0xff29323c).withOpacity(0.9) :Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 6.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat(' EEEE ').format(tomorrows[3]), //----넷째날
                                      style: GoogleFonts.kanit(
                                          fontSize: 30.0,
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              Language.En?'High${double.parse(day_max_t[3].toStringAsFixed(1))}°':'최고${double.parse(day_max_t[3].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[6]!,
                                            Text(
                                              '/',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              Language.En?'Low${double.parse(day_min_t[3].toStringAsFixed(1))}°':'최저${double.parse(day_min_t[3].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[7]!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child:Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, 0),
                                child:Icon(
                                  Icons.arrow_forward_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Color(0xff2c4057) :Color(0xffeef5ff), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: DarkMode.DarkOn? Color(0xff29323c).withOpacity(0.9) :Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 6.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat(' EEEE ').format(tomorrows[4]), //----다섯째날
                                      style: GoogleFonts.kanit(
                                          fontSize: 30.0,
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              Language.En?'High${double.parse(day_max_t[0].toStringAsFixed(1))}°':'최고${double.parse(day_max_t[0].toStringAsFixed(1))}°',

                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[4]!,
                                            Text(
                                              '/',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              Language.En?'Low${double.parse(day_min_t[0].toStringAsFixed(1))}°':'최저${double.parse(day_min_t[0].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[5]!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child:Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, 0),
                                child:Icon(
                                  Icons.arrow_forward_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Color(0xff2c4057) :Color(0xffeef5ff), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: DarkMode.DarkOn? Color(0xff29323c).withOpacity(0.9) :Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 6.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat(' EEEE ').format(tomorrows[5]), //----여섯째날
                                      style: GoogleFonts.kanit(
                                          fontSize: 30.0,
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              Language.En?'High${double.parse(day_max_t[0].toStringAsFixed(1))}°':'최고${double.parse(day_max_t[0].toStringAsFixed(1))}°',

                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[6]!,
                                            Text(
                                              '/',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              Language.En?'Low${double.parse(day_min_t[0].toStringAsFixed(1))}°':'최저${double.parse(day_min_t[0].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[7]!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child:Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1, 0),
                                child:Icon(
                                  Icons.arrow_forward_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Color(0xff2c4057) :Color(0xffeef5ff), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: DarkMode.DarkOn? Color(0xff29323c).withOpacity(0.9) :Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 6.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat(' EEEE ').format(tomorrows[6]), //----일곱째날
                                      style: GoogleFonts.kanit(
                                          fontSize: 30.0,
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              Language.En?'High${double.parse(day_max_t[0].toStringAsFixed(1))}°':'최고${double.parse(day_max_t[0].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[0]!,
                                            Text(
                                              '/',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              Language.En?'Low${double.parse(day_min_t[0].toStringAsFixed(1))}°':'최저${double.parse(day_min_t[0].toStringAsFixed(1))}°',
                                              style: GoogleFonts.lato(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                              ),
                                            ),
                                            icons[1]!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child:Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: smooth_page_indicator.SmoothPageIndicator(
                      controller: pageViewController ??=
                          PageController(initialPage: 0),
                      count: 7,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) {
                        pageViewController!.animateToPage(
                          i,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      effect: smooth_page_indicator.ExpandingDotsEffect(
                        expansionFactor: 2,
                        spacing: 8,
                        radius: 16,
                        dotWidth: 16,
                        dotHeight: 16,
                        dotColor: DarkMode.DarkOn? Colors.white:Color(0xFF9E9E9E),
                        activeDotColor: DarkMode.DarkOn? Colors.pink:Color(0xFF3F51B5),
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
