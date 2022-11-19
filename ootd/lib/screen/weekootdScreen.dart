import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 300,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Monday',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 300,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Tuesday',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 300,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Wednesday',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 300,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Thursday',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 300,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Friday',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 300,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Saturday',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Container(
                          width: 300,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 5.0,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Sunday',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 10),
                child:Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 5.0,
                        offset: Offset(0, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                      ),
                    ],
                  ),

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
