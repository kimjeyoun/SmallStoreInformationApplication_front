import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterForm extends StatefulWidget {
  final String data;

  const RegisterForm(this.data);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // FocusNode 변수
  FocusNode _emailFocusNode = FocusNode();
  bool _showLabel_email = true;

  FocusNode _passwordFocusNode = FocusNode();
  bool _showLabel_password = true;

  FocusNode _passwordVerificationFocusNode = FocusNode();
  bool _showLabel_password_Verification = true;

  FocusNode _idFocusNode = FocusNode();
  bool _showLabel_id = true;

  FocusNode _addressFocusNode = FocusNode();
  bool _showLabel_address = true;

  FocusNode _nicknameFocusNode = FocusNode();
  bool _showLabel_nickname = true;

  // 변수
  bool passwordsMatch = false;
  String passwordMatchText = '';
  bool _passwordEdited = false;

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
    _passwordFocusNode.addListener(() {
      setState(() {
        _showLabel_password = !_passwordFocusNode.hasFocus;
      });
    });
    _passwordVerificationFocusNode.addListener(() {
      setState(() {
        _showLabel_password_Verification =
            !_passwordVerificationFocusNode.hasFocus;
      });
    });
    _idFocusNode.addListener(() {
      setState(() {
        _showLabel_id = !_idFocusNode.hasFocus;
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

    _passwordController.addListener(checkPasswordMatch);
    _passwordController.addListener(() {
      setState(() {
        _passwordEdited = true;
      });
    });
    _passwordVerificationController.addListener(checkPasswordMatch);
  }

  // 함수
  void checkPasswordMatch() {
    setState(() {
      if(_passwordController.text.isNotEmpty &&
          _passwordVerificationController.text.isNotEmpty) {
        passwordsMatch =
            _passwordController.text == _passwordVerificationController.text;
        passwordMatchText =
        passwordsMatch ? '비밀번호가 일치합니다.' : '비밀번호가 일치하지 않습니다.';
      } else {
        passwordMatchText = '';
      }
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(checkPasswordMatch);
    _passwordVerificationController.removeListener(checkPasswordMatch);
    super.dispose();
  }

  // 컨트롤러
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordVerificationController =
      TextEditingController();
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

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {});
      return false;
    }

    RegExp regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$');

    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  // 위젯 빌드 시작
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (_passwordEdited) {
          _validatePassword(_passwordController.text);
        }
      },
      child: Scaffold(
          backgroundColor: Color(0xFF4876F2),
          body: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(70),
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

                            SizedBox(height: 30),
                            // id TextField
                            TextField(
                              focusNode: _idFocusNode,
                              controller: _idController,
                              onTap: () {
                                setState(() {
                                  _showLabel_id = false;
                                });
                              },
                              style: TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_id ? '아이디' : null,
                                labelStyle: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Color(0xFFA7BAD8).withOpacity(0.5),
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

                            // pw TextFiel
                            TextField(
                              focusNode: _passwordFocusNode,
                              controller: _passwordController,
                              style: TextStyle(fontSize: 13),
                              onTap: () {
                                setState(() {
                                  _showLabel_password = false;
                                });
                              },
                              onChanged: _validatePassword,
                              decoration: InputDecoration(
                                labelText: _showLabel_password ? '비밀번호' : null,
                                labelStyle: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Color(0xFFA7BAD8).withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),

                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              obscureText: true,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '8~12자리 영문과 숫자, 특수문자를 조합하여 입력해 주세요.',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFD1D9CF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            // pw verification TextField
                            TextField(
                              focusNode: _passwordVerificationFocusNode,
                              controller: _passwordVerificationController,
                              onTap: () {
                                setState(() {
                                  _showLabel_password_Verification = false;
                                });
                              },
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText: _showLabel_password_Verification
                                    ? '비밀번호 확인'
                                    : null,
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFA7BAD8),
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              obscureText: true,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  passwordMatchText,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFD1D9CF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            // email TextField
                            Row(
                              children: [
                                Flexible(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          style: TextStyle(fontSize: 18),
                                          decoration: InputDecoration(
                                            labelText:
                                                _showLabel_email ? '이메일' : null,
                                            labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFA7BAD8),
                                              fontWeight: FontWeight.bold,
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
                                        Container(
                                          width: 130,
                                          height: 30,
                                          padding: EdgeInsets.only(left: 10.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF284FB8),
                                          ),
                                          child: DropdownButton<String>(
                                            value: _selectedDomain,
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                setState(() {
                                                  _selectedDomain = newValue;
                                                });
                                              }
                                            },
                                            items: _domainOptions
                                                .map<DropdownMenuItem<String>>(
                                              (String domain) {
                                                return DropdownMenuItem<String>(
                                                  value: domain,
                                                  child: Container(
                                                    child: Text(
                                                      domain,
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                            iconDisabledColor: Color(0xFFD4DBEE),
                                            iconEnabledColor: Color(0xFFD4DBEE),
                                            dropdownColor: Color(0xFF284FB8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),

                            SizedBox(height: 30),
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
                                  fontSize: 16,
                                  color: Color(0xFFA7BAD8),
                                  fontWeight: FontWeight.bold,
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

                            SizedBox(height: 30),
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
                                  fontSize: 16,
                                  color: Color(0xFFA7BAD8),
                                  fontWeight: FontWeight.bold,
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.only(bottom: 0),
                        child: ElevatedButton(
                          onPressed: () {
                            String id = _idController.text;
                            String password = _passwordController.text;
                            String email = _emailController.text + _selectedDomain;
                            String address = _addressController.text;
                            String nickname = _nicknameController.text;
                            _register(
                                id, password, email, address, nickname, context
                            );

                            if(!_idController.text.isEmpty
                                && _validatePassword(_passwordController.text)
                                && passwordsMatch) {
                              Navigator.pushNamed(context, 'nextPage');
                            } else if (!_validatePassword(_passwordController.text)) {
                              _showDialog('오류', '비밀번호 양식에 맞게 입력해주세요.');
                            } else if (!passwordsMatch) {
                              _showDialog('오류', '비밀번호 확인란을 입력해주세요.');
                            } else if (_idController.text.isEmpty) {
                            _showDialog('오류', '아이디 입력란을 입력해주세요.');
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
                      )
                    ],
                  )))),
    );
  }

  void _register(String id, String password, String email, String address,
      String nickname, BuildContext context) async {
    String url = 'http://10.0.2.2:3000/users/signup';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'address' : address,
      'email': email,
      "emailConfirmed": true,
      'id': id,
      'loginType' : 'local',
      'nickname' : nickname,
      'password': password,
      "userRole": widget.data,
      "verifyRole": "VERIFYFALSE",
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 201) {
        // 회원가입 성공
        _showDialog('회원가입 성공', '회원가입이 완료되었습니다. 로그인해주세요.');
        // 회원가입 성공 시 처리할 로직 추가
        Navigator.pushNamed(context, '/login'); // 로그인 페이지로 이동
      }  else {
        // 기타 오류
        _showDialog('오류', '회원가입 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}
