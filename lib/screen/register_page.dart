import 'package:flutter/material.dart';
import 'package:where_shop_project/screen/register_second_page.dart';

<<<<<<< HEAD
<<<<<<< HEAD:lib/screen/register_first_page.dart
class FirstRegisterForm extends StatefulWidget {
  final String data;

  const FirstRegisterForm(this.data);

=======
class RegisterPage extends StatelessWidget {
=======
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료):lib/screen/register_page.dart
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
<<<<<<< HEAD:lib/screen/register_first_page.dart
  TextEditingController();
=======
      TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();

  String _selectedDomain = '직접입력'; // 초기 선택 도메인
  String? _passwordErrorText;

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
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료):lib/screen/register_page.dart

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

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorText = null;
      });
      return;
    }

    RegExp regex = RegExp(
        r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$');

    if (!regex.hasMatch(value)) {
      setState(() {
        _passwordErrorText = '8~12자리 영문과 숫자, 특수문자를 조합하여 입력해 주세요.';
      });
    } else {
      setState(() {
        _passwordErrorText = null;
      });
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
                      Padding(
                        padding: EdgeInsets.all(70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 70),
                            Text(
                              '정보를 입력해주세요',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
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
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_id ? '아이디' : null,
                                labelStyle: TextStyle(
<<<<<<< HEAD
<<<<<<< HEAD:lib/screen/register_first_page.dart
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
=======
                                  fontSize: 16,
                                  color: Color(0xFFA7BAD8),
                                  fontWeight: FontWeight.bold,
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료):lib/screen/register_page.dart
=======
                                  fontSize: 16,
                                  color: Color(0xFFA7BAD8),
                                  fontWeight: FontWeight.bold,
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료)
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
                              onChanged: _validatePassword,
                              style: TextStyle(fontSize: 18),
                              onTap: () {
                                setState(() {
                                  _showLabel_password = false;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: _showLabel_password ? '비밀번호' : null,
                                labelStyle: TextStyle(
<<<<<<< HEAD
<<<<<<< HEAD:lib/screen/register_first_page.dart
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
=======
                                  fontSize: 16,
                                  color: Color(0xFFA7BAD8),
                                  fontWeight: FontWeight.bold,
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료):lib/screen/register_page.dart
=======
                                  fontSize: 16,
                                  color: Color(0xFFA7BAD8),
                                  fontWeight: FontWeight.bold,
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료)
                                ),
                                errorText: _passwordErrorText,
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
                                    fontSize: 10,
                                    color: Color(0xFFA7BAD8),
                                    fontWeight: FontWeight.bold,
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
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.5),
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
                                  passwordMatchText,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: passwordsMatch
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                            String id = _idController.text;
                            String password = _passwordController.text;
<<<<<<< HEAD:lib/screen/register_first_page.dart

                            if (!_idController.text.isEmpty
                                && _validatePassword(_passwordController.text)
                                && passwordsMatch) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SecondRegisterForm(id, password, widget.data)
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
=======
                            String email = _emailController.text + _selectedDomain;
                            String address = _addressController.text;
                            String nickname = _nicknameController.text;
                            _register(
                                id, password, email, address, nickname, context
                            );
<<<<<<< HEAD
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료):lib/screen/register_page.dart
=======
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료)
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF143386),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('시작하기'),
                        ),
                      )
                    ],
                  )))),
    );
  }
<<<<<<< HEAD:lib/screen/register_first_page.dart
=======

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
      "userRole": "ADMIN",
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
      } else if (response.statusCode == 401) {
        // 아이디 중복
        _showDialog('회원가입 실패', '이미 사용 중인 아이디입니다.');
      } else {
        // 기타 오류
        _showDialog('오류', '회원가입 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
>>>>>>> parent of 922bf2f (Feat: 회원가입 페이지 분할, 이메일 인증 페이지 구현 완료):lib/screen/register_page.dart
}
