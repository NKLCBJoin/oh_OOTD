//최지철
import 'package:ootd/screen/mainScreen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading.dart';



class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
     // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
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
          alignment: AlignmentDirectional(-0.3, 0),
          child: Text(
            '설정',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            children: [

              SettingsList(
                sections: [

                  SettingsSection(
                    title: Text('언어 및 기타'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: Icon(Icons.language),
                        title: Text('언어'),
                        value: Text('한국어'),
                      ),
                      SettingsTile.switchTile(
                        onToggle: (value) {

                        },
                        initialValue: true,
                        leading: Icon(Icons.dark_mode),
                        title: Text('다크모드'),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Text('계정'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: Icon(Icons.account_box_outlined),
                        title: Text('계정정보'),
                      ),
                      SettingsTile.navigation(
                        leading: Icon(Icons.accessibility),
                        title: Text('회원탈퇴'),
                      ),
                    ],
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