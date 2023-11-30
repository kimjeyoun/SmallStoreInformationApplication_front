import 'package:flutter/material.dart';

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

