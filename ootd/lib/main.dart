import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'widget/temp.dart';
import 'API/gsheets.dart';
import 'package:flutter/services.dart';
//신근재
void main() async
{
  await GoogleSheestApi.init();//DB구글시트연결
  KakaoSdk.init(nativeAppKey: '5f71064329b935428862eb575059fe75');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n성별: ${user.kakaoAccount?.gender}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            color: Colors.white,
            child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 200),

                    Image.asset("assets/mainpage_image.png", height: 300,width: 300,),

                    login_nextpage(),
                    SizedBox(height: 15),
                    login_logout(),
                    SizedBox(height: 15),
                    login_share(),
                    ],
                )
            )
        )
    );
  }
}

class login_nextpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(Icons.lock),
        label: Text("카카오 로그인",style: TextStyle(fontSize: 17, color: Colors.black87),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.yellow),
          foregroundColor: MaterialStateProperty.all(Colors.black54),
          minimumSize: MaterialStateProperty.all(Size(250, 50))
        ),

        onPressed: () async {
          //토큰 유효성 확인 후 로그인 시도
          try {
            AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
            User user = await UserApi.instance.me();
            print('토큰 정보 보기 성공'
                '\n회원정보: ${tokenInfo.id}'
                '\n토큰 만료시간: ${tokenInfo.expiresIn} 초');
            Navigator.push
              (context,
              MaterialPageRoute(builder: (context) => secondpage(user)),);
          } catch (error) {
            print('토큰 정보 보기 실패 $error');
            if (await isKakaoTalkInstalled()) {
              try {
                //설치 되어있다면 => 카카오톡 로그인 접속 시도
                await UserApi.instance.loginWithKakaoTalk();
                User user = await UserApi.instance.me();
                print('카카오톡으로 로그인 성공');
                Navigator.push
                  (context,
                  MaterialPageRoute(builder: (context) => secondpage(user)),);
              } catch (error) {
                print('카카오톡으로 로그인 실패 $error');
              }
            }
          }
        }
    );
  }
}

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

class login_share extends StatelessWidget {
  final FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: '딸기 치즈 케익',
      description: '#케익 #딸기 #삼평동 #카페 #분위기 #소개팅',
      imageUrl: Uri.parse(
          'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
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