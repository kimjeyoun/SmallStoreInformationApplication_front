import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/cupertino.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  void _kakaoLoginButtonPressed() async {
    try {
      User user = await UserApi.instance.me();
      print('사용지 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4876F2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('asset/img/logo.png'), // 로고 이미지 파일을 assets 폴더에 추가한 뒤 경로에 맞게 수정
                Text(
                  '우리 동네 숨은 가게,\n어디있샵',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sandoll',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF4876F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white)
                    ),
                  ),
                  child: Opacity(
                    opacity: 0.8,
                    child: Text(
                      '다른 방법으로 로그인',
                      style: TextStyle(
                        fontFamily: 'Sandoll',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              // 카카오 소셜 로그인 버튼 클릭 시 처리
              onPressed: () async {
                if (await isKakaoTalkInstalled()) {
                  try {
                    await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공');
                    _kakaoLoginButtonPressed();
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');
                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      _kakaoLoginButtonPressed();
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                } else {
                  try {
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공');
                    _kakaoLoginButtonPressed();
                  } catch (error) {
                    // 해시 값을 얻어오기
                    final ssss = await KakaoSdk.origin;
                    print('해시값 : ${ssss}');
                    print('카카오계정으로 로그인 실패 $error');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFEDE04),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                '카카오계정으로 시작하기',
                style: TextStyle(
                  fontFamily: 'Sandoll',
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: Color(0xFF533B1C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





