import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_shop_project/screen/my_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final SearchController _searchController = SearchController();
  bool _showClearButton = false;
  int _selectedIndex = 0;

  PageController _eventViewController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF4876F2),
    ));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      color: Color(0xff4876F2),
                      size: 15,
                    ),
                    label: Text(
                      '현위치 ⌵',
                      style: TextStyle(
                        fontFamily: 'Sandoll',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xff4876F2),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
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
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    color: Color(0xff4876F2),
                    icon: const Icon(
                      Icons.notifications_none
                    ),
                  )
                ],
              ),
              bottom: PreferredSize(
                child: Row(
                  children: [
                    // 네비게이션 바
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF728FE0),
                                width: 2.0,
                              ),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 37,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selectedIndex == 0
                                        ? Color(0xFF325CD0) // 선택된 탭의 밑줄 색상
                                        : Colors.transparent, // 선택되지 않은 탭의 밑줄 색상
                                    width: 2.5, // 선택된 탭의 밑줄 두께
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 0;
                                  });
                                },
                                child: Text(
                                  '홈',
                                  style: TextStyle(
                                    fontWeight: _selectedIndex == 0
                                        ? FontWeight.bold // 선택된 탭 글자 두껍게
                                        : FontWeight.w600,
                                    color: _selectedIndex == 0
                                        ? Color(0xFF4876F2) // 선택된 탭 글자 색상
                                        : Color(0xFF4876F2).withOpacity(0.5), // 선택되지 않은 탭 글자 색상
                                    fontFamily: 'Sandoll',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 37,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selectedIndex == 1
                                        ? Color(0xFF325CD0) // 선택된 탭의 밑줄 색상
                                        : Colors.transparent, // 선택되지 않은 탭의 밑줄 색상
                                    width: 2.5, // 선택된 탭의 밑줄 두께
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 1;
                                  });
                                },
                                child: Text(
                                  '알뜰샵',
                                  style: TextStyle(
                                    fontWeight: _selectedIndex == 1
                                        ? FontWeight.bold // 선택된 탭 글자 두껍게
                                        : FontWeight.w600,
                                    color: _selectedIndex == 1
                                        ? Color(0xFF4876F2) // 선택된 탭 글자 색상
                                        : Color(0xFF4876F2).withOpacity(0.5), // 선택되지 않은 탭 글자 색상
                                    fontFamily: 'Sandoll',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 37,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selectedIndex == 2
                                        ? Color(0xFF325CD0) // 선택된 탭의 밑줄 색상
                                        : Colors.transparent, // 선택되지 않은 탭의 밑줄 색상
                                    width: 2.5, // 선택된 탭의 밑줄 두께
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 2;
                                  });
                                },
                                child: Text(
                                  '베스트',
                                  style: TextStyle(
                                    fontWeight: _selectedIndex == 2
                                        ? FontWeight.bold // 선택된 탭 글자 두껍게
                                        : FontWeight.w600,
                                    color: _selectedIndex == 2
                                        ? Color(0xFF4876F2) // 선택된 탭 글자 색상
                                        : Color(0xFF4876F2).withOpacity(0.5), // 선택되지 않은 탭 글자 색상
                                    fontFamily: 'Sandoll',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 37,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selectedIndex == 3
                                        ? Color(0xFF325CD0) // 선택된 탭의 밑줄 색상
                                        : Colors.transparent, // 선택되지 않은 탭의 밑줄 색상
                                    width: 2.5, // 선택된 탭의 밑줄 두께
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 3;
                                  });
                                },
                                child: Text(
                                  '이벤트',
                                  style: TextStyle(
                                    fontWeight: _selectedIndex == 3
                                        ? FontWeight.bold // 선택된 탭 글자 두껍게
                                        : FontWeight.w600,
                                    color: _selectedIndex == 3
                                        ? Color(0xFF4876F2) // 선택된 탭 글자 색상
                                        : Color(0xFF4876F2).withOpacity(0.5), // 선택되지 않은 탭 글자 색상
                                    fontFamily: 'Sandoll',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 37,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selectedIndex == 4
                                        ? Color(0xFF325CD0) // 선택된 탭의 밑줄 색상
                                        : Colors.transparent, // 선택되지 않은 탭의 밑줄 색상
                                    width: 2.5, // 선택된 탭의 밑줄 두께
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 4;
                                  });
                                },
                                child: Text(
                                  '리뷰',
                                  style: TextStyle(
                                    fontWeight: _selectedIndex == 4
                                        ? FontWeight.bold // 선택된 탭 글자 두껍게
                                        : FontWeight.w600,
                                    color: _selectedIndex == 4
                                        ? Color(0xFF4876F2) // 선택된 탭 글자 색상
                                        : Color(0xFF4876F2).withOpacity(0.5), // 선택되지 않은 탭 글자 색상
                                    fontFamily: 'Sandoll',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                preferredSize: Size(20, 20),
              )
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // 네비게이터 바 아래에 표시할 내용 추가
                if (_selectedIndex == 0)
                  Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: PageView(
                          controller: _eventViewController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          children: [
                            Container(
                              color: Color(0xFF6778A6),
                              alignment: Alignment.center,
                              child: Text(
                                '페이지 1',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                            Container(
                              color: Color(0xFF6778A6),
                              alignment: Alignment.center,
                              child: Text(
                                '페이지 2',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                            Container(
                              color: Color(0xFF6778A6),
                              alignment: Alignment.center,
                              child: Text(
                                '페이지 3',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(3, (int index) {
                          return Container(
                            height: 6.0,
                            width: _currentPage == index ? 25.0 : 6.0, // 선택된 페이지의 높이를 크게 조절
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: _currentPage == index ? Color(0xFF4876F2) : Colors.grey.withOpacity(0.5),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            '우리 동네 알뜰샵들',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF4876F2),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        // 수평적으로 대칭(symmetric)의 마진을 추가 -> 화면 위, 아래에 마진 삽입
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 140.0,
                        // 리스트뷰 추가
                        child: ListView(
                          // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
                          scrollDirection: Axis.horizontal,
                          // 컨테이너들을 ListView의 자식들로 추가
                          children: <Widget>[
                            SizedBox(width: 5),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            '이 구역 주부 9단',
                            style: TextStyle(
                              fontFamily: 'Sandoll',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFF4876F2),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        // 수평적으로 대칭(symmetric)의 마진을 추가 -> 화면 위, 아래에 마진 삽입
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 140.0,
                        // 리스트뷰 추가
                        child: ListView(
                          // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
                          scrollDirection: Axis.horizontal,
                          // 컨테이너들을 ListView의 자식들로 추가
                          children: <Widget>[
                            SizedBox(width: 5),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFCFDAF6),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (_selectedIndex == 1)
                  Center(
                    child: Text('알뜰샵 페이지 내용'),
                  ),
                if (_selectedIndex == 2)
                  Center(
                    child: Text('베스트 페이지 내용'),
                  ),
                if (_selectedIndex == 3)
                  Center(
                    child: Text('이벤트 페이지 내용'),
                  ),
                if (_selectedIndex == 4)
                  Center(
                    child: Text('리뷰 페이지 내용'),
                  ),
              ],
            ),
          ),
        bottomNavigationBar: MyBottomNavigationBar()
      ),
    );
  }

  @override
  void dispose() {
    _eventViewController.dispose();
    super.dispose();
  }
}