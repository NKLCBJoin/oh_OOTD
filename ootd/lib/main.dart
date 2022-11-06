import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'widget/temp.dart';
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
        debugShowCheckedModeBanner: false,
        home: Container(
            color: Colors.white,
            child: Column(
              children: [
                Kakao()
              ],
            )
        )
    );
  }
}