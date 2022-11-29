import 'package:flutter/material.dart';

class todayootd extends StatelessWidget {
  const todayootd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 80,),

                  Text('※ 추천 OOTD ', style: TextStyle(fontSize: 30),),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Flexible(flex: 1, fit: FlexFit.tight, child: Text(''),),
                      Flexible(flex: 1, fit: FlexFit.tight, child: Text(''),),
                      Flexible(flex: 1, fit: FlexFit.tight, child: Text(''),),

                      //공유하기 버튼
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text('공유하기', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),

                  SizedBox(height : 50),

                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black, width: 5,)
                      ),
                      child: Column(
                        children: [
                          //온도 끌어와야해
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('※ 추천',style: TextStyle(fontSize: 30)),),
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('36.5 기준',style: TextStyle(fontSize: 30)),),
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('현재 습도',style: TextStyle(fontSize: 30)),),
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('현재 온도',style: TextStyle(fontSize: 30)),),
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('추천 OOTD',style: TextStyle(fontSize: 30)),),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height : 30),

                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black, width: 5)
                      ),
                      child: Column(
                        children: [
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('※ 추천 OOTD',style: TextStyle(fontSize: 30)),),
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('1. ',style: TextStyle(fontSize: 30)),),
                          Flexible(flex: 1, fit: FlexFit.tight,
                            child: Text('2. ',style: TextStyle(fontSize: 30)),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
    );
  }
}