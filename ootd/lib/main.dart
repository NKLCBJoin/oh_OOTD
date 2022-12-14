import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ootd/screen/alarm.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/screen/loading2.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'API/gsheets.dart';
import 'API/kakao.dart';
import 'package:flutter/services.dart';
import 'screen/settingScreen.dart';
import 'screen/startScreen.dart';
import 'package:ootd/screen/tempScreen.dart';
import 'screen/weekootdScreen.dart';
import 'widget/widget.dart';
import 'package:get/get.dart';
import 'model/model.dart';
import 'package:ootd/screen/tempScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ootd/API/notification.dart';
//신근재
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationController.initializeNotificationService();
  await GoogleSheestApi.init();//DB구글시트연결
  KakaoSdk.init(nativeAppKey: '5f71064329b935428862eb575059fe75');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,//이거 지우지말것 디버그리본없애는거 특히 재민(from지철)
            initialRoute: '/',
            routes: {
              '/' : (context) => firstPage(),
            },
          );
        }
    );
  }
}