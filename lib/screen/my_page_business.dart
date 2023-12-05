import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyPageBusiness extends StatefulWidget {
  @override
  _MyPageBusinessState createState() => _MyPageBusinessState();
}

class _MyPageBusinessState extends State<MyPageBusiness> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey 생성
  int _currentIndex = 4;

  bool isEditing = false;
  TextEditingController nicknameController = TextEditingController();
  String nickname = '주부 99단';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      height: 420,
                      color: Color(0xFF4876F2),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 80),
                      Image.asset(
                        'asset/img/wordmark_white.png',
                        width: 120, // 이미지의 너비
                        height: 30, // 이미지의 높이
                      ),
                      SizedBox(height: 60),
                      // 프로필 이미지 원을 중앙에 정렬
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          // backgroundImage: AssetImage('asset/img/logo.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.5,
                              )
                          )
                      ),
                      child: Center(
                        child: isEditing
                            ? TextField(
                          controller: nicknameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                          ),
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Color(0xFF4876F2),
                          ),
                        )
                            : Text(
                          nickname,
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Color(0xFF4876F2),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽으로 정렬
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '프로필 사진 변경',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xFF4876F2),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              // 닉네임 변경 버튼을 눌렀을 때 편집 모드 변경
                              isEditing = !isEditing;
                              if (isEditing) {
                                // 닉네임 편집 모드로 전환될 때 기존 닉네임을 컨트롤러에 설정
                                nickname = nicknameController.text;
                              } else {
                                if(!nicknameController.text.isEmpty) {
                                  setState(() {
                                    nickname = nicknameController.text;
                                  });
                                  _userInfoChange(nickname);
                                }
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            isEditing ? '저장' : '닉네임 변경',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xFF4876F2),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/storedetale');
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '가게 정보',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xFF4876F2),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '환경설정',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xFF4876F2),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '고객센터',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xFF4876F2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          fixedColor: Color(0xFF303D68),
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF4876F2),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                  _scaffoldKey.currentState!.openDrawer(); // Drawer 열기
                },
              ),
              label: '카테고리',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.map),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  Navigator.pushNamed(context, '/map');
                },
              ),
              label: '지도',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                  Navigator.pushNamed(context, '/main');
                },
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
              label: '찜',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                  Navigator.pushNamed(context, '/mypage');
                },
              ),
              label: '마이페이지',
            ),
          ],
        ),
      ),
    );
  }
  // 유저 정보 수정
  void _userInfoChange(String nickname) async {
    String url = 'http://10.0.2.2:3000/users/mypage';


    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'nickname': nickname,
    };

    try {
      http.Response response = await http.put(Uri.parse(url),
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
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 40)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 70,
        0,
        size.height - 40,
      )
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'asset/img/wordmark_main.png',
            width: 100,
          ),
          Container(
            width: 160,
            height: 30,
            margin: EdgeInsets.only(bottom: 70),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.3,
                        color: Colors.grey.withOpacity(0.7)
                    )
                )
            ),
          ),
          Container(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽으로 정렬
              children: [
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.fastfood,
                          color: Color(0xff4876F2),
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '음식점',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Color(0xFF4876F2),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.handyman,
                          color: Color(0xff4876F2),
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '잡화점',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Color(0xFF4876F2),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Color(0xff4876F2),
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '상점',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Color(0xFF4876F2),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.content_cut,
                          color: Color(0xff4876F2),
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '뷰티',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Color(0xFF4876F2),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Color(0xff4876F2),
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '푸드트럭',
                          style: TextStyle(
                            fontFamily: 'Sandoll',
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Color(0xFF4876F2),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  width: 160,
                  height: 30,
                  margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.3,
                              color: Colors.grey.withOpacity(0.7)
                          )
                      )
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '고객센터',
                              style: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.grey.withOpacity(0.7)
                              ),
                            ),
                            SizedBox(width: 67),
                            Icon(
                              Icons.call,
                              color: Colors.grey.withOpacity(0.7),
                              size: 17,
                            )
                          ],
                        )
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '로그아웃',
                              style: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.grey.withOpacity(0.7)
                              ),
                            ),
                            SizedBox(width: 67),
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.grey.withOpacity(0.7),
                              size: 17,
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}