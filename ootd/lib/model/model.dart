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
        return Image.asset('weather/Thunder.png', // 비천둥
        );
      }else if(condition <600){

      return Image.asset('weather/Snowy_cloud.png', // 눈옴
      );
    }else if(condition==800){
    return Image.asset('weather/Sunny.png', // 날씨 좋음
    );
    }else if(condition<=804){
      return Image.asset('weather/Cloud_2.png', // 구름낌
      );
    }
  }
}