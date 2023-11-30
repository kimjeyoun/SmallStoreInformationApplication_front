import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PwFindFirstPage extends StatefulWidget {
  @override
  _PwFindFirstPageState createState() => _PwFindFirstPageState();
}

class _PwFindFirstPageState extends State<PwFindFirstPage> {
  // FocusNode 변수
  FocusNode _idFocusNode = FocusNode();
  bool _showLabel_id = true;

  FocusNode _emailFocusNode = FocusNode();
  bool _showLabel_email = true;

  FocusNode _codeFocusNode = FocusNode();
  bool _showLabel_code = true;

  // 컨트롤러
  TextEditingController _idController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

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
    _emailFocusNode.addListener(() {
      setState(() {
        _showLabel_email =
        !_emailFocusNode.hasFocus; // 포커스가 없을 때에만 _showLabel을 true로 설정
      });
    });
    _codeFocusNode.addListener(() {
      setState(() {
        _showLabel_code = !_codeFocusNode.hasFocus;
      });
    });
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

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 12),
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
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        decoration: InputDecoration(
                                          labelText:
                                          _showLabel_email ? '이메일' : null,
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
                                      ),
                                      Positioned(
                                        right: 10,
                                        child: Container(
                                          width: 106,
                                          height: 23,
                                          padding: EdgeInsets.only(left: 5.0),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.6),
                                              borderRadius: BorderRadius.circular(2.0)
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
                                            items: _domainOptions.map<DropdownMenuItem<String>>(
                                                  (String domain) {
                                                return DropdownMenuItem<String>(
                                                  value: domain,
                                                  child: Text(
                                                    domain,
                                                    style: TextStyle(
                                                      fontFamily: 'Sandoll',
                                                      fontSize: 13,
                                                      color: Colors.black.withOpacity(0.3),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            underline: SizedBox.shrink(),
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              size: 24,
                                              color: Colors.white,
                                            ), // 아이콘을 사용하지 않음
                                            iconDisabledColor: Color(
                                                0xFFD4DBEE),
                                            iconEnabledColor: Color(
                                                0xFFD4DBEE),
                                            dropdownColor: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              String email = _emailController.text;
                              _emailVerify(email);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF143386),
                              minimumSize: Size(50, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0), // 원하는 모서리 반지름 값을 설정
                              ),
                            ),
                            child: Text(
                              '인증',
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

                      SizedBox(height: 40),

                      // code TextField
                      TextField(
                        focusNode: _codeFocusNode,
                        controller: _codeController,
                        onTap: () {
                          setState(() {
                            _showLabel_code = false;
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
                            _showLabel_code ? '코드 6자리' : null,
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
                          String email = _emailController.text;
                          String id = _idController.text;
                          pwFind(email, id);
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
}