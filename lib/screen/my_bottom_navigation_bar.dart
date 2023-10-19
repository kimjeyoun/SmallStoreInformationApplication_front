import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final Function toggleDrawer;
  MyBottomNavigationBar({Key? key, required this.toggleDrawer}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  bool _showDrawer = false;

  @override
  Widget build(BuildContext) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      fixedColor: Color(0xFF303D68),
      unselectedItemColor: Colors.white,
      backgroundColor: Color(0xFF4876F2),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: '카테고리',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '지도',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: '찜',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '마이페이지',
        ),
      ],
      onTap: (index) {
        setState(() {
          if (index == 0) {
            widget.toggleDrawer();
          } else {
            _selectedIndex = index;
          }
        });
      },
    );
  }
}