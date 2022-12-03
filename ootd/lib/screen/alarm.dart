//알람 UI
//신근재, 최지철
//코드량이 길고 복잡해서 반드시 정리 및 함수화? 과정 통해 코드수 줄이는 작업 필요
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/model/model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '알람 기능 테스트',
      home: Alarm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  //오전인지 오후인지

  //DB에 저장된 정보 불러오기
  bool savedb_first = true;
  bool save_AM_first = false;
  int save_hour_first = 1;
  int save_minute_fisrt = 1;

  bool savedb_second = false;
  bool save_AM_second = false;
  int save_hour_second = 1;
  int save_minute_second = 1;

  bool? switchValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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
        ),
        body:Container(
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
            padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 10),
            scrollDirection: Axis.vertical,
            children: [

              ListView.builder(
                 scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: AlarmState.AlarmCount,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsetsDirectional.fromSTEB(100, 10, 0, 0),
                                  child: Text(
                                    Language.En?'Alarm':'알람',
                                    style: Language.En?GoogleFonts.kanit(
                                        fontSize: 30.0,
                                        fontStyle: FontStyle.normal
                                    ):GoogleFonts.jua(
                                        fontSize: 30.0,
                                        fontStyle: FontStyle.normal
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(70, 5, 0, 0),
                                      child: Text(
                                        '월-목',
                                        style: Language.En?GoogleFonts.kanit(
                                            fontSize: 20.0
                                        ):GoogleFonts.jua(
                                            fontSize: 20.0
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                      child: Text(
                                        '${AlarmState.hour.toString()}:${AlarmState.minute.toString()}${AlarmState.AmPm}',
                                        style: Language.En?GoogleFonts.kanit(
                                            fontSize: 20.0
                                        ):GoogleFonts.jua(
                                            fontSize: 20.0
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Switch(value: switchValue??=true, onChanged:(newValue) async{
                                   setState(() {
                                     switchValue=newValue!;
                                   });
                                  }
                                  ),
                                  IconButton(onPressed: (){

                                  }, icon: Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              Padding( padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 10),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(20),
                  dashPattern: [10, 10],
                  color: Colors.black,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                          showDialog(
                              context: context,
                              barrierDismissible: false, // 바깥 터치해도 닫히는지
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder:(BuildContext context, StateSetter setState){
                                    return Dialog(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: DarkMode.DarkOn? Color(0xff29323c) : Colors.white.withOpacity(.94),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: MediaQuery.of(context).padding.top),
                                            //<-----------------시간 설정----------------------->
                                            Flexible(
                                              flex: 8,
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        color: Colors.transparent,
                                                        child: Column(
                                                          children: [
                                                            Flexible(flex: 1, child: Container(),), Flexible(flex: 1, child: Container(),),

                                                            Flexible(
                                                                flex: 1,
                                                                child: ElevatedButton(
                                                                    onPressed: () {
                                                                      if (AlarmState.AM == true) {
                                                                        setState(() {
                                                                          AlarmState.AM = false;
                                                                          AlarmState.PM = true;
                                                                          AlarmState. AmPm="AM";
                                                                          print(AlarmState.AmPm);
                                                                        });
                                                                      }
                                                                      else if (AlarmState.AM == false) {
                                                                        setState(() {
                                                                          AlarmState. AM = true;
                                                                          AlarmState.PM = false;
                                                                          AlarmState. AmPm="AM";
                                                                          print(AlarmState.AmPm);
                                                                        });
                                                                      }
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                        elevation: MaterialStateProperty.all(0.0),
                                                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),)
                                                                    ),
                                                                    child: AlarmState.AM == true ? Text(Language.En?'Am':'오전', style: TextStyle(fontSize: 40, color:DarkMode.DarkOn?  Colors.white: Colors.black),):Text(Language.En?'Am':'오전', style: TextStyle(fontSize: 40, color: DarkMode.DarkOn?  Colors.white12: Colors.black12),)
                                                                )
                                                            ),

                                                            Flexible(flex: 1, child: Container(),),

                                                            //오후 버튼
                                                            Flexible(
                                                              flex: 1,
                                                              child: ElevatedButton(
                                                                  onPressed: (){
                                                                    if (AlarmState.PM == true) {
                                                                      setState(() {
                                                                        AlarmState.PM = false;
                                                                        AlarmState.AM = true;
                                                                        AlarmState.AmPm="Pm";
                                                                      });
                                                                    }

                                                                    else if (AlarmState.PM == false) {
                                                                      setState(() {
                                                                        AlarmState.PM = true;
                                                                        AlarmState.AM = false;
                                                                        AlarmState.AmPm="Pm";
                                                                      });
                                                                    }
                                                                  },
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                    elevation: MaterialStateProperty.all(0.0),
                                                                  ),
                                                                  child: AlarmState.PM == true ? Text(Language.En?'Pm':'오후', style: TextStyle(fontSize: 40, color: DarkMode.DarkOn?  Colors.white: Colors.black),):Text(Language.En?"Pm":'오후', style: TextStyle(fontSize: 40, color: DarkMode.DarkOn?  Colors.white12: Colors.black12),)
                                                              ),),
                                                            Flexible(flex: 1, child: Container(),),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    //알람 시간 정하기
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                          color: Colors.transparent,
                                                          child: ListView(
                                                            children: [
                                                              for (int i = 1; i < 13; i++)
                                                                ListTile(
                                                                  title: AlarmState.hour == i ? Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white: Colors.black)) : Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white12: Colors.black12)),
                                                                  onTap: (){
                                                                    setState(() {
                                                                      AlarmState.AlarmInfo[AlarmState.AlarmCount][0]=i;
                                                                      print(AlarmState.AlarmInfo[AlarmState.AlarmCount][0]);
                                                                    });
                                                                  },
                                                                  focusColor: Colors.amber,
                                                                  selectedColor: Colors.amber,
                                                                  hoverColor: Colors.amber,
                                                                  selectedTileColor: Colors.amber,
                                                                ),
                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                    //알림 분 정하기
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                          color: Colors.transparent,
                                                          child: ListView(
                                                            children: [
                                                              for (int i = 0; i < 60; i++)
                                                                ListTile(
                                                                  title: AlarmState.minute == i ? Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white: Colors.black)) : Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white12: Colors.black12)),
                                                                  onTap: (){
                                                                    setState(() {
                                                                      AlarmState.AlarmInfo[AlarmState.AlarmCount][1]=i;
                                                                      print(AlarmState.AlarmInfo[AlarmState.AlarmCount][1]);
                                                                    });
                                                                  } ,
                                                                ),

                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            //<-----------------매주 반복 여부----------------------->
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                  color: Colors.transparent,
                                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                  child: Row(
                                                      children: [
                                                        SizedBox(width : 10),
                                                        Text(Language.En?'every week':'매주 반복', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,),),
                                                        SizedBox(width : 10),

                                                        Container(
                                                            padding: EdgeInsets.all(5),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: DarkMode.DarkOn?  Colors.white: Colors.black, width: 2),
                                                                borderRadius: BorderRadius.circular(20)),
                                                            child: Row(
                                                              children: [
                                                                ElevatedButton(
                                                                    onPressed: (){
                                                                      if (AlarmState.repeat == false) {
                                                                        setState(() {
                                                                          AlarmState.repeat = true;
                                                                        });
                                                                      }
                                                                    },
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                      elevation: MaterialStateProperty.all(0.0),
                                                                    ),
                                                                    child: AlarmState.repeat == true ? Text('On', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,)):Text('On', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30))
                                                                ),

                                                                ElevatedButton(
                                                                    onPressed: (){
                                                                      if (AlarmState.repeat == true) {
                                                                        setState(() {
                                                                          AlarmState.repeat = false;
                                                                        });
                                                                      }
                                                                    },
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                      elevation: MaterialStateProperty.all(0.0),
                                                                    ),
                                                                    child: AlarmState.repeat == false ? Text('Off', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,)):Text('Off', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30))
                                                                ),
                                                              ],
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              ),
                                            ),

                                            ////<-----------------요일 체크----------------------->
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                color: Colors.transparent,
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                child: Row(
                                                  children: [
                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.sun = !AlarmState.sun;});},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.sun == false ? Text(Language.En?'Sun':'일', style: TextStyle(color: Colors.redAccent, fontSize: 30)) :
                                                        Text(Language.En?'Sun':'일', style: TextStyle(color: Colors.red, fontSize: 30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.mon = !AlarmState.mon;});},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.mon == false ? Text(Language.En?'Mon':'월', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                                                        Text(Language.En?'Mon':'월', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.tue = !AlarmState.tue;});},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.tue == false ? Text(Language.En?'Tue':'화', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                                                        Text(Language.En?'Tue':'화', style: TextStyle(color:DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.wed = !AlarmState.wed;});},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.wed == false ? Text(Language.En?'Wen':'수', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                                                        Text(Language.En?'Wen':'수', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.thu = !AlarmState.thu;});},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.thu == false ? Text(Language.En?'Thr':'목', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                                                        Text(Language.En?'Thr':'목', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.fri = !AlarmState.fri;});},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.fri == false ? Text(Language.En?'Fri':'금', style: TextStyle(color:DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                                                        Text(Language.En?'Fri':'금', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.sat = !AlarmState.sat;});},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.sat == false ? Text(Language.En?'Sat':'토', style: TextStyle(color: Colors.blue, fontSize: 30)) :
                                                        Text(Language.En?'Sat':'토', style: TextStyle(color: Colors.blue, fontSize: 30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(flex: 1, child: Container(color: Colors.transparent,),),

                                            //<--------------취소, 저장 버튼---------------->
                                            Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  Flexible(fit: FlexFit.tight,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ElevatedButton(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                              elevation: MaterialStateProperty.all(0.0)),
                                                          child: Text(Language.En?'Cancel':'취소',
                                                            style: TextStyle(color:  DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,),
                                                          ),
                                                        ),
                                                      )
                                                  ),

                                                  Flexible(fit: FlexFit.tight,
                                                    child: ElevatedButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          AlarmState.AlarmCount++;
                                                          print(AlarmState.AlarmCount);
                                                          Navigator.pop(context);
                                                          Navigator.push(context, MaterialPageRoute(builder: (_)=>Alarm()));
                                                        });
                                                        // bool타입은 AM을 제외하고 기본적 false입니다.
                                                        // bool타입 AM, PM
                                                        // bool타입 week
                                                        // int타입 hour, minute
                                                        // bool타입 mon tue wed thu fri sat sun
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                          elevation: MaterialStateProperty.all(0.0)
                                                      ),
                                                      child: Text(Language.En?'Save':'저장',
                                                        style: TextStyle(color:  DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30, ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ) ,
                                    );
                                  },
                                );
                              }
                          );
                        },
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 30,
                            )
                        ),
                        Text('add'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
