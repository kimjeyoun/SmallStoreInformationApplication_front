import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where_shop_project/screen/business_registration_num_verify_page.dart';
import 'package:where_shop_project/screen/login_page.dart';

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

  FocusNode _nicknameFocusNode = FocusNode();
  bool _showLabel_nickname = true;

  String selectedAddress = '';
  List<String> address = ['선택해주세요', '경기도 안양시', '경기도 군포시', '경기도 의왕시'];
  String loginType = 'localLogin';

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
    _nicknameFocusNode.addListener(() {
      setState(() {
        _showLabel_nickname =
        !_nicknameFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    setState(() {
      selectedAddress = address[0];
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
  TextEditingController _nicknameController = TextEditingController();

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
                            vertical: 50,
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

                            SizedBox(height: 50),

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

                            // address TextField
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '주소 선택',
                                  style: TextStyle(
                                      fontFamily: 'Sandoll',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15
                                  ),
                                ),
                                Container(
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.white24
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton(
                                    value: selectedAddress,
                                    style: TextStyle(
                                        fontFamily: 'Sandoll',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    dropdownColor: Colors.white,
                                    items: address
                                        .map((e) => DropdownMenuItem(
                                      value: e, // 선택 시 onChanged 를 통해 반환할 value
                                      child: Text(e),
                                    ))
                                        .toList(),
                                    onChanged: (value) { // items 의 DropdownMenuItem 의 value 반환
                                      setState(() {
                                        selectedAddress = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 25),

                            // next btn
                            ElevatedButton(
                              onPressed: () {
                                String phoneNum = _phoneNumController.text;
                                String verifyNum = _verifyNumController.text;
                                String type = 'auth';

                                if (!_phoneNumController.text.isEmpty &&
                                    !_verifyNumController.text.isEmpty &&
                                    !_nicknameController.text.isEmpty &&
                                    selectedAddress != '선택해주세요') {
                                  _smsRandomCodeVerify(phoneNum, verifyNum, type, widget.id);
                                } else if (_phoneNumController.text.isEmpty) {
                                  _showDialog('오류', '인증을 완료해주세요.');
                                } else if(_verifyNumController.text.isEmpty) {
                                  _showDialog('오류', '인증번호를 입력해주세요.');
                                } else if(_nicknameController.text.isEmpty) {
                                  _showDialog('오류', '닉네임를 입력해주세요.');
                                } else if(selectedAddress == '선택해주세요') {
                                  _showDialog('오류', '주소를 선택해주세요.');
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

  // 랜덤 코드 전송
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

  // 인증 확인
  void _smsRandomCodeVerify(String phoneNum, String randomCode,
      String type, String id) async {
    String url = 'http://10.0.2.2:3000/users/sms/verify';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'phone': phoneNum,
      'randomCode' : randomCode,
      'type' : type,
      'user_id' : id,
    };


    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        if(selectedAddress != '선택해주세요') {
          _userSignup(selectedAddress, id, loginType, _nicknameController.text,
              widget.password, phoneNum, widget.userroll);
        } else {
          _showDialog('오류', '주소를 선택해주세요');
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

  // 회원가입
  void _userSignup(String address, String id, String loginType, String nickname,
      String password, String phone, String userRole) async {
    String url = 'http://10.0.2.2:3000/users/signup';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'address': address,
      'id' : id,
      'loginType' : loginType,
      'nickname' : nickname,
      'password' : password,
      'phone' : phone,
      'userRole' : userRole,
    };


    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        _showDialog('회원가입 완료', '추가 정보를 입력해주세요.');
        if(widget.userroll == 'SHOPOWNER') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BusinessRegistrationNumVerifyPage(id, widget.userroll)
              )
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage('', widget.userroll)
              )
          );
        }
      } else {
        // 기타 오류
        print('회원가입 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('회원가입 오류', '프론트 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}