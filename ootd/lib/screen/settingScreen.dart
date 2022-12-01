//최지철
import 'package:ootd/screen/mainScreen.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ootd/widget/widget.dart';
import 'loading.dart';
import 'package:ootd/main.dart';
import 'package:ootd/model/model.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ootd/screen/loading2.dart';
import 'package:ootd/screen/startScreen.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}
void ChangeTitle(){
  if(Language.En==true){
    Language.DarkSubtitle= DarkMode.DarkOn? 'Change to LightMode':'Change to DarkMode';
  }
  else if(Language.En==false)
  {
    Language.DarkSubtitle= DarkMode.DarkOn? '라이트모드로 변경':'다크모드로 변경';
  }
}

class _SettingsWidgetState extends State<SettingsWidget> {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var switchValue=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: DarkMode.DarkOn? Color(0xff29323c) : Colors.grey[160],
        //  backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          onPressed: () {
            LoadingData.Lol = false;
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
          },
        ),
        title: Align(
          alignment: AlignmentDirectional(-0.2, 0),
          child: Text(
            Language.En? 'Setting':'설정',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: DarkMode.DarkOn? Color(0xff29323c) : Colors.white.withOpacity(.94),
        ),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            SettingsGroup(

              items: [
                SettingsItem(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false, // 바깥 터치해도 닫히는지
                        builder: (BuildContext context) {
                          return AlertDialog(
                              backgroundColor: DarkMode.DarkOn? Color(0xff29323c) : Colors.white.withOpacity(.94),
                              title: Text(Language.En? 'Choose Language':'언어 선택',
                                style:TextStyle(
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              content: Container(
                                width: double.minPositive,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      title: Text("한국어",
                                        style:TextStyle(
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                        ) ,
                                      ),
                                      onTap: (){
                                        setState(() {
                                          Language.En= false;
                                          ChangeTitle();
                                          Navigator.of(context).pop();

                                        });
                                      },
                                      shape: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: DarkMode.DarkOn? Colors.white70:Colors.black87,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("English",
                                        style:TextStyle(
                                          color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                        ) ,
                                      ),
                                      onTap: (){
                                        setState(() {
                                          Language.En= true;
                                          ChangeTitle();
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('취소'),
                                  onPressed: () {
                                    // 다이얼로그 닫기
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]);
                        });
                  },
                  icons: Icons.language_rounded,
                  iconStyle: IconStyle(
                    withBackground: true,
                    backgroundColor: DarkMode.DarkOn? Colors.blueGrey : Colors.blue,
                  ),
                  title: Language.En? 'Language':'언어',
                  subtitle: Language.En? "English":"한국어",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: DarkMode.DarkOn? Colors.amber : Colors.white,
                    withBackground: true,
                    backgroundColor: DarkMode.DarkOn? Colors.blueGrey : Colors.red,
                  ),
                  title: Language.En?"DarkMode": '다크모드',
                  subtitle: Language.DarkSubtitle,
                  trailing: Switch.adaptive(
                    activeColor: Colors.pink,
                    activeTrackColor: Colors.pink.withOpacity(0.4),
                    value: DarkMode.DarkOn,
                    onChanged: (value) {
                      setState(() {
                        this.switchValue=DarkMode.DarkOn;
                        switchValue=value;
                        DarkMode.DarkOn=switchValue;
                        ChangeTitle();
                      }
                      );
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false, // 바깥 터치해도 닫히는지
                        builder: (BuildContext context) {
                          return AlertDialog(
                              backgroundColor: DarkMode.DarkOn? Color(0xff29323c) : Colors.white.withOpacity(.94),
                              title: Text(Language.En?'About Our Team':'카카오 입사 예정자들 소개',
                                style:TextStyle(
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              content: Text('한국에 있는 최상위 IT기업중 한곳인 카카오 또한 가볍게 입사한다는 마음가짐으로 모인 개발자 그룹이다.                                 후원계좌: 케이뱅크 100-101-970-123 감사합니다.',
                                style:TextStyle(
                                  color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('확인'),
                                  onPressed: () {
                                    // 다이얼로그 닫기
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]);
                        });
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor:  DarkMode.DarkOn? Colors.brown : Colors.purple,
                  ),
                  title: 'About',
                  subtitle: Language.En?"Who is the KakaoTakDae?":"카카오 입사 예정자들이란?",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: Language.En?"Account":"   계정",
              settingsGroupTitleStyle: TextStyle(
                  color: DarkMode.DarkOn? Colors.white :Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
              items: [
                SettingsItem(
                  onTap: () async {

                    Get.isDarkMode?
                    Get.changeTheme(ThemeData.light()):
                    Get.changeTheme(ThemeData.dark());

                    try {
                      await UserApi.instance.unlink();
                      showDialog(
                          context: context,
                          barrierDismissible: false, // 바깥 터치해도 닫히는지
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor: DarkMode.DarkOn? Color(0xff29323c) : Colors.white.withOpacity(.94),
                                title: Text('로그아웃 성공!',
                                  style:TextStyle(
                                    color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                  ),
                                ),
                                content: Text('확인버튼을 눌러주세요!',
                                  style:TextStyle(
                                    color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      // 메인으로 이동
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>firstPage()));
                                    },
                                  ),
                                ]);
                          });
                    } catch (error) {
                      showDialog(
                          context: context,
                          barrierDismissible: false, // 바깥 터치해도 닫히는지
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor: DarkMode.DarkOn? Color(0xff29323c) : Colors.white.withOpacity(.94),
                                title: Text('로그아웃 실패!',
                                  style:TextStyle(
                                    color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                  ),
                                ),
                                content: Text('로그인이 되어있지 않거나\n오류가 발생했습니다.',
                                  style:TextStyle(
                                    color: DarkMode.DarkOn? Colors.white:Colors.black87,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      // 메인으로 이동
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ]);
                          });
                    }


                  },
                  icons: Icons.exit_to_app_rounded,
                  title: Language.En?"Logout":"로그아웃",
                ),
                SettingsItem(
                  onTap: () {
                    Get.isDarkMode?
                    Get.changeTheme(ThemeData.light()):
                    Get.changeTheme(ThemeData.dark());
                  },
                  icons: CupertinoIcons.delete_solid,
                  title: Language.En?'Delete Account':"회원탈퇴",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}