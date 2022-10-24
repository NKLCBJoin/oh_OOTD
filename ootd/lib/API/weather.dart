import 'package:http/http.dart' as http;

/*class Network{
  final String url;
  Network(this.url);
  Fuuture<dynamic> getJson() async{
    http.Response response =
        await http.get(Uri.parse(url));

    return response;
  }
}*/

class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}


class _LoadingState extends State<> {
  @override
  void initState(){
    super.initState();
    fetchData();
  }
  void fetchData() async{
    Response response = await get('https://samples.openweathermap.org'
        '/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');
    print(response.statusCode);
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
