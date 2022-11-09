import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation{
  double ?latitude2;
  double ?longtitude2;
  Future <void> getMyCurrentLocation() async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longtitude2 = position.longitude;
    }catch(e){
      print('네트워크 오류 & 허가거부');
    }
  }
}