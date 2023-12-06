import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:where_shop_project/screen/main_page.dart';

class LoginPage extends StatefulWidget {
  final String shopNum;
  final String userroll;

  const LoginPage(this.shopNum, this.userroll);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  static final storage = FlutterSecureStorage();

  String loginType = 'localLogin';

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


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF4876F2),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60),
                Image.asset(
                  'asset/img/wordmark_white.png',
                  width: 90,
                ),
                SizedBox(height: 100),
                Text(
                  '이미 회원이신가요?',
                  style: TextStyle(
                    fontFamily: 'Sandoll',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300, // 원하는 너비로 설정
                    child: TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: '아이디 또는 이메일',
                        labelStyle: TextStyle(
                          fontFamily: 'Sandoll',
                          fontSize: 13, // 원하는 폰트 크기로 조정
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB8B8B8), // 원하는 색상으로 조정
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300, // 원하는 너비로 설정
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        labelStyle: TextStyle(
                          fontFamily: 'Sandoll',
                          fontSize: 13, // 원하는 폰트 크기로 조정
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB8B8B8), // 원하는 색상으로 조정
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300, // 원하는 너비로 설정
                  child: ElevatedButton(
                    onPressed: () {
                      String username = _idController.text;
                      String password = _passwordController.text;
                      _login(username, password, context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48), // 버튼의 최소 너비를 설정
                      primary: Color(0xFF143386), // 버튼의 배경색을 회색으로 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('로그인', style: TextStyle(
                      fontFamily: 'Sandoll',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/selection');
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
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
                          '쉽고 빠른 회원가입',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/pwfindfirst');
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
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
                          '비밀번호를 잊으셨나요?',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MainPage(widget.userroll, widget.shopNum)
                        )
                    );
                  },
                  child: Text('main'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mypagebn');
                  },
                  child: Text('mypagebn'),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }


  void _login(String id, String password, BuildContext context) async {
    // String url = 'http://15.165.151.223:3000/users/login';
    String url = 'http://10.0.2.2:3000/users/login';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'id': id,
      'loginType' : loginType,
      'password': password,
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        // 로그인 성공
        // HTTP 응답 헤더 데이터
        Map<String, String> headers = response.headers;

        // token 값 추출
        String? refreshToken = headers['refreshtoken']?.replaceFirst('bearer ', "");
        String? accessToken = headers['authorization']?.replaceFirst('bearer ', "");

        await storage.write(key: 'refreshToken', value: refreshToken);
        await storage.write(key: 'accessToken', value: accessToken);
        _showDialog('로그인 성공', '환영합니다!');
        // 로그인 성공 시 처리할 로직 추가
        // 예: 홈 페이지로 이동 또는 다른 작업 수행
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(widget.userroll, widget.shopNum)
            )
        );
      } else {
        // 기타 오류
        print("로그인 실패1 ${response.statusCode}");
        _showDialog('오류', '로그인 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("트라이문 오류");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }

  void _logout(BuildContext context) async {
    String url = 'http://10.0.2.2:3000/users/logout';
    String? refreshToken = await storage.read(key: 'refreshToken');
    String? accessToken = await storage.read(key: 'accessToken');

    try {
      http.Response response = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'bearer $accessToken',
            'refreshToken': 'bearer $refreshToken',
          });

      //storage.delete(key: 'refreshToken');
      //storage.delete(key: 'accessToken');

      if (response.statusCode == 200) {
        _showDialog('로그아웃 성공', '안녕히가세요!');
      } else {
        // 로그인 실패
        print("로그아웃 실패 ${response.statusCode}");
        _showDialog('로그아웃 실패', 'error');
      };
    } catch (e) {
      print("트라이문 오류${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}


