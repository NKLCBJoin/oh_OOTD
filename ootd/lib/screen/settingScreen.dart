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

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
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
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
          },
        ),
        title: Align(
          alignment: AlignmentDirectional(-0.1, 0),
          child: Text(
            '설정',
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
                  onTap: () {},
                  icons: Icons.language_rounded,
                  iconStyle: IconStyle(
                    withBackground: true,
                    backgroundColor: DarkMode.DarkOn? Colors.blueGrey : Colors.blue,
                  ),
                  title: '언어',
                  subtitle: "한국어",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: DarkMode.DarkOn? Colors.amber : Colors.white,
                    withBackground: true,
                    backgroundColor: DarkMode.DarkOn? Colors.blueGrey : Colors.red,
                  ),
                  title: '다크모드',
                  subtitle: "수동",
                  trailing: Switch.adaptive(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue=value;
                        DarkMode.DarkOn=switchValue;
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
                              title: Text('카카오 입사 예정자들 소개'),
                              content: Text('한국에 있는 최상위 IT기업중 한곳인 카카오 또한 가볍게 입사한다는 마음가짐으로 모인 개발자 그룹이다.                                 후원계좌: 케이뱅크 100-101-970-123 감사합니다.'),
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
                  subtitle: "카카오 입사 예정자들이란?",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "   계정",
              settingsGroupTitleStyle: TextStyle(
                color: DarkMode.DarkOn? Colors.white :Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
              items: [
                SettingsItem(
                  onTap: () {
                    Get.isDarkMode?
                    Get.changeTheme(ThemeData.light()):
                    Get.changeTheme(ThemeData.dark());
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "로그아웃",
                ),
                SettingsItem(
                  onTap: () {
                    Get.isDarkMode?
                    Get.changeTheme(ThemeData.light()):
                    Get.changeTheme(ThemeData.dark());
                  },
                  icons: CupertinoIcons.delete_solid,
                  title: "회원탈퇴",
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