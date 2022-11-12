//최지철       child: WeatherBg(weatherType: WeatherType.thunder,width: 540,height: 815,)
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/flutter_animated_icons.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:flutter_animated_icons/useanimations.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/screen/settingScreen.dart';
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>with TickerProviderStateMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _menuController;
  late AnimationController _bellController;

  void initState(){//메뉴바에 관한변수. 최지철
    _menuController = AnimationController(vsync: this , duration: const Duration(seconds: 1));
    _bellController= AnimationController(vsync: this , duration: const Duration(seconds: 1));
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
            Icons.menu,
            size: 30,
          ),
          onPressed: () {
            print('위치.');
          },
        ),
        actions: <Widget>[
          IconButton(
            splashRadius: 50,
            iconSize: 100,
            icon: Lottie.asset(Useanimations.menuV3,
                controller: _menuController,
                height: 60,
                fit: BoxFit.fitHeight
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              ),
              accountName: Text('섹스신 근재'), accountEmail: Text('SexShin@gmail.com'),
              decoration: BoxDecoration(
                  color: Colors.red[200],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
                size: 20,
              ),
              title: Text("홈으로"),
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
              leading: Lottie.asset(LottieFiles.$63128_bell_icon,
                  controller: _bellController,
                  height: 20,
                  fit: BoxFit.cover
              ),
              title: Text("알림 설정"),
              onTap: (){ //알람 기능 선택시
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
                Icons.home,
                color: Colors.grey,
                size: 20,
              ),
              title: Text("주간OOTD"),
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
                Icons.settings,
                color: Colors.grey,
                size: 20,
              ),
              title: Text("설정"),
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
      body: Center(
        child: GestureDetector(
          onTap: () => {
            FocusScope.of(context).unfocus(),
          },
          child: Stack(
            children: [
              WeatherBg(weatherType: WeatherType.thunder,width: 540,height: 815,),
              Align(
                alignment: AlignmentDirectional(-0.05, -0.25),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                  child: Container(//옷추천
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.95),
                child: Padding(//실시간날씨
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                  child: Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 0,
                      ),
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
