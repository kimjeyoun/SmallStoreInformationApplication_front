import 'package:flutter/material.dart';
import 'package:where_shop_project/screen/register_second_page.dart';

class FirstRegisterForm extends StatefulWidget {
  final String userroll;

  const FirstRegisterForm(this.userroll);

  @override
  _FirstegisterFormState createState() => _FirstegisterFormState();
}

class _FirstegisterFormState extends State<FirstRegisterForm> {
  // FocusNode 변수
  FocusNode _idFocusNode = FocusNode();
  bool _showLabel_id = true;

  FocusNode _passwordFocusNode = FocusNode();
  bool _showLabel_password = true;

  FocusNode _passwordVerificationFocusNode = FocusNode();
  bool _showLabel_password_Verification = true;


  // 변수
  bool passwordsMatch = false;
  String passwordMatchText = '';
  bool _passwordEdited = false;

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
    _idFocusNode.addListener(() {
      setState(() {
        _showLabel_id = !_idFocusNode.hasFocus;
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

    RegExp regex = RegExp(
        r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$');

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
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '6~12자리 영문과 숫자를 조합하여 입력해 주세요.',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFD1D9CF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 28),

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
                                  vertical: 13.2,
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
                                  '8~12자리 영문과 숫자, 특수문자를 조합하여 입력해 주세요.',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFD1D9CF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

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
                                  vertical: 13.2,
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
                                String id = _idController.text;
                                String password = _passwordController.text;

                                if (!_idController.text.isEmpty
                                    && _validatePassword(_passwordController.text)
                                    && passwordsMatch) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SecondRegisterForm(id, password, widget.userroll)
                                      )
                                  );
                                } else if (_idController.text.isEmpty) {
                                  _showDialog('오류', '아이디 입력란을 입력해주세요.');
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
}
