import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey 생성
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
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
          Container(
            width: 100,
            height: 100,
            child: Text(
              '로고영역',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(bottom: 50),
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Color(0xFF4876F2),
            ),
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
    );
  }
}