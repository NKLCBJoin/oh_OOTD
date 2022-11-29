import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../model/temp.dart';
import '../API/gsheets.dart';
import 'package:flutter/services.dart';
//신근재

//<-------------------로그인 버튼 클래스 정의----------------------->
class login_nextpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(Icons.lock),
        label: Text("카카오 로그인",style: TextStyle(fontSize: 17, color: Colors.black87),),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow),
            foregroundColor: MaterialStateProperty.all(Colors.black54),
            minimumSize: MaterialStateProperty.all(Size(100, 50))
        ),

        onPressed: () async {
          //[1] 카카오톡 설치 여부
          if(await isKakaoTalkInstalled()){
            try {
              //[2] 이미 로그인 했나 토큰 유효성 확인 후 로그인 시도
              AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
              User user = await UserApi.instance.me();//유저 정보 user에 담는다.
              print('토큰 정보 보기 성공'
                  '\n회원정보: ${tokenInfo.id}'
                  '\n토큰 만료시간: ${tokenInfo.expiresIn} 초');
              //[3]정상적으로 토큰 성공을 한 경우 메인 페이지로 다시 돌아갑니다.
              Navigator.push
                (context,
                MaterialPageRoute(builder: (context) => secondpage(user)),);
            } catch (error) {
              print('토큰 정보 보기 실패 $error');
              try {
                //[2-1] 카카오톡 로그인 접속 시도
                await UserApi.instance.loginWithKakaoTalk();
                User user = await UserApi.instance.me();
                print('카카오톡으로 로그인 성공');
                //★★★★★★★★★다음 페이지 넘어가면서 user넘겨줌★★★★★★★★★
                //model폴더의 temp.dart를 보면 user 사용 예시 찾기 가능
                Navigator.push
                  (context,
                  MaterialPageRoute(builder: (context) => secondpage(user)),);
              } catch (error) {
                print('카카오톡으로 로그인 실패 $error');
              }
            }
          }
          //[1-1 카카오톡 미설치
          else{
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),

                    title: new Text("카카오톡 설치 후 실행해주세요!"),

                    actions: <Widget>[
                      new ElevatedButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          }
        }
    );
  }
}

//<-------------------로그아웃 클래스 정의----------------------->
class login_logout extends StatelessWidget {
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
class login_share extends StatelessWidget {
  final FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: 'OOTD추천',
      description: '주간 날씨에 대한 정보를 소개합니다',
      imageUrl: Uri.parse(
          'https://images.unsplash.com/photo-1661956602926-db6b25f75947?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2M3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
      link: Link(
          webUrl: Uri.parse('https://developers.kakao.com'),
          mobileWebUrl: Uri.parse('https://developers.kakao.com')),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      icon: Icon(Icons.share_sharp),
      label: Text("공유하기",style: TextStyle(fontSize: 17, color: Colors.black87),),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.yellow),
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        minimumSize: MaterialStateProperty.all(Size(250, 50)),
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

//<----------------테스트용 코드 <삭제 가능>------------------>
//class Kakao extends StatelessWidget {
//   const Kakao({ Key? key }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//           children: [
//             SizedBox(height: 200),
//             Image.asset("assets/mainpage_image.png", height: 300,width: 300,),
//
//             login_nextpage(),
//             SizedBox(height: 15),
//             login_logout(),
//             SizedBox(height: 15),
//             login_share(),
//           ],
//         )
//     );
//   }
// }