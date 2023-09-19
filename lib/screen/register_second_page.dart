import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where_shop_project/screen/email_verify.dart';

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
  FocusNode _emailFocusNode = FocusNode();
  bool _showLabel_email = true;

  FocusNode _addressFocusNode = FocusNode();
  bool _showLabel_address = true;

  FocusNode _nicknameFocusNode = FocusNode();
  bool _showLabel_nickname = true;

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        _showLabel_email =
        !_emailFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _addressFocusNode.addListener(() {
      setState(() {
        _showLabel_address = !_addressFocusNode.hasFocus;
      });
    });
    _nicknameFocusNode.addListener(() {
      setState(() {
        _showLabel_nickname = !_nicknameFocusNode.hasFocus;
      });
    });
  }

  // 함수

  @override
  void dispose() {
    super.dispose();
  }

  // 컨트롤러
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();

  String _selectedDomain = '직접입력'; // 초기 선택 도메인

  List<String> _domainOptions = [
    '직접입력',
    '@naver.com',
    '@gmail.com',
    '@yahoo.com',
    // 다른 도메인 옵션들...
  ];

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
                      Padding(
                        padding: EdgeInsets.all(70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 70),
                            Text(
                              '추가 정보를 입력해주세요',
                              style: TextStyle(
                                fontFamily: 'Sandoll',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),

                            SizedBox(height: 50),

                            // email TextField
                            Row(
                              children: [
                                Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        SizedBox(height: 20),
                                        Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            TextField(
                                              focusNode: _emailFocusNode,
                                              controller: _emailController,
                                              onTap: () {
                                                setState(() {
                                                  _showLabel_email = false;
                                                });
                                              },
                                              style: TextStyle(fontSize: 13),
                                              decoration: InputDecoration(
                                                labelText:
                                                _showLabel_email ? '이메일' : null,
                                                labelStyle: TextStyle(
                                                  fontFamily: 'Sandoll',
                                                  fontSize: 13,
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                contentPadding: EdgeInsets.all(
                                                    0),
                                                isDense: true,
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 130,
                                              height: 30,
                                              padding: EdgeInsets.only(
                                                  left: 10.0),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF284FB8),
                                              ),
                                              child: DropdownButton<String>(
                                                value: _selectedDomain,
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    setState(() {
                                                      _selectedDomain =
                                                          newValue;
                                                    });
                                                  }
                                                },
                                                items: _domainOptions
                                                    .map<
                                                    DropdownMenuItem<String>>(
                                                      (String domain) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: domain,
                                                      child: Container(
                                                        child: Text(
                                                          domain,
                                                          style: TextStyle(
                                                            fontFamily: 'Sandoll',
                                                            fontSize: 13,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                0.5),
                                                            fontWeight: FontWeight
                                                                .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                                underline: SizedBox.shrink(),
                                                icon: const Icon(
                                                    Icons.arrow_drop_down
                                                ),
                                                iconSize: 26,
                                                iconDisabledColor: Color(
                                                    0xFFD4DBEE),
                                                iconEnabledColor: Color(
                                                    0xFFD4DBEE),
                                                dropdownColor: Color(
                                                    0xFF284FB8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),

                            SizedBox(height: 40),
                            // address TextField
                            TextField(
                              focusNode: _addressFocusNode,
                              controller: _addressController,
                              onTap: () {
                                setState(() {
                                  _showLabel_address = false;
                                });
                              },
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_address ? '주소' : null,
                                labelStyle: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            // nickname TextField
                            TextField(
                              focusNode: _nicknameFocusNode,
                              controller: _nicknameController,
                              onTap: () {
                                setState(() {
                                  _showLabel_nickname = false;
                                });
                              },
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_nickname ? '닉네임' : null,
                                labelStyle: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.8,
                        padding: EdgeInsets.only(bottom: 0),
                        child: ElevatedButton(
                          onPressed: () {
                            String email = _emailController.text +
                                _selectedDomain;
                            String address = _addressController.text;
                            String nickname = _nicknameController.text;

                            if (!_emailController.text.isEmpty
                                && !_addressController.text.isEmpty
                                && !_nicknameController.text.isEmpty) {
                              _register(
                                  widget.id,
                                  widget.password,
                                  email,
                                  address,
                                  nickname,
                                  widget.userroll,
                                  context
                              );
                            } else if (_emailController.text.isEmpty) {
                              _showDialog('오류', '이메일을 입력해주세요.');
                            } else if (_addressController.text.isEmpty) {
                              _showDialog('오류', '주소를 입력해주세요.');
                            } else if (_nicknameController.text.isEmpty) {
                              _showDialog('오류', '닉네임을 입력해주세요.');
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
                            '이메일 인증하기',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )))),
    );
  }

  void _register(String id, String password, String email, String address,
      String nickname, String userroll, BuildContext context) async {
    String sugnupUrl = 'http://10.0.2.2:3000/users/signup';
    String emailUrl = 'http://10.0.2.2:3000/users/email';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> signupBody = {
      'address': address,
      'email': email,
      // "emailConfirmed": true,
      'id': id,
      'loginType': 'local',
      'nickname': nickname,
      'password': password,
      "userRole": userroll,
      "verifyRole": "VERIFYFALSE",
    };

    Map<String, String> emailBody = {
      'email': email,
    };

    try {
      http.Response signupResponse = await http.post(Uri.parse(sugnupUrl),
          headers: headers, body: json.encode(signupBody));
      http.Response emailResponse = await http.post(Uri.parse(emailUrl),
          headers: headers, body: json.encode(emailBody));

      if (signupResponse.statusCode == 200 && emailResponse.statusCode == 200) {
        // 회원가입 성공 시 처리할 로직 추가
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EmailVerifyPage(email)
            )
        );
      } else {
        // 기타 오류
        print('회원가입 오류 ${signupResponse.statusCode}');
        print('이메일 전송 오류 ${emailResponse.statusCode}');
        _showDialog('오류', '회원가입 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}
