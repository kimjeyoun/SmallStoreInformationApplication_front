import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where_shop_project/screen/pw_find_second_page.dart';

class PwFindFirstPage extends StatefulWidget {
  @override
  _PwFindFirstPageState createState() => _PwFindFirstPageState();
}

class _PwFindFirstPageState extends State<PwFindFirstPage> {
  // FocusNode 변수
  FocusNode _idFocusNode = FocusNode();
  bool _showLabel_id = true;

  FocusNode _phoneNumFocusNode = FocusNode();
  bool _showLabel_phoneNum = true;

  FocusNode _verifyNumFocusNode = FocusNode();
  bool _showLabel_verifyNum = true;

  // 컨트롤러
  TextEditingController _idController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _verifyNumController = TextEditingController();

  String _selectedDomain = '직접입력'; // 초기 선택 도메인

  List<String> _domainOptions = [
    '직접입력',
    '@naver.com',
    '@gmail.com',
    '@yahoo.com',
    // 다른 도메인 옵션들...
  ];

  @override
  void initState() {
    super.initState();
    _idFocusNode.addListener(() {
      setState(() {
        _showLabel_id = !_idFocusNode.hasFocus;
      });
    });
    _phoneNumFocusNode.addListener(() {
      setState(() {
        _showLabel_phoneNum =
        !_phoneNumFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _verifyNumFocusNode.addListener(() {
      setState(() {
        _showLabel_verifyNum =
        !_verifyNumFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
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

  void pwFind(String email, String id) async {
    String url = 'http://10.0.2.2:3000/users/findPW';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'email': email,
      'id': id,
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        print('비밀번호 찾기 전송 성공');
        Navigator.pushNamed(context, '/pwfindsecond');
      } else {
        print('오류 ${response.statusCode}');
        print('body: $body');
      }
    } catch(e) {
      print("response : ${e}");
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
          print('이메일 인증 성공'),
        } else {
          print('이메일 전송 오류 ${response.statusCode}'),
        }
      });
    } catch(e) {
      print("response : ${e}");
    }
  }


  @override
  void dispose() {
    super.dispose();
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 190,
                      horizontal: 40
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '정보를 입력해주세요',
                        style: TextStyle(
                          fontFamily: 'Sandoll',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),

                      SizedBox(height: 60),

                      // id TextField
                      TextField(
                        focusNode: _idFocusNode,
                        controller: _idController,
                        onTap: () {
                          setState(() {
                            _showLabel_id = false;
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
                            _showLabel_id ? '아이디' : null,
                            labelStyle: TextStyle(
                              fontFamily: 'Sandoll',
                              fontSize: 13,
                              color: Colors.grey.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15
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

                      // phoneNum TextField
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // email TextField
                          Container(
                            width: 210,
                            child: TextField(
                              focusNode: _phoneNumFocusNode,
                              controller: _phoneNumController,
                              onTap: () {
                                setState(() {
                                  _showLabel_phoneNum = false;
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
                                  _showLabel_phoneNum ? '전화번호' : null,
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
                          ),
                          ElevatedButton(
                            onPressed: () {
                              String id = _idController.text;
                              String phoneNum = _phoneNumController.text;

                              if (!_phoneNumController.text.isEmpty) {
                                _smsVerify(id, phoneNum, context);
                              } else if (_phoneNumController.text.isEmpty) {
                                _showDialog('오류', '전화번호을 입력해주세요.');
                              } else {
                                _showDialog('오류', '알수없는 오류');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF143386),
                              minimumSize: Size(70, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              '인증하기',
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

                      SizedBox(height: 25),

                      // verifyNum TextField
                      TextField(
                        focusNode: _verifyNumFocusNode,
                        controller: _verifyNumController,
                        onTap: () {
                          setState(() {
                            _showLabel_verifyNum = false;
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
                            _showLabel_verifyNum ? '인증번호' : null,
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

                      SizedBox(height: 40),

                      // code TextField
                      TextField(
                        focusNode: _verifyNumFocusNode,
                        controller: _verifyNumController,
                        onTap: () {
                          setState(() {
                            _showLabel_verifyNum = false;
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
                            _showLabel_verifyNum ? '코드 6자리' : null,
                            labelStyle: TextStyle(
                              fontFamily: 'Sandoll',
                              fontSize: 13,
                              color: Colors.grey.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15
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
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '이메일로 전송받은 코드를 입력해 주세요.',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFFD1D9CF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          String phone = _phoneNumController.text;
                          String randomCode = _verifyNumController.text;
                          String type = 'findPW';
                          String id = _idController.text;
                          _smsRandomCodeVerify(phone, randomCode, type, id);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF143386),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7), // 원하는 모서리 반지름 값을 설정
                          ),
                        ),
                        child: Text(
                          '다음으로',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  // 랜덤 코드 전송
  void _smsVerify(String id, String phonenum, BuildContext context) async {
    String url = 'http://10.0.2.2:3000/users/sms/findPW';


    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'id': id,
      'phone': phonenum,
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        _showDialog('인증코드 발송', '코드 입력후 다음으로 버튼을 눌러주세요.');
      } else {
        // 기타 오류
        print('sms인증 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('오류', 'sms인증 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }

  // 인증 확인
  void _smsRandomCodeVerify(String phoneNum, String randomCode,
      String type, String id) async {
    String url = 'http://10.0.2.2:3000/users/sms/verify';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'phone': phoneNum,
      'randomcode' : randomCode,
      'type' : type,
      'user_id' : id,
    };


    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PwFindSecondPage(phoneNum)
            )
        );
      } else {
        // 기타 오류
        print('sms인증 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('오류', 'sms인증 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}