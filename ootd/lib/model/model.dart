import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDB//최지철 DB<->앱간 통신클래스임당~
{
  static final name="name";
  static final id="id";
  static final pw="pw";
  static final sex="sex";
  static List<String> getColumns()=> [name,id,pw,sex];
}
class DarkMode{
  static bool DarkOn=false;
  static bool Am=false;
}
class Language{
  static String DarkSubtitle='다크모드 변경';
  static bool En=false;
  static bool Kor=false;
  static bool CN=false;
}
class LoadingData{
  static bool Lol=false;
}

class KakaoData {// 신근재 _카톡 토큰 및 유저 정보
  static bool Token = true;

  static String user_gen = '';
  static String user_name = '';
  static String userImage_URL = '';
  static String user_email = '';
}

class Model{ // 이재민 컨디션에 따른 아이콘 불러오기
  static DateTime Now=DateTime.now();
  static String datenow= DateFormat('H').format(DateTime.now());
  static int datenowInt=int.parse(datenow);
  static bool snow=false;
  static bool rain=false;
  static bool thunder=false;
  static bool sunny=false;
  static bool sunnynight=false;
  static bool cloudy=false;
  static bool dust=false;
  static bool Night=false;

  Widget ?getWeatherIcon(int condition) {

    if(condition < 300)
      {
        Night=true;
        thunder=true;
        return Image.asset('assets/weather/Thunder.png', // 비천둥
            height: 40,width: 40,

        );
      }else if(condition <600){
      snow=true;
      return Image.asset('assets/weather/Snowycloud.png', // 눈옴
        height: 40,width: 40,
      );
    }else if(condition==800){
      sunny=true;
    return Image.asset('assets/weather/Sunny.png', // 날씨 좋음
      height: 40,width: 40,
    );
    }else if(condition<=804){
      cloudy=true;
      return Image.asset('assets/weather/Cloud2.png', // 구름낌
        height: 40,width: 40,
      );
    }
  }
  Widget ?getAirIcon(int index)
  {
    if(index==1){
      return Image.asset('assets/dust/good.png',
          width: 30,
          height: 30,
      );
    }else if(index==2||index==3){
      return Image.asset('assets/dust/normal.png',
        width: 30,
        height: 30,
      );
    }else if(index==4||index==5){
      return Image.asset('assets/dust/bad.png',
        width: 30,
        height: 30,
      );
    }
  }
  Widget ?getAirCondition(int index)
  {
    if(index==1){
      return Text(
        Language.En?'Great!':'매우좋음',
        style: TextStyle(
          color: Colors.lightGreenAccent,
          fontWeight: FontWeight.bold,
        ),
      );
    }else if(index==2){
      return Text(
        Language.En?'Good!':'좋음',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }else if(index==3){
      return Text(
        Language.En?'Not Bad':'보통',
        style: TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    else if(index==4){
      return Text(
        Language.En?'Bad!':'나쁨',
        style: TextStyle(
          color: Colors.deepOrangeAccent,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    else if(index==5){
      return Text(
        Language.En?'F**** Bad!':'매우나쁨',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}