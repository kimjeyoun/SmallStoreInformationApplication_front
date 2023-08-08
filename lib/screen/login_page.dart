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
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
    return Column(
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
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '아이디 또는 이메일',
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
              String username = _usernameController.text;
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
            child: Text('시작하기', style: TextStyle(color: Colors.white),),
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
            style: TextStyle(color: Color(0xFF10124C).withOpacity(0.4), decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }



  void _login(String username, String password, BuildContext context) async {
    String url = 'http://15.165.151.223:3000/users/login';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'id': username,
      'password': password,
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        // 로그인 성공
        _showDialog('로그인 성공', '환영합니다, $username님!');
        // 로그인 성공 시 처리할 로직 추가
        // 예: 홈 페이지로 이동 또는 다른 작업 수행
      } else if (response.statusCode == 401) {
        // 로그인 실패
        _showDialog('로그인 실패', '아이디 또는 비밀번호가 일치하지 않습니다.');
      } else {
        // 기타 오류
        _showDialog('오류', '로그인 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}


