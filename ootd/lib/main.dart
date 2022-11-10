import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'model/temp.dart';
import 'API/gsheets.dart';
import 'API/kakao.dart';
import 'package:flutter/services.dart';

//신근재
void main() async
{
  await GoogleSheestApi.init();//DB구글시트연결
  KakaoSdk.init(nativeAppKey: '5f71064329b935428862eb575059fe75');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         debugShowCheckedModeBanner: false,//이거 지우지말것 디버그리본없애는거 특히 재민(from지철)
        // home: Container(
        //     color: Colors.white,
        //     child: Column(
        //       children: [
        //         Loading(),Kakao(),
        //       ],
        //     )
        // )
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePageWidget(),
      },
    );
  }
}