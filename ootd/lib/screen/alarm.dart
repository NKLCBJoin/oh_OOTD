//알람 UI
//신근재, 최지철
//코드량이 길고 복잡해서 반드시 정리 및 함수화? 과정 통해 코드수 줄이는 작업 필요
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/model/model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:io';

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
  static int i=0;

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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: AlarmState.AlarmCount,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient:AlarmState.AlarmOnOff[index]?  LinearGradient(
                            colors:  [
                              DarkMode.DarkOn? Color(0xff30cfd0) : Color(0xff64b3f4), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                              DarkMode.DarkOn? Color(0xff330867) :Color(0xffc2e59c),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ):LinearGradient(
                            colors:  [
                              Color(0xff596164),
                              Color(0xff596164),
                            ],
                          ),
                          //color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: DarkMode.DarkOn? Color(0xff330867).withOpacity(0.5) :Color(0xff64b3f4).withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6.0,
                              offset: Offset(4, 6), // changes position of shadow
                            ),
                          ],
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
                                        fontStyle: FontStyle.normal,
                                      textStyle: TextStyle(
                                        color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                      ),
                                    ):GoogleFonts.jua(
                                        fontSize: 30.0,
                                        fontStyle: FontStyle.normal,
                                      textStyle: TextStyle(
                                        color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                      ),
                                    ),

                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                      child: Text(
                                        '${AlarmState.AlarmInfo[index][0].toString().padLeft(2,"0")}:${AlarmState.AlarmInfo[index][1].toString().padLeft(2,"0")}${AlarmState.AlarmInfo[index][2]}',
                                        style: Language.En?GoogleFonts.kanit(
                                            fontSize: 20.0,
                                          textStyle: TextStyle(
                                        color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(5.0, 5.0),
                                                blurRadius: 10.0,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                        ),
                                        ):GoogleFonts.jua(
                                            fontSize: 20.0,
                                          textStyle: TextStyle(
                                            color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(5.0, 5.0),
                                                blurRadius: 10.0,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 0),
                                      child: Text(AlarmState.repeat?'${AlarmState.AlarmInfo[index][3]}':'',
                                        style: Language.En?
                                        GoogleFonts.kanit(
                                            fontSize: 15.0,
                                          textStyle: TextStyle(
                                            color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                          ),
                                        ):GoogleFonts.jua(
                                            fontSize: 20.0,
                                          textStyle: TextStyle(
                                            color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),

                                    for(int i=0;i<7;i++)...{
                                      if(AlarmState.day[index][i]==true)...{
                                        Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                        child:
                                        Text('${AlarmState.dayString[index][i]}',
                                          style: Language.En?GoogleFonts.kanit(
                                              fontSize: 12.0,
                                            textStyle: TextStyle(
                                              color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                            ),
                                          ):GoogleFonts.jua(
                                              fontSize: 20.0,
                                            textStyle: TextStyle(
                                              color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                            ),
                                          ),
                                        ),
                                        ),
                                      },
                                    },
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

                                  Switch(
                                      activeColor:DarkMode.DarkOn? Colors.pinkAccent:Colors.cyan,
                                      activeTrackColor:DarkMode.DarkOn? Colors.pink.withOpacity(0.4):Colors.cyan.withOpacity(0.4),
                                      value: AlarmState.AlarmOnOff[index], onChanged:(newValue) async{
                                    setState(() {

                                      AlarmState.AlarmOnOff[index]=newValue;

                                    });
                                  }
                                  ),
                                  IconButton(onPressed: (){//알람삭제
                                    setState(() {
                                      if(index!=1&&index+1!=null)
                                      {
                                       for(int i=index;i<AlarmState.AlarmCount;i++)
                                       {
                                         if(i+1<=AlarmState.AlarmCount){
                                         AlarmState.AlarmInfo[i][0]=AlarmState.AlarmInfo[i+1][0];
                                         AlarmState.AlarmInfo[i][1]=AlarmState.AlarmInfo[i+1][1];
                                         AlarmState.AlarmInfo[i][2]=AlarmState.AlarmInfo[i+1][2];
                                         }
                                       }
                                       AlarmState.AlarmCount--;
                                      }else{
                                        AlarmState.AlarmCount--;
                                      }
                                    }
                                    );
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
                  color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                  strokeWidth: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){//추가 버튼
                          AlarmState.repeat=false;
                         AlarmState.day[AlarmState.AlarmCount]=[false,false,false,false,false,false,false];
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
                                                                        });
                                                                      }
                                                                      else if (AlarmState.AM == false) {
                                                                        setState(() {
                                                                          AlarmState. AM = true;
                                                                          AlarmState.PM = false;
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
                                                                      });
                                                                    }

                                                                    else if (AlarmState.PM == false) {
                                                                      setState(() {
                                                                        AlarmState.PM = true;
                                                                        AlarmState.AM = false;
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
                                                                  title: AlarmState.AlarmInfo[AlarmState.AlarmCount][0] == i ? Text('${i.toString().padLeft(2,"0")}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white: Colors.black)) : Text('${i.toString().padLeft(2,"0")}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white12: Colors.black12)),
                                                                  onTap: (){
                                                                    setState(() {
                                                                      AlarmState.AlarmInfo[AlarmState.AlarmCount][0]=i;
                                                                      AlarmState.hour == i;
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
                                                                  title: AlarmState.AlarmInfo[AlarmState.AlarmCount][1] == i ? Text('${i.toString().padLeft(2,"0")}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white: Colors.black)) : Text('${i.toString().padLeft(2,"0")}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white12: Colors.black12)),
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
                                                        Text(Language.En?'every week':'매주 반복', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: Language.En?20:30,),),
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
                                                                      setState(() {
                                                                        if (AlarmState.repeat == true) {
                                                                          AlarmState.AlarmInfo[AlarmState.AlarmCount][3] =Language.En?'Every':"매주";

                                                                          AlarmState.repeat = false;
                                                                        }
                                                                      });
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
                                                        onPressed: () {
                                                          setState((){AlarmState.day[AlarmState.AlarmCount][6] = !AlarmState.day[AlarmState.AlarmCount][6];
                                                          AlarmState.dayString[AlarmState.AlarmCount][6]=Language.En?'Sun':'일';
                                                        });},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.day[AlarmState.AlarmCount][6] == false ? Text(Language.En?'Sun':'일', style: TextStyle(color: Colors.redAccent, fontSize: Language.En?20:30)) :
                                                        Text(Language.En?'Sun':'일', style: TextStyle(color: Colors.red, fontSize: Language.En?20:30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){
                                                          AlarmState.day[AlarmState.AlarmCount][0] = !AlarmState.day[AlarmState.AlarmCount][0];
                                                          AlarmState.dayString[AlarmState.AlarmCount][0]=Language.En?'Mon ':'월';
                                                        });},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.day[AlarmState.AlarmCount][0] == false ? Text(Language.En?'Mon':'월', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: Language.En?20:30)) :
                                                        Text(Language.En?'Mon':'월', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: Language.En?20:30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.day[AlarmState.AlarmCount][1] = !AlarmState.day[AlarmState.AlarmCount][1];
                                                        AlarmState.dayString[AlarmState.AlarmCount][1]=Language.En?'Tue ':'화';
                                                        });},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.day[AlarmState.AlarmCount][1] == false ? Text(Language.En?'Tue':'화', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: Language.En?20:30)) :
                                                        Text(Language.En?'Tue':'화', style: TextStyle(color:DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: Language.En?20:30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.day[AlarmState.AlarmCount][2] = !AlarmState.day[AlarmState.AlarmCount][2];
                                                        AlarmState.dayString[AlarmState.AlarmCount][2]=Language.En?'Wen ':'수';
                                                        });},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.day[AlarmState.AlarmCount][2] == false ? Text(Language.En?'Wen':'수', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: Language.En?20:30)) :
                                                        Text(Language.En?'Wen':'수', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: Language.En?20:30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.day[AlarmState.AlarmCount][3] = !AlarmState.day[AlarmState.AlarmCount][3];
                                                        AlarmState.dayString[AlarmState.AlarmCount][3]=Language.En?'Thr ':'목';
                                                        });},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.day[AlarmState.AlarmCount][3] == false ? Text(Language.En?'Thr':'목', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: Language.En?20:30)) :
                                                        Text(Language.En?'Thr':'목', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: Language.En?20:30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.day[AlarmState.AlarmCount][4] = !AlarmState.day[AlarmState.AlarmCount][4];
                                                        AlarmState.dayString[AlarmState.AlarmCount][4]=Language.En?'Fri ':'금';
                                                        });},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child: AlarmState.day[AlarmState.AlarmCount][4] == false ? Text(Language.En?'Fri':'금', style: TextStyle(color:DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: Language.En?20:30)) :
                                                        Text(Language.En?'Fri':'금', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: Language.En?20:30,decoration: TextDecoration.underline, )
                                                        ),
                                                      ),
                                                    ),

                                                    Flexible(fit: FlexFit.tight,
                                                      child: ElevatedButton(
                                                        onPressed: () {setState((){AlarmState.day[AlarmState.AlarmCount][5] = !AlarmState.day[AlarmState.AlarmCount][5];
                                                        AlarmState.dayString[AlarmState.AlarmCount][5]=Language.En?'Sat':'토';
                                                        });},
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                                                            padding: MaterialStatePropertyAll(EdgeInsets.all(0))
                                                        ),
                                                        child:AlarmState.day[AlarmState.AlarmCount][5] == false ? Text(Language.En?'Sat':'토', style: TextStyle(color: Colors.blue, fontSize: Language.En?20:30)) :
                                                        Text(Language.En?'Sat':'토', style: TextStyle(color: Colors.blue, fontSize: Language.En?20:30,decoration: TextDecoration.underline, )
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
                                                        for(int i=0;i<7;i++){
                                                        print('${AlarmState.dayString[AlarmState.AlarmCount][i]}');
                                                        }
                                                        setState(() {
                                                          if(AlarmState.AM==true){
                                                            AlarmState.AlarmInfo[AlarmState.AlarmCount][2]="AM";
                                                          }else{
                                                            AlarmState.AlarmInfo[AlarmState.AlarmCount][2]="PM";
                                                          }
                                                          print('${AlarmState.AlarmInfo[AlarmState.AlarmCount][0]}:${AlarmState.AlarmInfo[AlarmState.AlarmCount][1].toString()}${AlarmState.AlarmInfo[AlarmState.AlarmCount][2]}',
                                                          );
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
                              color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                              size: 30,
                            )
                        ),
                        Text('add',
                        style:TextStyle(
                         color:  DarkMode.DarkOn? Colors.white70:Colors.black87,
                        ),
                        ),
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
