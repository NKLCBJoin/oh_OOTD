// 네트워크 연결 및 응답
import 'package:http/http.dart' as http;
import 'dart:convert';


class Network {
  late final String url;

  Network(this.url);

  Future <dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      var id = parsingData['id'];
      print(id);
      return parsingData;
    }
  }
}