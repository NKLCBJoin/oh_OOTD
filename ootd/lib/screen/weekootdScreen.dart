import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/model/model.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'dart:math';
//최지철
class WeekootdPage extends StatefulWidget {
  WeekootdPage({this.parseDailyData});//재민 날짜별 날씨데이터 가져오기
  final dynamic parseDailyData;


  @override
  _WeekootdPageState createState() => _WeekootdPageState();
}

class _WeekootdPageState extends State<WeekootdPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Model model = Model();
  List <Widget> icons = []; // icon리스트
  var day1 = List <double>.filled(4, 0.0); //json 파일에 오늘(09시~21시 3시간 간격 4개로 이루어짐) 내일부터 4일차까지는 00시부터 21시까지 7개
  String day1_time = '';
  double day1_max_t =0.0;
  double day1_min_t = 0.0;
  int i1 = 0;
  int i2 = 0;
//4 7 7 7
  void UpdateData(dynamic dailyData) {

    var conditions = List<int>.filled(25, 0);
    for (var i = 0; i<25; i++)
    {
      conditions[i] = dailyData['list'][i]['weather'][0]['id'];
    }
    icons.add(model.getWeatherIcon(conditions[i1])!);
    icons.add(model.getWeatherIcon(conditions[i2])!);
    day1_time = dailyData['list'][1]['dt_txt'].split(' ')[0];
    day1_max_t = day1[0];
    day1_min_t = day1[0];
    for (var i = 0; i < 4; i++) {
      day1[i] = dailyData['list'][i]['main']['temp'].toDouble();
    }
    for (var i = 0; i < day1.length; i++){
      day1_max_t = max(day1[i],day1_max_t);
      i1 = max(i,i1);
    }
    for (var i = 0; i < day1.length; i++){
      day1_min_t = min(day1[i],day1_min_t);
      i2 = min(i,i2);
    }



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateData(widget.parseDailyData);
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
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
          },
        ),
        actions:<Widget> [
          IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            onPressed: ()  {
            },
          ),

        ],
        centerTitle: false,
      ),

      body: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffa1c4fd),
                      Color(0xffc2e9fb),
                    ]
                ),
            ),
            child: ListView(
              padding: EdgeInsetsDirectional.fromSTEB(10, 65, 10, 10),
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  width: double.infinity,
                  height: 830,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${day1_time}',
                                      style: GoogleFonts.kanit(
                                          textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                          fontSize: 30,
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0.98),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${double.parse(day1_max_t.toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 30.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      icons[0]!,
                                      Text(
                                        '/',
                                        style: GoogleFonts.lato(
                                          fontSize: 30.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        '${double.parse(day1_min_t.toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 30.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      icons[1]!,
                                      Text(
                                        '${day1_time}',
                                        style: GoogleFonts.lato(
                                          fontSize: 30.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Tuesday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tuseday',
                                        style: GoogleFonts.kanit(
                                            textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                            fontSize: 30,
                                            fontStyle: FontStyle.normal
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.04, 1),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${double.parse(day1_max_t.toStringAsFixed(1))}°',
                                          style: GoogleFonts.lato(
                                            fontSize: 30.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        icons[0]!,
                                        Text(
                                          '/',
                                          style: GoogleFonts.lato(
                                            fontSize: 30.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          '${double.parse(day1_min_t.toStringAsFixed(1))}°',
                                          style: GoogleFonts.lato(
                                            fontSize: 30.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        icons[1]!,
                                        Text(
                                          '${day1_time}',
                                          style: GoogleFonts.lato(
                                            fontSize: 30.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Thursday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Friday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Saturday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Sunday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
