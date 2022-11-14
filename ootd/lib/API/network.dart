// 네트워크 연결 및 응답
import 'package:http/http.dart' as http;
import 'dart:convert';


class Network {
  late final String url;
  late final String url2;

  Network(this.url,this.url2);

  Future <dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      // var id = parsingData['id'];
      // print(id);
      return parsingData;
    }
  }
  Future <dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
class Network2 {
  late final String url;

  Network2(this.url);

  Future <dynamic> getHourWeatherData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}