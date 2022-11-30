//알람 UI
//신근재 작업
//코드량이 길고 복잡해서 반드시 정리 및 함수화? 과정 통해 코드수 줄이는 작업 필요
import 'package:flutter/material.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/model/model.dart';

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
  bool AM = true;
  bool PM = false;

  //주간 반복 여부
  bool repeat = false;

  //설정한 시간, 분
  int hour = 1;
  int minute = 0;

  //요일 설정 여부 값
  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;

  //DB에 저장된 정보 불러오기
  bool savedb_first = true;
  bool save_AM_first = false;
  int save_hour_first = 1;
  int save_minute_fisrt = 1;

  bool savedb_second = false;
  bool save_AM_second = false;
  int save_hour_second = 1;
  int save_minute_second = 1;

  //<---------저장된 알람 불러오는 함수------------->
  getSaved_Alarm() {
    if(savedb_first == true) {
      return Container(
        child: Column(
          children: [
            //<-------------------저장된 알람1------------------------>
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: DarkMode.DarkOn?  Colors.white: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Flexible(flex: 1, child: Container(color: Colors.transparent,),),

                    Flexible(
                        flex: 3,
                        child: Text(
                          Language.En?' ${save_hour_first}:${save_minute_fisrt}Am':'오전 ${save_hour_first}시 ${save_minute_fisrt}분',
                          style: TextStyle(
                            fontSize: 25,
                            color:  DarkMode.DarkOn?  Colors.white: Colors.black
                          ),
                        )
                    ),

                    Flexible(flex: 1, child: Container(color: Colors.transparent,),),

                    ElevatedButton(
                      onPressed: (){
                        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!버튼 누를 시 DB 안에 알람 내용 삭제해야..
                        //<-------------DB에 저장된 데이터를 삭제---------------->
                        //<-------------페이지 새로고침?-------------->
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),elevation: MaterialStateProperty.all(0.0),
                          padding: MaterialStatePropertyAll(EdgeInsets.all(15.0))
                      ),
                      child: Text(Language.En?'Delete':'삭제', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 25)
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //<-------------------저장된 알람2------------------------>
            savedb_second?
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: DarkMode.DarkOn?  Colors.white: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Flexible(flex: 1, child: Container(color: Colors.transparent,),),

                    Flexible(
                        flex: 3,
                        child: Text(
                          Language.En?'${save_hour_second}: ${save_minute_second}Am':'오전 ${save_hour_second}시 ${save_minute_second}분',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                    ),

                    Flexible(flex: 1, child: Container(color: Colors.transparent,),),

                    ElevatedButton(
                      onPressed: () {
                        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!버튼 누를 시 DB 안에 알람 내용 삭제해야..
                        //<-------------DB에 저장된 데이터를 삭제---------------->
                        //<-------------페이지 새로고침?-------------->
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),elevation: MaterialStateProperty.all(0.0),
                          padding: MaterialStatePropertyAll(EdgeInsets.all(15.0))
                      ),
                      child: Text(Language.En?'Delete':'삭제', style: TextStyle(color:DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 25)
                      ),
                    ),
                  ],
                ),
              ),
            )
            //저장된 2번째 알람이 없는 경우 기능 없는 컨테이너
                : Container(),
          ],
        ),
      );
    }
    else {
      return Container(
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 30, 5, 30),
            padding: EdgeInsets.all(10),
            child: Text(Language.En?'No saved alarms!':
              '저장된 알람이 없습니다!',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          )
      );
    }
  }

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
      body: Container(
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
                                      if (AM == true) {
                                        setState(() {
                                          AM = false;
                                          PM = true;
                                        });
                                      }
                                      else if (AM == false) {
                                        setState(() {
                                          AM = true;
                                          PM = false;
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                        elevation: MaterialStateProperty.all(0.0),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),)
                                    ),
                                    child: AM == true ? Text(Language.En?'Am':'오전', style: TextStyle(fontSize: 40, color:DarkMode.DarkOn?  Colors.white: Colors.black),):Text(Language.En?'Am':'오전', style: TextStyle(fontSize: 40, color: DarkMode.DarkOn?  Colors.white12: Colors.black12),)
                                )
                            ),

                            Flexible(flex: 1, child: Container(),),

                            //오후 버튼
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: (){
                                    if (PM == true) {
                                      setState(() {
                                        PM = false;
                                        AM = true;
                                      });
                                    }

                                    else if (PM == false) {
                                      setState(() {
                                        PM = true;
                                        AM = false;
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                    elevation: MaterialStateProperty.all(0.0),
                                  ),
                                  child: PM == true ? Text(Language.En?'Pm':'오후', style: TextStyle(fontSize: 40, color: DarkMode.DarkOn?  Colors.white: Colors.black),):Text(Language.En?"Pm":'오후', style: TextStyle(fontSize: 40, color: DarkMode.DarkOn?  Colors.white12: Colors.black12),)
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
                                  title: hour == i ? Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white: Colors.black)) : Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white12: Colors.black12)),
                                  onTap: (){
                                    setState(() {
                                      hour = i;
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
                                  title: minute == i ? Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white: Colors.black)) : Text('${i}', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: DarkMode.DarkOn?  Colors.white12: Colors.black12)),
                                  onTap: (){
                                    setState(() {
                                      minute = i;
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
                        SizedBox(width : 40),
                        Text(Language.En?'every week':'매주 반복', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,),),
                        SizedBox(width : 30),

                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: DarkMode.DarkOn?  Colors.white: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      if (repeat == false) {
                                        setState(() {
                                          repeat = true;
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: repeat == true ? Text('On', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,)):Text('On', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30))
                                ),

                                ElevatedButton(
                                    onPressed: (){
                                      if (repeat == true) {
                                        setState(() {
                                          repeat = false;
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: repeat == false ? Text('Off', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,)):Text('Off', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30))
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
                        onPressed: () {setState((){sun = !sun;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: sun == false ? Text(Language.En?'Sun':'일', style: TextStyle(color: Colors.redAccent, fontSize: 30)) :
                        Text(Language.En?'Sun':'일', style: TextStyle(color: Colors.red, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){mon = !mon;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: mon == false ? Text(Language.En?'Mon':'월', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                        Text(Language.En?'Mon':'월', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){tue = !tue;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: tue == false ? Text(Language.En?'Tue':'화', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                        Text(Language.En?'Tue':'화', style: TextStyle(color:DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){wed = !wed;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: wed == false ? Text(Language.En?'Wen':'수', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                        Text(Language.En?'Wen':'수', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){thu = !thu;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: thu == false ? Text(Language.En?'Thr':'목', style: TextStyle(color: DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                        Text(Language.En?'Thr':'목', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){fri = !fri;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: fri == false ? Text(Language.En?'Fri':'금', style: TextStyle(color:DarkMode.DarkOn?  Colors.white12: Colors.black12, fontSize: 30)) :
                        Text(Language.En?'Fri':'금', style: TextStyle(color: DarkMode.DarkOn?  Colors.white: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){sat = !sat;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: sat == false ? Text(Language.En?'Sat':'토', style: TextStyle(color: Colors.blue, fontSize: 30)) :
                        Text(Language.En?'Sat':'토', style: TextStyle(color: Colors.blue, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //<--------------저장된 알람 확인하기------------------>
            Flexible(
              flex: 4,
              child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: DarkMode.DarkOn?  Colors.white: Colors.black38, width: 2),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  //<<<<저장된 알람의 여부에 따라 작동하는 함수 => 알람 목록 or 알람이 없습니다!>>>>
                  child: getSaved_Alarm()
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
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
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
                        //!!!!!!!!!!!!!!!!!!!!!!!!!버튼 누를 시 DB 안에 알람 내용 저장해야한다!!!!!!!
                        //<---------버튼 누를 시 시간 관련 정보를 DB에 넘기자------------->
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
      ),
    );
  }
}
