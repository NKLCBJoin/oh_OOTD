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
        return Image.asset('weather/11d.png', // 비천둥
        color: Colors.black87,
        );
      }else if(condition <600){

      return Image.asset('weather/09d.png', // 눈옴
          color: Colors.black87,
      );
    }else if(condition==800){

    return Image.asset('weather/01d.png', // 날씨 좋음
        color: Colors.black87,
    );
    }else if(condition<=804){

      return Image.asset('weather/04n.png', // 구름낌
          color: Colors.black87,
      );
    }
  }
}