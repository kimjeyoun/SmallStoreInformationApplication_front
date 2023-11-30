import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where_shop_project/screen/business_registration_num_verify_page.dart';
import 'package:where_shop_project/screen/customer_add_indo_page.dart';

class SecondRegisterForm extends StatefulWidget {
  final String id;
  final String password;
  final String userroll;

  const SecondRegisterForm(this.id, this.password, this.userroll);

  @override
  _SecondRegisterFormState createState() => _SecondRegisterFormState();
}

class _SecondRegisterFormState extends State<SecondRegisterForm> {
  // FocusNode 변수
  FocusNode _phoneNumFocusNode = FocusNode();
  bool _showLabel_phoneNum = true;

  FocusNode _verifyNumFocusNode = FocusNode();
  bool _showLabel_verifyNum = true;

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
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

  // 함수

  @override
  void dispose() {
    super.dispose();
  }

  // 컨트롤러
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _verifyNumController = TextEditingController();

  // 함수
  InputDecoration _emailInputDecoration() {
    return InputDecoration(
      labelText: '이메일',
      labelStyle: TextStyle(fontSize: 16, color: Colors.white),
      // contentPadding: EdgeInsets.all(0),
      isDense: true,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
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
                              '전화번호로 본인인증',
                              style: TextStyle(
                                fontFamily: 'Sandoll',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),

                            SizedBox(height: 85),

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
                                    String phoneNum = _phoneNumController.text;

                                    if (!_phoneNumController.text.isEmpty) {
                                      _smsVerify(widget.id, phoneNum, context);
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

                            SizedBox(height: 25),

                            // next btn
                            ElevatedButton(
                              onPressed: () {
                                String phoneNum = _phoneNumController.text;
                                String verifyNum = _verifyNumController.text;
                                String type = 'auth';

                                if (!_phoneNumController.text.isEmpty &&
                                    !_verifyNumController.text.isEmpty) {
                                  _smsRandomCodeVerify(phoneNum, verifyNum, type, widget.id);
                                } else if (_phoneNumController.text.isEmpty) {
                                  _showDialog('오류', '인증을 완료해주세요.');
                                } else if(_verifyNumController.text.isEmpty) {
                                  _showDialog('오류', '인증번호를 입력해주세요.');
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
                                '인증완료',
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
                  )
              )
          )
      ),
    );
  }

  void _smsVerify(String id, String phonenum, BuildContext context) async {
    String url = 'http://10.0.2.2:3000/users/sms/confirmed';


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
        _showDialog('인증코드 발송', '코드 입력후 인증완료 버튼을 눌러주세요.');

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
        _showDialog('인증완료', '추가 정보를 입력해주세요.');
        if(widget.userroll == 'SHOPOWNER') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BusinessRegistrationNumVerifyPage(widget.id)
              )
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CustomerAddInfoPage(id, phoneNum)
              )
          );
        }
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