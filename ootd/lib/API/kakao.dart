//신근재
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../API/gsheets.dart';
import 'package:flutter/services.dart';
import 'package:ootd/model/model.dart';
import 'package:ootd/screen/weekootdScreen.dart';

//<-------------------로그아웃 클래스 정의----------------------->
class KakaoLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.autorenew_outlined),
      label: Text("로그아웃",style: TextStyle(fontSize: 17, color: Colors.black87),),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.yellow),
          foregroundColor: MaterialStateProperty.all(Colors.black54),
          minimumSize: MaterialStateProperty.all(Size(250, 50))
      ),
      onPressed: () async {
        try {
          await UserApi.instance.unlink();
          print('연결 끊기 성공, SDK에서 토큰 삭제');
        } catch (error) {
          print('연결 끊기 실패 $error');
        }
      },
    );
  }
}

//<-------------------공유 클래스 정의----------------------->
class KakaoShare extends StatelessWidget {
  final FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: '',
      description: '',
      imageUrl: Uri.parse(
          'https://cdn.pixabay.com/photo/2022/11/24/02/28/clouds-7613361__340.png'),
      link: Link(
          //<-------웹 사용 X---------->
          webUrl: Uri.parse(''),
          mobileWebUrl: Uri.parse('')),
    ),
    itemContent: ItemContent(
      profileText: '주간 OOTD',
      items: [
        ItemInfo(item: '월', itemOp: '맑음 10도'),
        ItemInfo(item: '화', itemOp: '맑음 10도'),
        ItemInfo(item: '수', itemOp: '맑음 10도'),
        ItemInfo(item: '목', itemOp: '맑음 10도'),
        ItemInfo(item: '금', itemOp: '맑음 10도'),
        ItemInfo(item: '토', itemOp: '맑음 10도'),
        ItemInfo(item: '일', itemOp: '맑음 10도')
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      icon: Icon(Icons.share_sharp),
      label: Text("공유하기",style: TextStyle(fontSize: 10, color: Colors.black87),),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.yellow),
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
      onPressed: () async {
        if(await ShareClient.instance.isKakaoTalkSharingAvailable()) {
          try {
            Uri uri = await ShareClient.instance.shareDefault(template: defaultFeed);
            await ShareClient.instance.launchKakaoTalk(uri);
            print('카카오톡 공유 완료');
          } catch (error) {
            print('카카오톡 공유 실패 $error');
          }
        }
      },
    );
  }
}