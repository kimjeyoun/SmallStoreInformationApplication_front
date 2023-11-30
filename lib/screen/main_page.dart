import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_shop_project/screen/home_div.dart';
import 'package:where_shop_project/screen/event_div.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey 생성
  final SearchController _searchController = SearchController();
  bool _showClearButton = false;
  int _selectedIndex = 0;
  int _currentIndex = 2;

  PageController _eventViewController = PageController(initialPage: 0);
  int _currentPage = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff4876F2),
    ));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          key: _scaffoldKey, // Scaffold에 key를 설정
          resizeToAvoidBottomInset: false, // 추가
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: Size(20, 20),
                child: Column(
                  children: [
                    Image.asset(
                      'asset/img/wordmark_main.png',
                      width: 90,
                    ),
                    Row(
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
                        SizedBox(width: 10),
                        Container(
                          width: 225,
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
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          color: Color(0xff4876F2),
                          icon: const Icon(
                              Icons.notifications_none
                          ),
                        )
                      ],
                    ),
                    Row(
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
                  ],
                )
              )
            ),
          ),
          drawer: MyDrawer(),
          endDrawer: MyDrawer(), // endDrawer 추가
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // 네비게이터 바 아래에 표시할 내용 추가
                if (_selectedIndex == 0)
                  HomeDiv(),
                if (_selectedIndex == 1)
                  Center(
                    child: Text('알뜰샵 페이지 내용'),
                  ),
                if (_selectedIndex == 2)
                  Center(
                    child: Text('베스트 페이지 내용'),
                  ),
                if (_selectedIndex == 3)
                  EventDiv(),
                if (_selectedIndex == 4)
                  Center(
                    child: Text('리뷰 페이지 내용'),
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

  @override
  void dispose() {
    _eventViewController.dispose();
    super.dispose();
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