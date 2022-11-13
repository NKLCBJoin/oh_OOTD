import 'dart:async';
import 'package:ootd/screen/mainScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter/material.dart';
//최지철  처음 애니메이션

class firstPage extends StatefulWidget{
  const firstPage({Key? key}) : super(key: key);
  _firstPageState createState() => _firstPageState();

}

class  _firstPageState extends State<firstPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePageWidget()));
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