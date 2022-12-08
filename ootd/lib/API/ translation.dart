import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ootd/model/model.dart';

Future<void> getTranslation_papago() async {
  String _client_id = "EwbOutIX3rGahw4pQMuV";
  String _client_secret = "zQb1EjLsOi";
  String _content_type = "application/x-www-form-urlencoded; charset=UTF-8";
  String _url = "https://openapi.naver.com/v1/papago/n2mt";

  http.Response trans = await http.post(
    Uri.parse(_url),
    headers: {
      'Content-Type': _content_type,
      'X-Naver-Client-Id': _client_id,
      'X-Naver-Client-Secret': _client_secret
    },
    body: {
      'source': "ko",//위에서 언어 판별 함수에서 사용한 language 변수
      'target': "en",//원하는 언어를 선택할 수 있다.
      'text': location.gu,
    },
  );
  if (trans.statusCode == 200) {
    var dataJson = jsonDecode(trans.body);
    var result_papago = dataJson['message']['result']['translatedText'];
    location.address_en = result_papago;
  } else {
    print(trans.statusCode);
  }
}