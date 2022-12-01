//최지철       child: WeatherBg(weatherType: WeatherType.thunder,width: 540,height: 815,)
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/flutter_animated_icons.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:flutter_animated_icons/useanimations.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/screen/loading2.dart';
import 'package:ootd/screen/settingScreen.dart';
import 'package:ootd/screen/weather_screen.dart';
import 'package:ootd/model/model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ootd/API/kakao.dart';
import 'package:ootd/screen/weekootdScreen.dart';
import 'package:ootd/screen/alarm.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ootd/screen/startScreen.dart';

//신근재 카톡 로그인 <전역 변수,함수>

void KakaoToken(){
  Future<bool?> getT() async {
    if (await AuthApi.instance.hasToken()) {
      KakaoData.Token = true;
      print('----------------------------------');
      print('토큰 존재');
      print('----------------------------------');

      var user = await UserApi.instance.me();//유저 정보 user에 담는다.

      KakaoData.userImage_URL = (user.kakaoAccount?.profile?.profileImageUrl).toString();
      KakaoData.user_gen = (user.kakaoAccount?.gender).toString();
      KakaoData.user_name = (user.kakaoAccount?.profile?.nickname).toString();
      KakaoData.user_email = (user.kakaoAccount?.email).toString();

      if(KakaoData.user_gen == "Gender.male"){
        KakaoData.user_gen = "남성";
      } else {
        KakaoData.user_gen = "여성";
      }
      await Future.delayed(Duration(seconds: 1));//땡겨오는 시간 딜레이 대기
      return true;
    }
    else {
      KakaoData.Token = false;
      print('----------------------------------');
      print('토큰이 없어요. . .');
      print('----------------------------------');
      return false;
    }
  }

  Future<bool?> future = getT();
}

class HomePageWidget extends StatefulWidget {
  // const HomePageWidget({Key? key}) : super(key: key);
  HomePageWidget({this.parseWeatherData,this.parseAirPollution,this.parseHourData});
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;
  final dynamic parseHourData;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>with TickerProviderStateMixin{
  Model model = Model();
  Widget ?icon;
  List <Widget> icons= [];
  String weather = 'weather';
  String cityName = 'cityName';
  double min_temp = 10.0;
  double max_temp = 10.0;
  double temp = 10.0;
  Widget? airIcon;
  Widget? airCondition;
  double pm2_5 = 0.0;
  double pm10 = 0.0;
  List <String> hours = ['hour1', 'hour2', 'hour3', 'hour4', 'hour5','hour6','hour7','hour8' ];
  var hourly_weathers = List<double>.filled(8, 0.0);
  // List <double> hourly_weathers= [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _menuController;
  late AnimationController _bellController;

  void UpdateData(dynamic weatherData,dynamic airData, dynamic hourData){
    KakaoLogin();
    int condition = weatherData['weather'][0]['id'];
    List <int> conditions = [0,0,0,0,0,0,0,0];
    for (var i = 0; i<8; i++)
    {
      conditions[i] = hourData['list'][i]['weather'][0]['id'];
    }

    for (var i = 0; i<8; i++)
    {
      icons.add(model.getWeatherIcon(conditions[i])!); // 날씨 아이콘 가져오기
    }
    icon = model.getWeatherIcon(condition);
    int index =airData['list'][0]['main']['aqi'];  // 미세먼지 AQI(인덱스값)

    airCondition = model.getAirCondition(index);
    airIcon= model.getAirIcon(index);

    pm2_5 = airData['list'][0]['components']['pm2_5'].toDouble(); //초미세먼지
    pm10 = airData['list'][0]['components']['pm10'].toDouble(); //미세먼지

    weather = weatherData['weather'][0]['description'];
    temp = weatherData['main']['temp'].toDouble();
    min_temp = weatherData['main']['temp_min'].toDouble();
    max_temp = weatherData['main']['temp_max'].toDouble();
    cityName = weatherData['name'];

    for (var i = 0; i<8; i++)
      {
        hours[i] = hourData['list'][i]['dt_txt'].split(' ')[1].split(':')[0];
        hourly_weathers[i]= hourData['list'][i]['main']['temp'].toDouble();
        print(hourly_weathers[i]);
      }
    //print(double.parse(hourly_weather_t1.toStringAsFixed(1)));
  }
  // dynamic timedata(List hours, int i){
  //   if (hours[i]<12)
  //     return '오전';
  //   else
  //     return '오후';
  // }
  void initState(){//메뉴바에 관한변수. 최지철
    _menuController = AnimationController(vsync: this , duration: const Duration(seconds: 1));
    _bellController= AnimationController(vsync: this , duration: const Duration(seconds: 1));
    UpdateData(widget.parseWeatherData,widget.parseAirPollution,widget.parseHourData);
  }
  void dispose(){//메뉴바에 관한함수. 최지철
    _menuController.dispose();
    _bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.location_pin,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            print(Model.datenow);
          },
        ),
        actions: <Widget>[
          IconButton(
            splashRadius: 50,
            iconSize: 100,
            icon: Lottie.asset(Useanimations.menuV2,
              controller: _menuController,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
            onPressed: () async {
              if (_menuController.status ==
                  AnimationStatus.dismissed) {
                _menuController.reset();
                _menuController.animateTo(0.6);
              } else {
                _menuController.reverse();
              }
              _bellController.repeat();
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      //---------------Drawer메뉴(메뉴 클릭시 나타나는 사이드페이지)-----------------------
      drawer: Drawer(
        child: Expanded(
          child: Container(
            color: DarkMode.DarkOn? Color(0xff29323c) :Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                  accountName: Text('섹잘알 최지철',
                  style: TextStyle(
                    color: DarkMode.DarkOn? Colors.black :Colors.white,
                  ),
                    ), accountEmail: Text('SexChoi@gmail.com',
                  style: TextStyle(
                    color: DarkMode.DarkOn? Colors.black :Colors.white,
                  ),
                ),
                  decoration: BoxDecoration(
                      color: DarkMode.DarkOn? Colors.pink[400] :Colors.blue[300],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: DarkMode.DarkOn? Colors.white:Colors.grey,
                    size: 30,
                  ),
                  title: Text(Language.En?'Home':"홈으로"),
                  textColor: DarkMode.DarkOn? Colors.white:Colors.black ,
                  onTap: (){//메인화면으로 돌아가기
                    scaffoldKey.currentState?.closeDrawer();
                    if (_menuController.status ==
                        AnimationStatus.dismissed) {
                      _menuController.reset();
                      _menuController.animateTo(0.6);
                    } else {
                      _menuController.reverse();
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.alarm_on_sharp,
                    color: DarkMode.DarkOn? Colors.white:Colors.grey,
                    size: 30,
                  ),
                  title: Text(Language.En?'Alarm':"알람 설정"),
                  textColor: DarkMode.DarkOn? Colors.white:Colors.black ,
                  onTap: (){ //알람 기능 선택시
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Alarm()));
                    scaffoldKey.currentState?.closeDrawer();
                    if (_menuController.status ==
                        AnimationStatus.dismissed) {
                      _menuController.reset();
                      _menuController.animateTo(0.6);
                    } else {
                      _menuController.reverse();
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.checkroom_rounded,
                    color: DarkMode.DarkOn? Colors.white:Colors.grey,
                    size: 30,
                  ),
                  title: Text(Language.En?'Week OOTD':"주간OOTD"),
                  textColor: DarkMode.DarkOn? Colors.white:Colors.black ,
                  onTap: (){//메인화면으로 돌아가기
                    LoadingData.Lol = true;
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading())); // weather_screen에 정상적으로 화면이 나오는지 실험중
                    scaffoldKey.currentState?.closeDrawer();
                    if (_menuController.status ==
                        AnimationStatus.dismissed) {
                      _menuController.reset();
                      _menuController.animateTo(0.6);
                    } else {
                      _menuController.reverse();
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings_sharp,
                    color: DarkMode.DarkOn? Colors.white:Colors.grey,
                    size: 30,
                  ),
                  title: Text(Language.En?'Setting':"설정"),
                  textColor: DarkMode.DarkOn? Colors.white:Colors.black ,
                  onTap: (){//설정창
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SettingsWidget()));
                    scaffoldKey.currentState?.closeDrawer();
                    if (_menuController.status ==
                        AnimationStatus.dismissed) {
                      _menuController.reset();
                      _menuController.animateTo(0.6);
                    } else {
                      _menuController.reverse();
                    }
                  },
                ),
              ],
            ),
          ),

        ),

      ),
      body: Center(
        child: GestureDetector(
          onTap: () => {
            FocusScope.of(context).unfocus(),
          },
          child: Stack(
            children: [
              if(Model.cloudy==true&&Model.Night==false)...[
                WeatherBg(weatherType: WeatherType.cloudy,width:  MediaQuery.of(context).size.width,height:  MediaQuery.of(context).size.height),
              ]else if(Model.sunny==true&&Model.Night==false)...[
                WeatherBg(weatherType: WeatherType.sunny,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)
              ]else if(Model.snow==true)...[
                WeatherBg(weatherType: WeatherType.middleSnow,width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)
              ]else if(Model.dust==true)...[
                WeatherBg(weatherType: WeatherType.dusty,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)
              ]else if(Model.rain==true)...[
                WeatherBg(weatherType: WeatherType.heavyRainy,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)
              ]else if(Model.thunder==true)...[
                WeatherBg(weatherType: WeatherType.thunder,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)
              ]else if(Model.sunny==true&&Model.Night==true)...[
                WeatherBg(weatherType: WeatherType.sunnyNight,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)
              ]else if(Model.cloudy==true&&Model.Night==true)...[
                WeatherBg(weatherType: WeatherType.cloudyNight,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height)
              ],
              Align(
                alignment: AlignmentDirectional(-0.05, -0.79),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                  child: Container(//옷추천
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Column(
                            children: [
                              Text(
                                Language.En? 'Gumi':'구미',
                                style: GoogleFonts.lato(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Model.Night? Colors.white:Color(0xff497174),),
                              ),
                              Text(
                                '$temp°',
                                style: GoogleFonts.lato(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    color: Model.Night? Colors.white:Color(0xff497174),),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  icon!,
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '$weather',
                                    style: GoogleFonts.lato(
                                      fontSize: 25.0,
                                      color: Model.Night? Colors.white:Color(0xff497174),
                                    ),
                                  ),
                                  SizedBox(
                                    width:20,
                                  ),
                                  Text(
                                    Language.En?'High: $max_temp°':'최고: $max_temp°',
                                    style: GoogleFonts.lato(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Model.Night? Colors.white:Color(0xff497174),),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    Language.En?'Low: $min_temp°':'최저: $min_temp°',
                                    style: GoogleFonts.lato(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Model.Night? Colors.white:Color(0xff497174)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, 1),
                          child: Stack(
                            children: [
                              Text(
                                Language.En?"SQI(Air Quality Index)":'SQI(대기질지수)',
                                style: GoogleFonts.lato(
                                  fontSize: 11.0,
                                  color: Model.Night? Colors.white:Color(0xff497174),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.7, 0.8),
                          child: Stack(
                            children: [
                              airCondition!,
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.9, 0.8),
                          child: Stack(
                            children: [
                              airIcon!,
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$pm10㎍/m³',
                                    style: GoogleFonts.lato(
                                      fontSize: 15.0,
                                      color:Model.Night? Colors.white:Color(0xff497174),
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                Language.En?"Air pollution":'미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 11.0,
                                  color: Model.Night? Colors.white:Color(0xff497174),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1, 1),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '$pm2_5㎍/m³',
                                style: GoogleFonts.lato(
                                  fontSize: 15.0,
                                  color: Model.Night? Colors.white:Color(0xff497174),
                                ),
                              ),
                              Text(
                                Language.En?"ultrafine dust":'초미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 11.0,
                                  color: Model.Night? Colors.white:Color(0xff497174),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //<-------------------카카오 로그인 or 옷 추천------------------->
              Align(
                alignment: AlignmentDirectional(0, 0.39),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Container(//옷추천
                    width: MediaQuery.of(context).size.width,
                    height: 420,
                    decoration: BoxDecoration(
                      color: DarkMode.DarkOn? Colors.black12.withOpacity(0.4):Colors.white12.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: DarkMode.DarkOn? Colors.black12:Colors.white12,
                        width: 0,
                      ),
                    ),

                    child: KakaoData.Token ?
                    //<---------------------로그인 성공(토큰을 가지고 있음)------------------------>
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 5),
                                borderRadius: BorderRadius.circular(20),),
                            child: Column(
                              children: [
                                Text('${KakaoData.user_name}님\n'
                                    '성별 : ${KakaoData.user_gen}\n'
                                    '${KakaoData.user_email}\n'
                                  , style: TextStyle(fontSize:20, color:Colors.white),),

                                KakaoShare(),

                                Image.network(
                                    KakaoData.userImage_URL
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                        :
                    //<---------------------로그인 필요(토큰 없음)------------------------>
                    Column(
                      children: [
                        Flexible(flex: 1, fit: FlexFit.tight, child: Container()),

                        Flexible(flex: 1, fit: FlexFit.tight, child:
                        ElevatedButton.icon(
                            icon: Icon(Icons.lock),
                            label: Text("카카오 로그인",style: TextStyle(fontSize: 18, color: Colors.black87),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.yellow),
                                foregroundColor: MaterialStateProperty.all(Colors.black54),
                                padding: MaterialStateProperty.all(EdgeInsets.all(20.0))
                            ),
                            onPressed: () async {
                              //[1] 카카오톡 설치 여부
                              if(await isKakaoTalkInstalled()){
                                try {
                                  //[2] 이미 로그인 했나 토큰 유효성 확인 후 로그인 시도
                                  AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
                                  User user = await UserApi.instance.me();//유저 정보 user에 담는다.
                                  print('토큰 정보 보기 성공'
                                      '\n회원정보: ${tokenInfo.id}'
                                      '\n토큰 만료시간: ${tokenInfo.expiresIn} 초');
                                  //[3]정상적으로 토큰 성공을 한 경우 메인 페이지로 다시 돌아갑니다.
                                                                KakaoData.Token = true;
                                  Navigator.push
                                  (context,
                                  MaterialPageRoute(builder: (context) => firstPage()));
                                } catch (error) {
                                  print('토큰 정보 보기 실패 $error');
                                  try {
                                    //[2-1] 카카오톡 로그인 접속 시도
                                    await UserApi.instance.loginWithKakaoTalk();
                                    User user = await UserApi.instance.me();
                                    print('카카오톡으로 로그인 성공');
                                    //★★★★★★★★★다음 페이지 넘어가면서 user넘겨줌★★★★★★★★★
                                    //model폴더의 temp.dart를 보면 user 사용 예시 찾기 가능
                                    KakaoData.Token = true;
                                    Navigator.push
                                      (context,
                                      MaterialPageRoute(builder: (context) => firstPage()),);
                                  } catch (error) {
                                    print('카카오톡으로 로그인 실패 $error');
                                  }
                                }
                              }
                              //[1-1 카카오톡 미설치
                              else{
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0)
                                        ),

                                        title: new Text("카카오톡 설치 후 실행해주세요!"),

                                        actions: <Widget>[
                                          new ElevatedButton(
                                            child: new Text("Close"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                );
                              }
                            }
                          )
                        ),
                        Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                      ],
                    )
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(//시간대별 날씨
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: DarkMode.DarkOn? Colors.black12.withOpacity(0.4):Colors.white12.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: DarkMode.DarkOn? Colors.black12:Colors.white12,
                          width: 0,
                        ),
                      ),
                      child:ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: [
                            Container(
                              padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide( // POINT
                                    color: Colors.white70,
                                    width: 1,
                                  ),
                                ),
                                color: Colors.transparent,
                              ),
                              child: Align(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${double.parse(hourly_weathers[0].toStringAsFixed(1))}°',
                                          style: GoogleFonts.lato(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        icons[0]!,
                                        Text(
                                          Language.En?' ${hours[0]}:00':'${hours[0]}시',
                                          style: GoogleFonts.lato(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          Container(
                            padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide( // POINT
                                  color: Colors.white70,
                                  width: 1,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${double.parse(hourly_weathers[1].toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      icons[1]!,
                                      Text(
                                        Language.En?' ${hours[1]}:00':'${hours[1]}시',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide( // POINT
                                  color: Colors.white70,
                                  width: 1,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${double.parse(hourly_weathers[2].toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      icons[2]!,
                                      Text(
                                        Language.En?' ${hours[2]}:00':'${hours[2]}시',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide( // POINT
                                  color: Colors.white70,
                                  width: 1,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${double.parse(hourly_weathers[3].toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      icons[3]!,
                                      Text(
                                        Language.En?' ${hours[3]}:00':'${hours[3]}시',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide( // POINT
                                  color: Colors.white70,
                                  width: 1,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${double.parse(hourly_weathers[4].toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      icons[4]!,
                                      Text(
                                        Language.En?' ${hours[4]}:00':'${hours[4]}시',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide( // POINT
                                  color: Colors.white70,
                                  width: 1,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${double.parse(hourly_weathers[5].toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      icons[5]!,
                                      Text(
                                        Language.En?' ${hours[5]}:00': '${hours[5]}시',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide( // POINT
                                  color: Colors.white70,
                                  width: 1,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${double.parse(hourly_weathers[6].toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      icons[6]!,
                                      Text(
                                        Language.En?' ${hours[6]}:00':'${hours[6]}시',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.fromSTEB(10,20, 10, 0),
                            decoration: BoxDecoration(

                              color: Colors.transparent,
                            ),
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${double.parse(hourly_weathers[7].toStringAsFixed(1))}°',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      icons[7]!,
                                      Text(
                                        Language.En?' ${hours[7]}:00': '${hours[7]}시',
                                        style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                          ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
