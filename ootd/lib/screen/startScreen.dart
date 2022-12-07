import 'dart:async';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter/material.dart';
import 'package:ootd/model/model.dart';
import 'package:ootd/API/kakao.dart';
//최지철  처음 애니메이션

class firstPage extends StatefulWidget{
  const firstPage({Key? key}) : super(key: key);
  _firstPageState createState() => _firstPageState();

}

class  _firstPageState extends State<firstPage>{
  @override
  void SetNight(){
    if(Model.datenowInt<18||Model.datenowInt>6){
      Model.Night=false;
    }
    if(Model.datenowInt<6||Model.datenowInt>18){
      Model.Night=true;
    }
  }
  void initState() {
    SetNight();
    // TODO: implement initState
   // KakaoToken();
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Loading()));
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/anifirst.gif"),
            ),
          ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}