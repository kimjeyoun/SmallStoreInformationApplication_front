import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KakaoAdditionalInfomationPage extends StatefulWidget {
  final String id;
  final String password;
  final accessToken;
  final String userroll;

  const KakaoAdditionalInfomationPage(this.id, this.password, this.accessToken, this.userroll);

  @override
  _KakaoAdditionalInfomationPageState createState() => _KakaoAdditionalInfomationPageState();
}

class _KakaoAdditionalInfomationPageState extends State<KakaoAdditionalInfomationPage> {
  // FocusNode 변수
  FocusNode _nicknameFocusNode = FocusNode();
  bool _showLabel_nickname = true;

  FocusNode _addressFocusNode = FocusNode();
  bool _showLabel_address = true;

  FocusNode _detailAddressFocusNode = FocusNode();
  bool _showLabel_detail_address = true;

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
    _nicknameFocusNode.addListener(() {
      setState(() {
        _showLabel_nickname =
        !_nicknameFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _addressFocusNode.addListener(() {
      setState(() {
        _showLabel_address = !_addressFocusNode.hasFocus;
      });
    });
    _detailAddressFocusNode.addListener(() {
      setState(() {
        _showLabel_detail_address = !_detailAddressFocusNode.hasFocus;
      });
    });
  }

  // 함수

  @override
  void dispose() {
    super.dispose();
  }

  // 컨트롤러
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _detailAddressController = TextEditingController();

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
                        padding: EdgeInsets.symmetric(
                            vertical: 180,
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
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_nickname ? '닉네임' : null,
                                labelStyle: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),
                                filled: true,
                                // 배경 색상을 사용하도록 설정
                                fillColor: Colors.white,
                                // 배경 색상 설정
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 13.2,
                                ),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )
                                ),
                              ),
                            ),

                            SizedBox(height: 50),
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
                                  color: Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),
                                filled: true,
                                // 배경 색상을 사용하도록 설정
                                fillColor: Colors.white,
                                // 배경 색상 설정
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 13.2,
                                ),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '현재 운영하시는 가게의 주소를 입력해 주세요.',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFD1D9CF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // nickname TextField
                            TextField(
                              focusNode: _detailAddressFocusNode,
                              controller: _detailAddressController,
                              onTap: () {
                                setState(() {
                                  _showLabel_detail_address = false;
                                });
                              },
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_detail_address ? '상세 주소' : null,
                                labelStyle: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontSize: 13,
                                  color: Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),
                                filled: true,
                                // 배경 색상을 사용하도록 설정
                                fillColor: Colors.white,
                                // 배경 색상 설정
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 13.2,
                                ),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '상세 주소를 입력해주세요. ex)00번길 00빌딩 1층',
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
                                String nickname = _nicknameController.text;
                                String address = _addressController.text + _detailAddressController.text;

                                if (!_nicknameController.text.isEmpty
                                    && !_addressController.text.isEmpty
                                    && !_detailAddressController.text.isEmpty) {
                                  _kakao_register(
                                      widget.id,
                                      widget.password,
                                      nickname,
                                      address,
                                      widget.userroll,
                                      widget.accessToken,
                                  );
                                } else if (_nicknameController.text.isEmpty) {
                                  _showDialog('오류', '닉네임을 입력해주세요.');
                                } else if (_addressController.text.isEmpty) {
                                  _showDialog('오류', '주소를 입력해주세요.');
                                } else
                                if (_detailAddressController.text.isEmpty) {
                                  _showDialog('오류', '상세주소을 입력해주세요.');
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
                                '가입완료',
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

  void _kakao_register(String id, String password,String nickname, String address
      , String userroll, final accessToken) async {
    String url = 'http://10.0.2.2:3000/users/signup';


    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'address': address,
      'id': id,
      'loginType': 'kakaoLogin',
      'nickname': nickname,
      'password': password,
      "userRole": userroll,
      'accessToken': accessToken,
      "verifyRole": "VERIFYFALSE",
    };


    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        // 회원가입 성공 시 처리할 로직 추가
        print('카카오 회원가입 성공: ${response.statusCode}');
        Navigator.pushNamed(context, 'main');
      } else {
        // 기타 오류
        print('넘어온 정보: ${id}, ${password}, ${accessToken}, ${userroll}');
        print('회원가입 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('오류', '회원가입 중에 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}