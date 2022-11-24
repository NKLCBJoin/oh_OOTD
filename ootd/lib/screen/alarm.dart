//알람 UI
//신근재 작업
//코드량이 길고 복잡해서 반드시 정리 및 함수화? 과정 통해 코드수 줄이는 작업 필요
import 'package:flutter/material.dart';
import 'package:ootd/screen/loading.dart';
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
                  Color(0xffa1c4fd),
                  Color(0xffc2e9fb),
                ]
            )
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),

            //<-----------------시간 설정----------------------->
            Flexible(
              flex: 10,
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
                                    child: AM == true ? Text('오전', style: TextStyle(fontSize: 40, color: Colors.black),):Text('오전', style: TextStyle(fontSize: 40, color: Colors.black12),)
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
                                  child: PM == true ? Text('오후', style: TextStyle(fontSize: 40, color: Colors.black),):Text('오후', style: TextStyle(fontSize: 40, color: Colors.black12),)
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
                                  title: hour == i ? Text('${i}시', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Colors.black)) : Text('${i}시', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Colors.black12)),
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
                                  title: minute == i ? Text('${i}분', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Colors.black)) : Text('${i}분', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Colors.black12)),
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
                        Text('매주 반복', style: TextStyle(color: Colors.black87, fontSize: 30,),),
                        SizedBox(width : 30),

                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38, width: 2),
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
                                      backgroundColor: MaterialStateProperty.all(Colors.white12),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: repeat == true ? Text('On', style: TextStyle(color: Colors.black, fontSize: 30,)):Text('On', style: TextStyle(color: Colors.black12, fontSize: 30))
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
                                      backgroundColor: MaterialStateProperty.all(Colors.white12),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: repeat == false ? Text('Off', style: TextStyle(color: Colors.black, fontSize: 30,)):Text('Off', style: TextStyle(color: Colors.black12, fontSize: 30))
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
                        child: sun == false ? Text('일', style: TextStyle(color: Colors.redAccent, fontSize: 30)) :
                        Text('일', style: TextStyle(color: Colors.red, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){mon = !mon;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: mon == false ? Text('월', style: TextStyle(color: Colors.black12, fontSize: 30)) :
                        Text('월', style: TextStyle(color: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){tue = !tue;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: tue == false ? Text('화', style: TextStyle(color: Colors.black12, fontSize: 30)) :
                        Text('화', style: TextStyle(color: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){wed = !wed;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: wed == false ? Text('수', style: TextStyle(color: Colors.black12, fontSize: 30)) :
                        Text('수', style: TextStyle(color: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){thu = !thu;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: thu == false ? Text('목', style: TextStyle(color: Colors.black12, fontSize: 30)) :
                        Text('목', style: TextStyle(color: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){fri = !fri;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: fri == false ? Text('금', style: TextStyle(color: Colors.black12, fontSize: 30)) :
                        Text('금', style: TextStyle(color: Colors.black, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),

                    Flexible(fit: FlexFit.tight,
                      child: ElevatedButton(
                        onPressed: () {setState((){sat = !sat;});},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(20.0))
                        ),
                        child: sat == false ? Text('토', style: TextStyle(color: Colors.blue, fontSize: 30)) :
                        Text('토', style: TextStyle(color: Colors.blue, fontSize: 30,decoration: TextDecoration.underline, )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Flexible(flex: 2, child: Container(color: Colors.white30,),),

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
                          child: Text('취소',
                            style: TextStyle(color: Colors.black54, fontSize: 30,),
                          ),
                        ),
                      )
                  ),

                  Flexible(fit: FlexFit.tight,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0.0)
                      ),
                      child: Text('저장',
                        style: TextStyle(color: Colors.black54, fontSize: 30, ),
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
