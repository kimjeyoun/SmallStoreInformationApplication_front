import 'package:flutter/material.dart';
import 'package:where_shop_project/screen/my_bottom_navigation_bar.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
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
                    SizedBox(height: 60),
                    Text(
                      '로고 영역',
                      style: TextStyle(
                        fontFamily: 'Sandoll',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white, // 로고 영역 텍스트 색상 변경
                      ),
                    ),
                    SizedBox(height: 80),
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
                      child: Text(
                        '주부 99단',
                        style: TextStyle(
                          fontFamily: 'Sandoll',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Color(0xFF4876F2),
                        ),
                      ),
                    )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽으로 정렬
                    children: [
                      TextButton(
                        onPressed: () {},
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
                        onPressed: () {},
                        child: Text(
                          '닉네임 변경',
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
        // bottomNavigationBar: MyBottomNavigationBar()
      ),
    );
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



