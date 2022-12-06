import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class location { //이용구 주소, 해시키, 텍스트컨트롤러

  static Map<String,String> headerss = {
    "X-NCP-APIGW-API-KEY-ID": "noaoz64fyk", // 개인 클라이언트 아이디
    "X-NCP-APIGW-API-KEY": "gk2M9ll3WPkULJOsIZWdb7XDeBqhCQEwbITRGb43" // 개인 시크릿 키
  };

  static String address=''; //api를 통해(페이지의 _addressAPI() 실행하면 값 들어감) 주소 값이 들어간다.

  static String x_pos=''; //현재 위도
  static String y_pos=''; //현재 경도

  static String lat=''; //위도
  static String lon=''; //경도

  static String gu=''; //구
  static String si=''; //시
}
class RecommandCloth{ //옷 관련 변수
  static bool choicePadding=false;
  static bool choiceCoat=true;
  static bool choiceEtc=false;
  static var winterCloth = List.generate(3, (index) => ["1","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
    ,"","","","","","","","","","","",""],growable: false); //[0][]은 패딩 //[1][]은 코트//[2][]는 기타
  static List<String>padding=["https://lh3.googleusercontent.com/fife/AAbDypC5x9z-IracxwfwXt6wT45ULXPmKKoSXPrVLCKQGOXChYZKr2O2gxgtQ1bzlfhqHckIse3fpEriyH-89zPAG5YwD2rTRnspy9KJKG1KSWz1jGaWYO5A5snPc52-DAArQ4JFlZ7N-pWqulIzc9sNgYZpPrctfYORdFfcCEO1RuCozKKlVVhRBeINJXuPLDyls8pggTwNut6SlyTQvg2uFz9IEtD-TdaYsjHFy6OdVUNAtfhrbv5dOH8GxkV_i9MgoEcJSsfxky5AyJJkAbPEwm6ytBVXMUDCuXtIAeJnSHrRYtsTVkpmHBldyQKkwPGPOKUnqJ5-WpOtro-0jXVc85J6f8D3CsqgpRPxOkKykRnDfVLfUgV4XdjB7AuT173Y2TH5hyT0TBuMQ-2DxDIlUP3YWGHQv58Hh4gdA-4tNJRBFhZ0Lk2aF1TzmbQTUFSaROdwE1iXbdnP4hYkjJ-iRuQHV45AYRzegfmhhsQpXKd_WBOrSgQAPVbxS6O11SmPhwowMxsaqFNHoCD0oZV47JCOFIF8sVtDvbNnu_7jf8KyDVzarfd-CYezcKwjddKdWjf-6jeJJniTISbABT1ICHbrS3YPo-AnVkt0SauiJ3klT9QZ-JBpNxW7oMNFxplc8cY5rovByD_iQMXVv07M6RAdr7XYDY7_qoTxORcsL9ascDWzxcrC5fQb892GscgXcwTqsozwxE0LykPBuAhYJG59pJbAqzo43nsFxRwmxpqW6cHB3KXopNF-ViewHF4hzgf6i52BnLo2QIoS8JQj9q7zBl_SWCpqstyqlfye15apB7nmzHa-uzUJBUME0Ui-O_rO4rfudmTY2x3BKx18dHcR34YepfB6LakGmIM2z4IBFGMheQvQ0clK7f0yLkWB0rBvoKtE0mEUIgIA5PVGvHtSYqNuKcdvhSXFq2p3Qc2eqynx8M8CpVDkz2kefM2gyQOF0ocANpiAU0i-AGmyNMEaBnCGsvcquZmpGLdye7Pke9eoqQ7b-WDGiV61e1UBJeWo5POPsvjMPGZ2f34beuDfrYN3Fy-PjPTWX7ofNvv-Y6BBrjNsANUvnR4HrcBsX4gnrSSir4A1gfSOWtI-1HlptsAu3wt0Kud0VsPvWEYEOKqTRP1V01hbVM9cQYC9CFqVkP51j6NRTVRNOvLy8qeduzxOdNQtoA5m3K_T-7q3NHM4Xa1sIrCV2_tPuv16h9U_ip1-uYQScbe52hQHynk2SEEshFK3ITtRkpPJ3ZOczMJcFBvbDL_LqEViTd-sbZXc_-aZm4p-AepKZlLk7ZDzr14vQC6KVgV6eeee-zL9zsjl7YC-RlZjfXehixq7ZqUDPpcmJxBVBN3k6PNDvtZ0nJ_pcP0_bjlho6mrfLySnHU-7HeU-XC_paZk-MniymXVeGgjEhscKFABHLHcA8aoZQND1kMa3jPm8UKx7XVt9uqayHDTKh8iTwEk7ZYlorC-A_4PaVvKJt7sdOU=w1920-h937",
    "","","","","","","",""];
  static List<String>coat=['',
    'https://lh3.googleusercontent.com/fife/AAbDypAPOaeNfKhKQDZej6L4qQpVuw1aZZ1RBg9N6dWCzeLhHAJV_qow8-gEpc0E1Lx28dCR0b9GrlQ5mifjLrxOErUJqi2JoGpHxGW9FhbvbysZ7BKILSq4W-gE7vJjE6xuu1MpVAqV4Ht8_l7QAgo0_NRoICXf7SKLxfTwBPeikp8GOOwSQGb2r5Rbm1C2CSyMTTCFTbV-JFrDelYWaNl2d11ypzqnIQ2L9emFcKCaiMzdN8snIyRMDIC-sbDn3qHhHRmfCcp_gf6zjwjoEraLLH8u1-GQoKKTKoz2F0maYF8RLZ5yeODW2Gfc8nF8GbFI2TuZHtz8MvYzbMrqjcuiZbQOPDp0x-duwqfHuuTVhZb5GRb9w_I9hjyRhNELGWx9TwWTILiKcDAXn8lCnV_kMscTr8_03JuxjYOqr1-9PjbjS-AhMSPpfjBdLTCxlGbICiOnidZoNjlFFmafNNBjBcqCvMJcxnE0DKWG_72WLIbB_DViMcpBEqWTs-XfIu8LC5j3pmA0qnBxf4lSn3GOQPG8I_cPxjitlhuwo9gkoah7jVNxYZgQQVwBVzpVfisqeZyt7eLZKL5UdK6tSH2XNVY5mzj92RPqbEdl9xlb65QnXKXWlC47gjPKOVR0BnYazGvVqlugulhuxUEu9SvlJhqvuCCc5lWDY2qxSpCrbIuHfaYyqRlmotiweBx-LL1FIWNGlAcuTJbfYuM3Al5p2qcxUgRTaGZnk5JKnP_WrDVDzBophuBSH2q17lsGVAIh3pHyMe_pQ5KPrzxKtTnalpQ8xNacrlapF_REbGIdWtw5VF6R-toXTwzwsVnOfqJNCCQYmwLO7SFg-zVtNzgYyluGXTDE-ajHIZuFbixWpeul_i8lz7W9p5d9PBuCi_XN-D1zOof-c5q4v4LJ50iXC75to0ZuMqua5g2HLk0Q4aYdupKCm2rcIa0x1y7ONDgiF8J_QPaEEaPC-AyjZsDXIFOHD3JPftdnLlvmnLZfPkx-olN61ZPpQlAB_YMQISXH9pUY1O4myRJDfX9y4v-6CDjxkT78BbjRdEgZuH_x7IEBB1JAjUpyhTJVVN9Tq6iRJEn9Ked8mnXc1tACHIStt9fs1exqerSlKymDWpu_ucalEeYJfdqUqe-LVXKAYVDXRHfVnQU4HTFwQ1UO7ct6nIDmzuvH8bVxD4bgeGkPrg1Adm2anOy7lhlmFkRaGbpOEKF_wPphc2WO4bVrSE3FPLkAuYvtBKysDJ4CCSPi2dHj6YPb0SlqKdOiIMKo7apBogc5AP2MU73RmgPp0pkV_dietvKEkMtoowmOOvOiVw72GDpPA6TrD-J4Z_emhr_js8o96JVgT7F01-jigbGbq3sLjxPmldisPXNJpW1fWgMB-_6Htc18LEKFWMSUhQG_j6a5mF0H3od32FZUfCQKcPH9rxgvesZgF9a5RTzadlqCdraTh4M4dx2ejFwcKKpAz9Ti8mzpRWaj0UY6uc4=w1437-h937',
    '',
    '',
    '',
    '',
    ''];
  static List<String>etc=["https://lh3.googleusercontent.com/fife/AAbDypBVgjMvXYtHQm7XtLIPm5lQBnKf2e2yMRjw7BB1TtdwTRWxdPvj3iJT9fxJl8VcN_emk0yj64OiVWAwyQW0gVqakn0rMSsOMWd-y2-YPacgbMnCfOGQ6gQdEZTshDQhaBzOIKOxtTOSOCqpTLPNWV0fYJ5GGRaXV3QHSI97lTXjDsLWUtlo9HiyuhtcJKbqXceD4oxDOU-FxtsqzIzg8UDUleKOZ8iV9NKMjETidxvzRbpMV2KBHc6Z8Rknln_kD-lgSSzJZEiDeyBdxOlo_shMc9ZQdRGjzFBRudHwLhU7NulFqkMUJB5IbxMB5zX6lGhKCvQumh5Insy4WeChu9zpQBB1YqUJ3r1vDgDOdOtuUQzzCxop1eYid6nFHixrduo2wuLJvZpcK__8UBjNfT84L3S8FDft5EhTvJOdmjuW3zT1cyLxdHzfJWRvp9KqWYUh1hlPAw89kDJfKl7A1q55bsNmqwQ6GSjsqc2Ygv5aB1xvZCMzTSkRkFbFhqh-shR9VoYAw4hj0Wc0HEwjqL-7cgGjd1rLRG1T4B05ZQpdivGvGGcwgm4Pec7xDjl9wJphNTPgIxqJLBg6wrSZyKN_3a-YT44XNWiprbWLICbj4JQAuMyYO92QtUtW1Rz76rztcKRE4Nn4sIXtMcJPrSxsgPvUH13mLl2aZbHuv3MOshE8Tv91wUeKGtiHpxA4O6D6VGU9xoRlv7AZ6-JKcspcS2rlNIUxy8EkflUXlVqyY51Avzj3awBvJvCj08yx0H2n7O5hSG9t0VJrf1DVTvEyv76sptFzpeirWhJgqYEofLaCdD3NlEZeEtFjf6rRfnivwrQz8D9urGIqD2eCFt3GRutHUePrWbBl4owVmTZum1XrCStHovHeEHvwmx6gkle8u6AD05eLvezAiTzA3J2jNnHAF1sQHaxgcEWqvgwnt72EsfBtAK5xspBnwvAWsxQe8FsfKzF_wV99GX2aObjgY8lC_0TdwrjAPXcovrfuleKtPMHgzgy-KH4xs2zTWexUpkAHS3vUJ7u0iiVmgJyyJjPjTONUfkh0IMf3oPjP-GoB4dFN3QBNp5VFhlclEXKbCq_VxE1WROG1n-4_uY060ivxBPMwsb4l0c9AtrSaHNeQmNk9eorgSXi7DrKo-gtQ6yg366mysV0EuNsMe8jf_ksW_n4OwLGJxC6UtaLGHzzDccR9khAehor-hGtlApdGPgnpR5yXGcuBhOzZu4hY9MyZazHwagLRRCGE1kUh1Bgi8_18R2-LUtT0bwI7PvGLJclwBF7q9wedoVIfmT4blv1oWGSFsZ5lsM1a_OH2yv6-VKu8NqtllPFKE7mqv2-0L4uSqr7JyZYN7lBejNoF3zUhE48_j9Q-XqOBhzUolRw8Mv1ZcsxPfJ1vLoreMCU5ZgRKQS50FvBvMh8v7lW0ljUOy0gpJkczhP5fAo3YCWsbHURzSlig1nqkDqlgMWsumQN-9bt8dSLQ5fw=w1437-h937",
    "",
    ""];
  static List<String> ReCom=['패딩,무스탕류의 아우터와 두꺼운 이너웨어','롱코트와 함께 따스한 이너웨어','숏 아우터류와 함께 이너웨어 따뜻하게 입어주세요!',"오늘은 롱패딩만 입어야 되요...",'얼죽코 아시죠?'];
  static List<String> paddingCom=['오늘 같이 추운 날 패딩을 센스입게 입어보는 거 어때요?','오늘은 너무 추워요.. 롱패딩을 꼭입어야 할 것 같아요...'];
  static List<String> coatCom=['실내에 있는 시간이 많다면, 멋지게 코트 어떠신가요?','얼죽코 아시죠?'];
  static List<String> otherCom=['파티에 가시나요? 그렇다면 오늘 의상으로 어떠신가요?','오늘은 너무 추워요.. 롱패딩을 꼭입어야 할 것 같아요...'];
  static List<String> ReComEn=['Padding, Shearling Jacket type outerwear and thick innerwear','Please wear innerwear warmly with short outerwear!',
    'You only have to wear long padding today...','Even if you freeze to death, your coat'];
  static List<String> coatComEn=['If you spend a lot of time indoors, how about a stylish coat?','Even if you freeze to death, your coat'];
  static List<String> paComEn=['How about wearing a down jacket on a cold day like today?',"It's so cold today... I think you'll have to wear long padding..."];
  static List<String> etcComEn=["Are you going to a party? Then how about today's outfit?"];


}
class UserDB//최지철 DB<->앱간 통신클래스임당~
{
  static final name="name";
  static final id="id";
  static final pw="pw";
  static final sex="sex";
  static List<String> getColumns()=> [name,id,pw,sex];
}
class AlarmState{//최지철
  static int AlarmCount=0;
  static  var AlarmInfo = List.generate(7, (index) => [1,0,"","",""],growable: false); //[][0]은 시간 [][1]은 분 [][2]는 AmPm [][3]은 매주반복 [4]
  static List<bool>AlarmOnOff=[true,true,true,true,true,true,true,true];
  static  bool AM = true;
  static  bool PM = false;
  static  bool MakeAlarm=false;
  //주간 반복 여부
  static  bool repeat = false;

  //설정한 시간, 분
  static int hour = 1;
  static  int minute = 0;
  static   int _i=0;

  //요일 설정 여부 값
  static  var day = List.generate(7, (index) => [false,false,false,false,false,false,false],growable: false);
  static  var dayString = List.generate(7, (index) => ["","","","","","","","",""],growable: false);
  static String ?AmPm;
}
class DarkMode{ //최지철
  static bool DarkOn=false;
  static bool Am=false;
}
class Language{ //최지철
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

class Model{ // 이재민,최지철 컨디션에 따른 아이콘 불러오기
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
          color: Colors.cyan,
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