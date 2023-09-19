import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class EmailVerifyPage extends StatefulWidget {
  final String email;

  const EmailVerifyPage(this.email);

  @override
  _EmailVerifyPageState createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  @override
  void dispose() {
    super.dispose();
  }

  final TextEditingController _pinCodeController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF4876F2),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  "입력해주신 이메일로 코드가 발송되었습니다!",
                  style: TextStyle(
                    fontFamily: "Sandoll",
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "코드를 입력해 회원가입을\n완료해주세요",
                  style: TextStyle(
                    fontFamily: 'Sandoll',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Container(
                  width: 265,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.white,
                              width: 1.5
                          )
                      )
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    controller: _pinCodeController,
                    length: 6,
                    obscureText: true,
                    animationType: AnimationType.fade,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5.0),
                      fieldHeight: 45,
                      fieldWidth: 35,
                      activeFillColor: const Color(0xFFA4BBF8),
                      inactiveFillColor: const Color(0xFFA4BBF8),
                      activeColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      selectedFillColor: Color(0xFFA4BBF8),
                    ),
                    textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(315, 50), // 버튼의 최소 너비를 설정
                    primary: const Color(0xFF143386), // 버튼의 배경색을 회색으로 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    String randomCode = _pinCodeController.text;
                    _emailAuthentication(widget.email, randomCode);
                  },
                  child: const Text(
                    "시작하기",
                    style: TextStyle(
                      fontFamily: 'Sandoll',
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _emailAuthentication(String email, String randomCode) async {
    String url = 'http://10.0.2.2:3000/users/emailVertify';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'email' : email,
      "randomCode" : randomCode,
      "verifyRole": "VERIFYFALSE",
    };

    try{
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if(response.statusCode == 200) {
        print("이메일 인증 성공");
      } else{
        print("email: ${email}");
        print("알수없는 오류: ${response.statusCode}");
      }
    } catch(e) {
      print("트라이문 오류: ${e}");
    }
  }
}
