import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where_shop_project/screen/kakao_additional_information_page.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _register_kakao(String id, String password, final accessToken, String userroll) async {
    String url = 'http://10.0.2.2:3000/users/signup';


    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'id': id,
      'loginType': 'kakaoLogin',
      'password': password,
      "userRole": userroll,
      "verifyRole": "VERIFYFALSE",
    };



    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        // 회원가입 성공 시 처리할 로직 추가
        print('카카오 회원가입 성공');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    KakaoAdditionalInfomationPage(id, password, accessToken, userroll)
            )
        );
      } else {
        // 기타 오류
        print('카카오 회원가입 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('오류', '카카오 회원가입 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }

  void _kakaoLoginButtonPressed() async {
    try {
      if (await AuthApi.instance.hasToken()) {
        try {
          AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
          print('토큰 유효성 체크 성공 ${tokenInfo}');

          // 여기에서 토큰이 유효할 때의 로직을 추가할 수 있습니다.
          _verifyKakaoToken(tokenInfo);

        } catch (error) {
          if (error is KakaoException && error.isInvalidTokenError()) {
            print('토큰 만료 $error');
          } else {
            print('토큰 정보 조회 실패 $error');
          }

          try {
            // 카카오 계정으로 로그인
            OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
            print('로그인 성공 ${token.accessToken}');

            // 여기에서 토큰이 유효할 때의 로직을 추가할 수 있습니다.
            if(await AuthApi.instance.hasToken()) {
              AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
              _verifyKakaoToken(tokenInfo);
            } else {
              print('토큰 발급 실패');
            }

          } catch (error) {
            print('로그인 실패 $error');
          }
        }
      } else {
        print('발급된 토큰 없음');
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('로그인 성공 ${token.accessToken}');

          // 여기에서 토큰이 유효할 때의 로직을 추가할 수 있습니다.
          if(await AuthApi.instance.hasToken()) {
            AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
            _verifyKakaoToken(tokenInfo);
          } else {
            print('토큰 발급 실패');
          }
        } catch (error) {
          print('로그인 실패 $error');
        }
      }

      // 사용자 정보 요청 등 추가 로직은 여기에 작성

    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }


  void _verifyKakaoToken(final accessToken) async {
    try {
      User user = await UserApi.instance.me();
      print('사용지 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n닉네임: ${user.kakaoAccount?.email}'
          '\n모든 정보: ${user.kakaoAccount}'
      );
      String id = user.id.toString();
      String pw = 'kakaoLogin1234';
      _register_kakao(id, pw, accessToken, 'USER');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }

    User user;

    try {
      user = await UserApi.instance.me();
    } catch (error) {
      print('사용자 정보 요청 실패1 $error');
      return;
    }

    List<String> scopes = [];

    if (user.kakaoAccount?.emailNeedsAgreement == true) {
      scopes.add('account_email');
    }
    if (user.kakaoAccount?.birthdayNeedsAgreement == true) {
      scopes.add("birthday");
    }
    if (user.kakaoAccount?.birthyearNeedsAgreement == true) {
      scopes.add("birthyear");
    }
    if (user.kakaoAccount?.ciNeedsAgreement == true) {
      scopes.add("account_ci");
    }
    if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) {
      scopes.add("phone_number");
    }
    if (user.kakaoAccount?.profileNeedsAgreement == true) {
      scopes.add("profile");
    }
    if (user.kakaoAccount?.ageRangeNeedsAgreement == true) {
      scopes.add("age_range");
    }

    if (scopes.length > 0) {
      print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

      // OpenID Connect 사용 시
      // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
      // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
      // scopes.add("openid")

      //scope 목록을 전달하여 카카오 로그인 요청
      OAuthToken token;
      try {
        token = await UserApi.instance.loginWithNewScopes(scopes);
        print('현재 사용자가 동의한 동의 항목: ${token.scopes}');
      } catch (error) {
        print('추가 동의 요청 실패 $error');
        return;
      }

      // 사용자 정보 재요청
      try {
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}'
            '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
            '\n이메일: ${user.kakaoAccount?.email}');
      } catch (error) {
        print('사용자 정보 요청 실패2 $error');
      }
    }
  }

  void _kakaoLogout() async {
    try {
      await UserApi.instance.logout();
    } catch(error) {
      print('로그아웃 실패: ${error}');
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
                SizedBox(height: 50),
                Image.asset(
                  'asset/img/wordmark_white.png',
                  width: 200,
                ), // 로고 이미지 파일을 assets 폴더에 추가한 뒤 경로에 맞게 수정
                SizedBox(height: 15),
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
          // ElevatedButton(
            // onPressed: () {
              // _kakaoLogout();
            // },
            // child: Text('로그아웃'),
          // ),
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
                    _kakaoLoginButtonPressed();
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');

                    if(error is PlatformException && error.code == 'CANCELED') {
                      return;
                    }
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





