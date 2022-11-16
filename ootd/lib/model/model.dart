import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDB//최지철 DB<->앱간 통신클래스임당~
{
  static final name="name";
  static final id="id";
  static final pw="pw";
  static final sex="sex";
  static List<String> getColumns()=> [name,id,pw,sex];
}
class Model{ // 이재민 컨디션에 따른 아이콘 불러오기
  Widget ?getWeatherIcon(int condition) {
    if(condition < 300)
      {
        return Image.asset('assets/weather/Thunder.png', // 비천둥
            height: 30,width: 30,
        );
      }else if(condition <600){

      return Image.asset('assets/weather/Snowycloud.png', // 눈옴
        height: 30,width: 30,
      );
    }else if(condition==800){
    return Image.asset('assets/weather/Sunny.png', // 날씨 좋음
      height: 30,width: 30,
    );
    }else if(condition<=804){
      return Image.asset('assets/weather/Cloud2.png', // 구름낌
        height: 30,width: 30,
      );
    }
  }
  Widget ?getAirIcon(int index)
  {
    if(index==1){
      return Image.asset('assets/dust/good.png',
          width: 15.0,
          height: 15.0,
      );
    }else if(index==2||index==3){
      return Image.asset('assets/dust/normal.png',
        width: 15.0,
        height: 15.0,
      );
    }else if(index==4||index==5){
      return Image.asset('assets/dust/bad.png',
        width: 15.0,
        height: 15.0,
      );
    }
  }
  Widget ?getAirCondition(int index)
  {
    if(index==1){
      return Text(
        '매우좋음',
        style: TextStyle(
          color: Colors.lightGreenAccent,
          fontWeight: FontWeight.bold,
        ),
      );
    }else if(index==2){
      return Text(
        '좋음',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }else if(index==3){
      return Text(
        '보통',
        style: TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    else if(index==4){
      return Text(
        '나쁨',
        style: TextStyle(
          color: Colors.deepOrangeAccent,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    else if(index==5){
      return Text(
        '매우나쁨',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}