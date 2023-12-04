import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where_shop_project/screen/email_verify.dart';

class CustomerAddInfoPage extends StatefulWidget {
  final String id;
  final String phoneNum;

  const CustomerAddInfoPage(this.id, this.phoneNum);

  @override
  _CustomerAddInfoPageState createState() => _CustomerAddInfoPageState();
}

class _CustomerAddInfoPageState extends State<CustomerAddInfoPage> {
  // FocusNode 변수
  FocusNode _addressFocusNode = FocusNode();
  bool _showLabel_address = true;

  FocusNode _nicknameFocusNode = FocusNode();
  bool _showLabel_nickname = true;

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
    _addressFocusNode.addListener(() {
      setState(() {
        _showLabel_address =
        !_addressFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _nicknameFocusNode.addListener(() {
      setState(() {
        _showLabel_nickname =
        !_nicknameFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
  }

  // 함수

  @override
  void dispose() {
    super.dispose();
  }

  // 컨트롤러
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();

  // 함수

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

  // 위젯 빌드 시작
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Color(0xFF4876F2),
          body: SingleChildScrollView(
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1.0,
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.white, // 뒤로가기 버튼 색상
                          ),
                          const SizedBox(width: 100),
                          Image.asset(
                            'asset/img/wordmark_white.png',
                            width: 90,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 80,
                            horizontal: 40
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '추가 정보를 입력해주세요',
                              style: TextStyle(
                                fontFamily: 'Sandoll',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),

                            SizedBox(height: 85),

                            // phoneNum TextField

                            TextField(
                              focusNode: _addressFocusNode,
                              controller: _addressController,
                              onTap: () {
                                setState(() {
                                  _showLabel_address = false;
                                });
                              },
                              showCursor: false, // 커서 숨기기
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                  filled: true, // 배경 색상을 사용하도록 설정
                                  fillColor: Colors.white, // 배경 색상 설정
                                  labelText:
                                  _showLabel_address ? '위치' : null,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Sandoll',
                                    fontSize: 13,
                                    color: Colors.grey.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 13.2
                                  ),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.5),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )
                                  )
                              ),
                            ),

                            SizedBox(height: 25),

                            // nickname TextField
                            TextField(
                              focusNode: _nicknameFocusNode,
                              controller: _nicknameController,
                              onTap: () {
                                setState(() {
                                  _showLabel_nickname = false;
                                });
                              },
                              showCursor: false, // 커서 숨기기
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                  filled: true, // 배경 색상을 사용하도록 설정
                                  fillColor: Colors.white, // 배경 색상 설정
                                  labelText:
                                  _showLabel_nickname ? '닉네임' : null,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Sandoll',
                                    fontSize: 13,
                                    color: Colors.grey.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 13.2
                                  ),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.5),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )
                                  )
                              ),
                            ),

                            SizedBox(height: 25),

                            // next btn
                            ElevatedButton(
                              onPressed: () {
                                String phoneNum = _addressController.text;
                                String verifyNum = _nicknameController.text;

                                if (!_addressController.text.isEmpty) {

                                } else if (_addressController.text.isEmpty) {
                                  _showDialog('오류', '인증을 완료해주세요.');
                                } else {
                                  _showDialog('오류', '알수없는 오류');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF143386),
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                '다음으로',
                                style: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )))),
    );
  }

  void _register(String id, String password, String email, String address,
      String nickname, String userroll, BuildContext context) async {
    String url = 'http://10.0.2.2:3000/users/signup';


    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'address': address,
      'email': email,
      'id': id,
      'loginType': 'localLogin',
      'nickname': nickname,
      'password': password,
      "userRole": userroll,
      "verifyRole": "VERIFYFALSE",
    };



    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        // 회원가입 성공 시 처리할 로직 추가
        _emailVerify(email);
      } else {
        // 기타 오류
        print('회원가입 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('오류', '회원가입 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }

  void _emailVerify(String email) async {
    String url = 'http://10.0.2.2:3000/users/email';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'email': email,
    };

    try{
      await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body))
          .then((response) => {
        if(response.statusCode == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EmailVerifyPage(email))
          )
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EmailVerifyPage(email))
          ),
          print('이메일 전송 오류 ${response.statusCode}'),
          _showDialog('오류', '이메일 전송중에 오류가 발생했습니다.')
        }
      });
    } catch(e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}