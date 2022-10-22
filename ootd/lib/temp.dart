import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class secondpage extends StatelessWidget {
  User user;
  secondpage(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 300,),

                Text(
                  '해당 유저의 정보를 읽어옵니다.'
                  '\n회원번호: ${user.id}'
                  '\n성별: ${user.kakaoAccount?.gender}'
                  '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'),
              ],
            ),
          ),
        )
    );
  }
}
