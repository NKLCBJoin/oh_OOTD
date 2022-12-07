//최지철       child: WeatherBg(weatherType: WeatherType.thunder,width: 540,height: 815,)
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/flutter_animated_icons.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:flutter_animated_icons/useanimations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/screen/loading2.dart';
import 'package:ootd/screen/searchlocation.dart';
import 'package:ootd/screen/settingScreen.dart';
import 'package:ootd/screen/weather_screen.dart';
import 'package:ootd/model/model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ootd/API/kakao.dart';
import 'package:ootd/screen/weekootdScreen.dart';
import 'package:ootd/screen/alarm.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ootd/screen/startScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ootd/main.dart';
import 'package:ootd/API/notification.dart';
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
  KakaoData kakaodata = KakaoData();
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
  Future<void> CallNotification()async{
    await AwesomeNotifications().createNotification(content:
    NotificationContent(id:1 , channelKey: 'channelKey',
      title: '${Emojis.smile_smirking_face}',
      body: '오늘 같은날 뭘 입어야할지 모르겠죠?',
    ),
    );
  }
  void UpdateData(dynamic weatherData,dynamic airData, dynamic hourData){
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
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        showDialog(context: context, builder: (context)=>AlertDialog(title: Text('알림 설정을 하시겠습니까?'),
        content: Text('알림 설정을 허용하지 않을 시, 알람 기능을 이용하실 수 없습니다 :('),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('닫기')),
            TextButton(onPressed: ()=>
                AwesomeNotifications().requestPermissionToSendNotifications().then((value) =>Navigator.pop(context)), child:
            Text('허용'))
          ],
        ),);
      }

    }
    );
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
          onPressed: () async{
            Get.put(NotificationController());
            Get.find<NotificationController>().createBasicNotification();
          //  CallNotification();
            //이동
            //Navigator.push(context, MaterialPageRoute(builder: (_) => LocationSet(title: '',)));
           // print(Model.datenow);
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
                      backgroundImage: KakaoData.Token? NetworkImage('${KakaoData.userImage_URL}') : NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7s_NWoe9O4ONIdRkRBZjASnTMGvQC5ajjtw&usqp=CAU')
                  ),
                  accountName: KakaoData.Token? Text('${KakaoData.user_name}',
                  style: TextStyle(
                    color: DarkMode.DarkOn? Colors.black :Colors.white,
                  ),
                    ) : Text('이름:로그인 후 나타납니다.'),
                  accountEmail: KakaoData.Token? Text('${KakaoData.user_email}',
                  style: TextStyle(
                    color: DarkMode.DarkOn? Colors.black :Colors.white,
                  ),
                ) : Text('이메일:로그인 후 나타납니다.'),
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
              //<-------------------카카오 로그인 or 옷 추천------------------->
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Container(//옷추천
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                            child: Column(
                              children: [

                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  Language.En? 'Gumi':'구미',
                                  style: GoogleFonts.lato(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Model.Night? Colors.white:Color(0xff497174),),
                                ),

                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$temp°',
                                      style: GoogleFonts.lato(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                        color: Model.Night? Colors.white:Color(0xff497174),),
                                    ),
                                  ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      width:10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Language.En?'Low: $min_temp°':'최저: $min_temp°',
                                      style: GoogleFonts.lato(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: Model.Night? Colors.white:Color(0xff497174)),
                                    ),
                                    Text(
                                      Language.En?'High: $max_temp°':'최고: $max_temp°',
                                      style: GoogleFonts.lato(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Model.Night? Colors.white:Color(0xff497174),),
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
                                    color: Model.Night? Colors.white:Colors.black54,
                                  ),
                                ),
                                Text(
                                  Language.En?"ultrafine dust":'초미세먼지',
                                  style: GoogleFonts.lato(
                                    fontSize: 11.0,
                                    color: Model.Night? Colors.white:Colors.black54,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Container(//옷추천
                          width: MediaQuery.of(context).size.width,
                          height: 410,
                          decoration: BoxDecoration(
                            color: DarkMode.DarkOn? Colors.black12.withOpacity(0.4):Colors.white12.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: DarkMode.DarkOn? Colors.black12:Colors.white12,
                              width: 0,
                            ),
                          ),
                          //---토큰넣기
                        child: KakaoData.Token ?
                        //<---------------------로그인 성공(토큰을 가지고 있음)------------------------>
                        InkWell(
                          onTap: (){
                            print("ss");
                            LoadingData.Lol = true;
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
                          },
                          child: Container(
                            width: 350,
                            height: 300,
                            decoration: BoxDecoration(
                                color: Colors.transparent
                            ),
                            child:  Stack(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(1,-1),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if(Language.En==false)...{
                                            Text(
                                              "오늘 뭐 입지?!",
                                              style: GoogleFonts.jua(
                                                fontSize: 30.0,
                                                color: DarkMode.DarkOn? Colors.white70:Colors.black54,
                                              ),
                                            ),
                                          }else...
                                          {
                                            Text(
                                              "Today OOTD",
                                              style: GoogleFonts.kanit(
                                                fontSize: 30.0,
                                                color: DarkMode.DarkOn? Colors.white70:Colors.black54,
                                              ),
                                            ),
                                          },],),),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Row(
                                        mainAxisSize:MainAxisSize.min ,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          if(Language.En==false)...{
                                            Text(
                                              "패딩,무스탕류의 아우터와 두꺼운 이너웨어",
                                              style: GoogleFonts.jua(
                                                fontSize: 15.0,
                                                color: DarkMode.DarkOn? Colors.white70:Colors.black54,
                                              ),
                                            ),
                                          }else...
                                          {
                                            Text(
                                              " Humidity:",
                                              style: GoogleFonts.kanit(
                                                fontSize: 12.0,
                                                color: DarkMode.DarkOn? Colors.white70:Colors.black54,
                                              ),
                                            ),
                                          },
                                        ],
                                      ),
                                    ),
                                    Align(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 350,
                                            height: 310,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  child: Container(
                                                    width: 250,
                                                    height: 250,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius: BorderRadius.circular(10),
                                                      image: DecorationImage(
                                                          image: NetworkImage('https://lh3.googleusercontent.com/fife/AAbDypDQunrjKwGklCTp479CIIht2BPkT-7tPjFlTvSPE8uSDQjADx4dwJoE0uSK2n-MGCi7RBGmrRN0w0DVZ4IcXYVCRTy2aLWVMA4yXT47B_DzIHWHDNQ3Eg81SrhAv1JU8TZuJdSDECV6T-BQ4hh96TBYmuWaNh4stDT40lYcOVycb1Pctsww4V-zAFbSakt5ncT8-udteCuc-x9UAeZ9EH_r1u5S4sx12deeb1Tg_Z6pcOGmIVpBmpTFUQzG7jZLTRuC3ebN5hWEZ11QtEK9wR184-QvqjzLYtK1xuu4-NeJ1jZ6x0-bkbwKuQSSC-APdfH0KleHO0K2T9FGoC_4J_t6XfhpgIh6MZiK7cwqNII6PKyzUxcggAtFtnBYU0DCg6RKOBnt9EWhkYogLte-1yNo5xqDfTm10dMUvVulSdx4XMC3QZieQJx5Mad8aGFvXbKkXfOPCv8W3JU7o97B1K5c9d5V0Y-6CjFzc1S_6bfttyZRHHHdscGzO3gVwFL0p-i-5uorSCReEBeGKFJBXQgc2lSc0KipoVS91VUYbVxj56P_OSLZghLfbxSkqUFmA9t_Ph-CZxB0mI9uKDBDFaO2HlJIxcBGd9_BFw7YKbVV_nFaV-eFKS6NxJwq6IyDE-ZIdO5nntoaZi3jLVRmHhpR07XgmfXT3PXjBIfw9sAOnt7FB-uPU9K9GZBYVzP9rKVcDid2NYlk1EDbAeTVoMKsfe4drotHPWxvn_xZ-Dh-gpDvQGp21V0eNmI1oYrPiact398yDVUEYgSN3GY3-_upYnOIomz9iFLUknGx5j_V48bP4VWhTQG-kPs6mFtQPVd4s91j6eXnsFtZ_6WoIB1ONZ_BeHPitj6FhTaooXDYPIFyg-pb0YP9dGsFqJmUZHgV8BdYp18ZgEIIv5j-NF9SwnWsYTubicd34vhJmdKg1hbPZPRc_v8SFB7XMsckz3nxgK2v8NWy_uGTtvqLcm1STZFIJ3g5cRctP_6G827NX3jrU045ajO2Pl39OJb8gj-pqSTl855U9zmWK3Qh7fVIypPdYaWxIT7yZivtXlJx-p0XxT1Mk4EAWHpodLMrjw2MVEiR7rz5sZNL77W1T7Ntp4kLMBcExbyA20CkZvyLlfTaUFYfWGfDBHJfsEXL-wXZ5hhB76BN8DNB7mZck3WJ70X1sScVfI1GYWitsHFO2P5nZEC3abdtTgbJt-t2Nxqn4d3DzGe_ceFj6LwxC5lnHSYhQQn1J2mr1EQ7cHCUQIHFVhYzd9HYrJZFbmBu_3kbSD_Nmm0bkrzZ2Cpwq_fvOb2Q831Ps9YZvMiPL6ktJsylPvwUQlRgRsykM7ynWUEKQqoPHSjQouX5b4iW3Fta8l7obmej_ur2m5kNBNjmdqJAwrq2s2tJU862wfpTlkMscxZIsW3SKwy2E4Rmi-RPl1fYPmWq0QVGzNYh1gwloL84T_UBDZNOTXYPqgEGxjv3xofRTzyYy1n0Qwc=w1437-h937'),
                                                          fit: BoxFit.cover
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: AlignmentDirectional(0, 1),
                                                  child: Text('오늘 같이 추운날 패딩을 센스입게 입어보는 거 어때요?'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),

                          ),
                        )

                            :
                        //<---------------------로그인 필요(토큰 없음)------------------------>
                        Stack(
                          children: [
                            Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                            Flexible(flex: 1, fit: FlexFit.tight, child:
                            InkWell(
                                onTap: ()async{
                                  print('카톡로그인 클릭');
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

                                            title: new Text(Language.En?'Did not installed KaKaoTalk':"카카오톡 설치 후 실행해주세요!"),

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
                                },
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Container(//카톡로그인 버튼
                                    width: MediaQuery.of(context).size.width*0.6,
                                    height: MediaQuery.of(context).size.height*0.08,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[400],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 7.0,
                                          offset: Offset(4, 6), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/kakao.png'),
                                          Text(Language.En?'Login with KaKao':'카카오톡 로그인',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            ),
                            Flexible(flex: 1, fit: FlexFit.tight, child: Container()),
                          ],
                        ),

                          //<---------------------로그인 필요(토큰 없음)------------------------>

                      ),
                    ),
                  Padding(//시간대별 날씨
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
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
    ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
