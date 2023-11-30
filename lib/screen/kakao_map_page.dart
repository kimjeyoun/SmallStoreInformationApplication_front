import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KakaoMapPage extends StatefulWidget {
  const KakaoMapPage({Key? key, this.title}) : super(key: key);
  
  final String? title;
  
  @override
  _KakaoMapPageState createState() => _KakaoMapPageState();
}

class _KakaoMapPageState extends State<KakaoMapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey 생성
  late KakaoMapController mapController;
  Set<Marker> markers = {}; // 마커 변수
  String message = '';

  int _currentIndex = 1;

  final SearchController _searchController = SearchController();
  bool _showClearButton = false;

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200, // 높이를 250으로 설정
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff4876F2), // 보더의 색상 설정
                    width: 2.8, // 보더의 두께 설정
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  // 로고 영역
                  Image.asset(
                    'asset/img/wordmark_main.png',
                    width: 100, // 이미지의 너비
                    height: 30, // 이미지의 높이
                  ),
                  SizedBox(height: 20),
                  // 검색바
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 60
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 검색 입력 필드
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 30,
                            margin: EdgeInsets.only(top: 5.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFEAEFFB),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _showClearButton = value.isNotEmpty;
                                });
                              },
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                color: Color(0xFF98A8D2),
                              ),
                              decoration: InputDecoration(
                                hintText: "우리동네 알뜰샵을 검색해보세요",
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 10, top: 6),
                                suffixIcon: _showClearButton
                                    ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _showClearButton = false;
                                    });
                                  },
                                  color: Color(0xff4876F2),
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                )
                                    : IconButton(
                                  onPressed: () {
                                    print("검색: ${_searchController.text}");
                                  },
                                  color: Color(0xff4876F2),
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.search,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: KakaoMap(
                onMapCreated: ((controller) async {
                  mapController = controller;

                  markers.add(Marker(
                    markerId: UniqueKey().toString(),
                    latLng: await mapController.getCenter(),
                  ));

                  setState(() {});
                }),
                currentLevel: 8,
                onZoomChangeCallback: ((zoomLevel, zoomType) {
                  message = '현재 지도 레벨은 $zoomLevel 입니다';

                  setState(() {});
                }),
                markers: markers.toList(),
                center: LatLng(37.3608681, 126.9306506),
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