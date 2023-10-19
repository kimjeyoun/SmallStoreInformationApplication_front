import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Drawer(
        // Drawer 내용
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('사용자 이름'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text('프로필 설정'),
              onTap: () {
                // 프로필 설정 페이지로 이동
                Navigator.pop(context); // Drawer 닫기
                // TODO: 프로필 설정 페이지로 이동하는 코드 추가
              },
            ),
            ListTile(
              title: Text('위치 설정'),
              onTap: () {
                // 위치 설정 페이지로 이동
                Navigator.pop(context); // Drawer 닫기
                // TODO: 위치 설정 페이지로 이동하는 코드 추가
              },
            ),
            ListTile(
              title: Text('프로필 변경'),
              onTap: () {
                // 프로필 변경 페이지로 이동
                Navigator.pop(context); // Drawer 닫기
                // TODO: 프로필 변경 페이지로 이동하는 코드 추가
              },
            ),
          ],
        ),
      ),
    );
  }
}

