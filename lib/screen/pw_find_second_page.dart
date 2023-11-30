import 'package:flutter/material.dart';

class PwFindSecondPage extends StatefulWidget {
  @override
  _PwFindSecondPageState createState() => _PwFindSecondPageState();
}

class _PwFindSecondPageState extends State<PwFindSecondPage> {
  // FocusNode 변수
  FocusNode _passwordFocusNode = FocusNode();
  bool _showLabel_password = true;

  FocusNode _passwordVerificationFocusNode = FocusNode();
  bool _showLabel_password_Verification = true;

  // 컨트롤러
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordVerificationController =
  TextEditingController();

  // 변수
  bool passwordsMatch = false;
  String passwordMatchText = '';
  bool _passwordEdited = false;

  // 함수
  void checkPasswordMatch() {
    setState(() {
      if (_passwordController.text.isNotEmpty &&
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

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
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

    _passwordController.addListener(checkPasswordMatch);
    _passwordController.addListener(() {
      setState(() {
        _passwordEdited = true;
      });
    });
    _passwordVerificationController.addListener(checkPasswordMatch);
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {});
      return false;
    }

    RegExp regex = RegExp(
        r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$');

    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _passwordController.removeListener(checkPasswordMatch);
    _passwordVerificationController.removeListener(checkPasswordMatch);
    super.dispose();
  }

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
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 250,
                    horizontal: 40
                  ),
                  child: Column(
                    children: [
                      Text(
                        '비밀번호를 다시 설정해 주세요',
                        style: TextStyle(
                          fontFamily: 'Sandoll',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),

                      SizedBox(height: 40),

                      // pw TextFiel
                      TextField(
                        focusNode: _passwordFocusNode,
                        controller: _passwordController,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        onTap: () {
                          setState(() {
                            _showLabel_password = false;
                          });
                        },
                        showCursor: false, // 커서 숨기기
                        onChanged: _validatePassword,
                        decoration: InputDecoration(
                          labelText: _showLabel_password ? '비밀번호' : null,
                          labelStyle: TextStyle(
                            fontFamily: 'Sandoll',
                            fontSize: 13,
                            color: Colors.grey.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true, // 배경 색상을 사용하도록 설정
                          fillColor: Colors.white, // 배경 색상 설정
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
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
                          ),
                        ),
                        obscureText: true,
                      ),

                      SizedBox(height: 12),

                      // pw verification TextField
                      TextField(
                        focusNode: _passwordVerificationFocusNode,
                        controller: _passwordVerificationController,
                        onTap: () {
                          setState(() {
                            _showLabel_password_Verification = false;
                          });
                        },
                        showCursor: false, // 커서 숨기기
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                          labelText: _showLabel_password_Verification
                              ? '비밀번호 확인'
                              : null,
                          labelStyle: TextStyle(
                            fontFamily: 'Sandoll',
                            fontSize: 13,
                            color: Colors.grey.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true, // 배경 색상을 사용하도록 설정
                          fillColor: Colors.white, // 배경 색상 설정
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
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

                      SizedBox(height: 23),

                      ElevatedButton(
                        onPressed: () {
                          String password = _passwordController.text;

                          if (_validatePassword(_passwordController.text)
                              && passwordsMatch) {
                            // 비밀번호 일치시 넘길 동작
                          } else if (!_validatePassword(_passwordController.text)) {
                            _showDialog('오류', '비밀번호 양식에 맞게 입력해주세요.');
                          } else if (!passwordsMatch) {
                            _showDialog('오류', '비밀번호 확인란을 입력해주세요.');
                          } else {
                            _showDialog('오류', '알수없는 오류');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF143386),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}