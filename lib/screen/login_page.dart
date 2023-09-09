import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4876F2),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login(String id, String password, BuildContext context) async {
    // String url = 'http://15.165.151.223:3000/users/login';
    String url = 'http://10.0.2.2:3000/users/login';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'id': id,
      'password': password,
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));


      if (response.statusCode == 200) {
        // 로그인 성공
        print("로그인 성공 ${response.body}");
        _showDialog('로그인 성공', '환영합니다, $id님!');
        // 로그인 성공 시 처리할 로직 추가
        // 예: 홈 페이지로 이동 또는 다른 작업 수행
      } else if (response.statusCode == 401) {
        // 로그인 실패
        print("로그인 실패");
        _showDialog('로그인 실패', '아이디 또는 비밀번호가 일치하지 않습니다.');
      } else {
        // 기타 오류
        print("로그인 실패2 ${response.statusCode}");
        _showDialog('오류', '로그인 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("트라이문 오류");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150),
              Text(
                '이미 회원이신가요?',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300, // 원하는 너비로 설정
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: '아이디 또는 이메일',
                      labelStyle: TextStyle(
                        fontSize: 13, // 원하는 폰트 크기로 조정
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCACACA), // 원하는 색상으로 조정
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300, // 원하는 너비로 설정
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: TextStyle(
                        fontSize: 13, // 원하는 폰트 크기로 조정
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCACACA), // 원하는 색상으로 조정
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
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
                  child: Text('로그인', style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/selection');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                ),
                child: Text(
                  '쉽고 빠른 회원가입',
                  style: TextStyle(
                      color: Color(0xFFCACACA),
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/map');
                },
                child: Text('kakao map'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


