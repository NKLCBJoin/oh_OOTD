import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:ootd/temp.dart';

void main() {
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

    return MaterialApp(
        home: Container(
            color: Colors.white,
            child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 200,width: 400,),

                    Image.asset("images/mainpage_image.png", height: 300,width: 4300,),

                    SizedBox(
                          child: ElevatedButton.icon(
                              icon: Icon(Icons.lock),
                              label: Text("카카오 계정으로 로그인",style: TextStyle(fontSize: 17, color: Colors.black87),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.yellow),
                                foregroundColor: MaterialStateProperty.all(Colors.black54),
                              ),

                              onPressed: () async {
                                if (await isKakaoTalkInstalled()) {
                                  try {
                                    await UserApi.instance.loginWithKakaoTalk();
                                    print('카카오톡으로 로그인 성공');
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(builder: (context) => const secondpage()));
                                    _get_user_info();

                                  } catch (error) {
                                    print('카카오톡으로 로그인 실패 $error');
                                  }
                                }
                              }
                          ),
                        ),
                ElevatedButton.icon(
                  icon: Icon(Icons.autorenew_outlined),
                  label: Text("로그아웃",style: TextStyle(fontSize: 17, color: Colors.black87),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow),
                    foregroundColor: MaterialStateProperty.all(Colors.black54),
                  ),
                  onPressed: () async {
                    try {
                      await UserApi.instance.unlink();
                      print('연결 끊기 성공, SDK에서 토큰 삭제');
                    } catch (error) {
                      print('연결 끊기 실패 $error');
                    }
                  },
                ),

                    ElevatedButton.icon(
                      icon: Icon(Icons.autorenew_outlined),
                      label: Text("공유하기",style: TextStyle(fontSize: 17, color: Colors.black87),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.yellow),
                        foregroundColor: MaterialStateProperty.all(Colors.black54),
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
                    ),
                  ],
                )
            )
        )
    );
  }
}