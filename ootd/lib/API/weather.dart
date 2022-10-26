import 'package:http/http.dart' as http;

class Network{

  String url = 'https://api.openweathermap.org/data/2.5/weather?q=Gumi&appid=4293fbff2c2e4d5c80ce32cea6e1b5be';
  Network(this.url);
  Future<dynamic> getJson() async{
    http.Response response =
        await http.get(Uri.parse(url));

    return response;
  }
}

