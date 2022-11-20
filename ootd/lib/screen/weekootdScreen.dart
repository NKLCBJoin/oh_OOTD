import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ootd/screen/loading.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ootd/screen/menu.dart';
//최지철
class WeekootdPage extends StatefulWidget {
  const WeekootdPage({Key? key}) : super(key: key);
  @override
  _WeekootdPageState createState() => _WeekootdPageState();
}

class _WeekootdPageState extends State<WeekootdPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
          },
        ),
        actions:<Widget> [
          IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            onPressed: ()  {
            },
          ),

        ],
        centerTitle: false,
      ),

      body: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffa1c4fd),
                      Color(0xffc2e9fb),
                    ]
                )
            ),
            child: ListView(
              padding: EdgeInsetsDirectional.fromSTEB(10, 65, 10, 10),
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Monday',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                fontSize: 30,
                                fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Tuesday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Wednesday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Thursday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Friday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Saturday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 380,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffa1c4fd).withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(4, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Sunday',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(color: Colors.black,letterSpacing: 5),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
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
    );
  }
}
