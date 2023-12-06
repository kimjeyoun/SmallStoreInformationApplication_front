import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where_shop_project/screen/additional_business_info_page.dart';

class BusinessRegistrationNumVerifyPage extends StatefulWidget {
  final String id;
  final String userroll;

  const BusinessRegistrationNumVerifyPage(this.id, this.userroll);

  @override
  _BusinessRegistrationNumVerifyPageState createState() => _BusinessRegistrationNumVerifyPageState();
}

class _BusinessRegistrationNumVerifyPageState extends State<BusinessRegistrationNumVerifyPage> {
  // FocusNode 변수
  FocusNode _businessNumFocusNode = FocusNode();
  bool _showLabel_businessNum = true;

  FocusNode _businessNameFocusNode = FocusNode();
  bool _showLabel_businessName = true;

  FocusNode _businessLocationFocusNode = FocusNode();
  bool _showLabel_businessLocation = true;

  FocusNode _businessPhoneNumFocusNode = FocusNode();
  bool _showLabel_businessPhoneNum = true;

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
    _businessNumFocusNode.addListener(() {
      setState(() {
        _showLabel_businessNum =
        !_businessNumFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _businessNameFocusNode.addListener(() {
      setState(() {
        _showLabel_businessName =
        !_businessNameFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _businessLocationFocusNode.addListener(() {
      setState(() {
        _showLabel_businessLocation =
        !_businessLocationFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _businessPhoneNumFocusNode.addListener(() {
      setState(() {
        _showLabel_businessPhoneNum =
        !_businessPhoneNumFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
  }

  // 함수

  @override
  void dispose() {
    super.dispose();
  }

  // 컨트롤러
  TextEditingController _businessNumController = TextEditingController();
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _businessLocationController = TextEditingController();
  TextEditingController _businessPhoneNumController = TextEditingController();

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
                            vertical: 60,
                            horizontal: 40
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '사업자 인증을 완료해주세요',
                              style: TextStyle(
                                fontFamily: 'Sandoll',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),

                            SizedBox(height: 45),

                            // businessNum TextField
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // email TextField
                                Container(
                                  width: 210,
                                  child: TextField(
                                    focusNode: _businessNumFocusNode,
                                    controller: _businessNumController,
                                    onTap: () {
                                      setState(() {
                                        _showLabel_businessNum = false;
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      labelText:
                                      _showLabel_businessNum ? '사업자 번호' : null,
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
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    String businessNum = _businessNumController.text;

                                    if (!_businessNumController.text.isEmpty) {
                                      _businessNumVerify(businessNum);
                                    } else if (_businessNumController.text.isEmpty) {
                                      _showDialog('오류', '사업자번호을 입력해주세요.');
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

                            // businessName TextField
                            TextField(
                              focusNode: _businessNameFocusNode,
                              controller: _businessNameController,
                              onTap: () {
                                setState(() {
                                  _showLabel_businessName = false;
                                });
                              },
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_businessName ? '가게 이름' : null,
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

                            SizedBox(height: 25),

                            // business Location TextField
                            TextField(
                              focusNode: _businessLocationFocusNode,
                              controller: _businessLocationController,
                              onTap: () {
                                setState(() {
                                  _showLabel_businessLocation = false;
                                });
                              },
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_businessLocation ? '가게 위치' : null,
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

                            SizedBox(height: 25),

                            // business PhoneNum TextField
                            TextField(
                              focusNode: _businessPhoneNumFocusNode,
                              controller: _businessPhoneNumController,
                              onTap: () {
                                setState(() {
                                  _showLabel_businessPhoneNum = false;
                                });
                              },
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                labelText:
                                _showLabel_businessPhoneNum ? '가게 전화번호' : null,
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

                            SizedBox(height: 25),

                            // next btn
                            ElevatedButton(
                              onPressed: () {
                                String businessNum = _businessNumController.text;
                                String businessName = _businessNameController.text;
                                String businessLocation = _businessLocationController.text;
                                String businessPhoneNum = _businessPhoneNumController.text;

                                if (!_businessNumController.text.isEmpty &&
                                !_businessNameController.text.isEmpty &&
                                !_businessLocationController.text.isEmpty &&
                                !_businessPhoneNumController.text.isEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdditionalBusinessInfoPage(
                                                  widget.id, businessNum, businessName,
                                                  businessLocation, businessPhoneNum, widget.userroll,
                                              )
                                      )
                                  );
                                } else {
                                  _showDialog('오류', '추가 정보를 입력해주세요.');
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
                  )
              )
          )
      ),
    );
  }
  void _businessNumVerify(String b_no) async {
    String url = 'http://10.0.2.2:3000/shop/shopNumStatus';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'b_no' : b_no,
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        _showDialog('인증 성공', '추가정보를 입력후 다음으로 버튼을 눌러주세요.');
      } else {
        // 기타 오류
        print('사업자 번호 인증 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('오류', '사업자 번호 인증 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}