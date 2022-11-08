import 'package:flutter/widgets.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:flutter/material.dart';

class firstPage extends StatelessWidget {
  const firstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/anifirst.gif'),
              ),
            ),
            child: Column(
              children: [

              ],
            )
        )
    );
  }
}