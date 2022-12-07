import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:ootd/model/model.dart';
import ' translation.dart';

//--------------------------이용구 위지 정보 얻는 코드
//이용구 주소 검색받아 전역변수 x_pos, y_pos(좌표값 지정), gu, si(주소 정보 구와 시) data 넣기


class location_func { //이 함수를 실행하면 현재 위치를 기준으로 젼역변수 x_pos, y_pos에 좌표가 들어간다.
  Future Nowlocation() async {
    //현재 위치를 얻기 위한 작업
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //현재위치를 position이라는 변수로 저장
    location.x_pos = position.longitude;
    location.y_pos = position.latitude;

    print("Nowlocation안, 현재 좌표들");
    print(location.x_pos);
    print(location.y_pos);
  }



  Future geolocation_func() async { //젼역변수 x_pos, y_pos 좌표 기준으로 gu와 si에 주소가 들어간다.
    //좌표를 받아 주소로 바꿔주는 작업
    print("geolocation_func 실행");
    Response response = await get(
        Uri.parse("https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=${location.x_pos.toString()},${location.y_pos.toString()}&sourcecrs=epsg:4326&output=json"), headers: location.headerss);
    // 미리 만들어둔 headers map을 헤더에 넣어준다.
    String jsonData_regeocode = response.body;
    //response에서 body부분만 받아주는 변수 만들어주공~
    print(jsonData_regeocode);// 확인한번하고
    location.gu = jsonDecode(jsonData_regeocode)["results"][1]['region']['area2']['name'];
    location.si = jsonDecode(jsonData_regeocode)["results"][1]['region']['area1']['name'];

    print("Nowlocation안, 현재 주소");
    print(location.gu+location.si);

    await getTranslation_papago();
    print("Nowlocation안, 현재 영어 주소");
    print(location.address_en);
  }




  Future<List> fetchData() async { //이 함수 실행 시 address값을 이용해 좌표를 x_pos, y_pos에 좌표 값을 넣어준다.

    location.loding_value=2;
    print("fetchData 시작");
    print(location.address);
    //주소를 받아 좌표로 바꿔주는 작업
    Response response2 = await get(
        Uri.parse("https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${location.address}"),headers: location.headerss);
    print("fetchData uri.parse 종료");
    String jsonData_geocode = response2.body;
    print(jsonData_geocode);
    String x_pos_s = jsonDecode(jsonData_geocode)["addresses"][0]['x'];
    String y_pos_s = jsonDecode(jsonData_geocode)["addresses"][0]['y'];
    //location.x_pos = jsonDecode(jsonData_geocode)["addresses"][0]['x'];
    //location.y_pos = jsonDecode(jsonData_geocode)["addresses"][0]['y'];
    print("fetchData 속, 좌표들");

    print(x_pos_s);
    print(y_pos_s);

    location.x_pos = (double.parse(x_pos_s));
    location.y_pos = (double.parse(y_pos_s));



    print(location.x_pos);
    print(location.y_pos);

    List<String> coordinate = [location.x_pos.toString(), location.y_pos.toString()];



    //좌표를 받아 주소로 바꿔주는 작업
    Response response = await get(
        Uri.parse("https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=${location.x_pos.toString()},${location.y_pos.toString()}&sourcecrs=epsg:4326&output=json"), headers: location.headerss);
    // 미리 만들어둔 headers map을 헤더에 넣어준다.
    String jsonData_regeocode = response.body;
    //response에서 body부분만 받아주는 변수 만들어주공~
    print(jsonData_regeocode);// 확인한번하고
    location.gu = jsonDecode(jsonData_regeocode)["results"][1]['region']['area2']['name'];
    location.si = jsonDecode(jsonData_regeocode)["results"][1]['region']['area1']['name'];
    print(location.gu);
    print(location.si);

    await getTranslation_papago();
    print("Nowlocation안, 현재 영어 주소");
    print(location.address_en);

    return coordinate; //좌표값 리턴
  } //좌표 데이터 동기로 받는 함수

}