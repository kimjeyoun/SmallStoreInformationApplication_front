import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_shop_project/screen/login_page.dart';

class StorePage extends StatefulWidget {
  const StorePage();

  @override
  _StorePageState createState() => _StorePageState();
}

class Product {
  final String name;
  final String price;
  final String description;
  final String? imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl,
  });
}

class _StorePageState extends State<StorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey 생성
  int _currentIndex = 4;

  List<Product> products = [];

  late http.Response shopData; // 가게 데이터
  late http.Response itemData; // 상품 데이터

  String address = '경기도 군포시'; // 임시 주소
  String shopNum = '123456'; // 임시 가게 번호

  void fetchAndDisplayShopData() async {
    shopData = await _showShop(address);
  }

  void fetchAndDisplayItemData() async {
    itemData = await _showItem(shopNum);
  }

  @override
  void initState() {
    super.initState();
    fetchAndDisplayShopData();
    fetchAndDisplayItemData();
  }


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
    final List<Map<String, String>> products_test = [
      { // 임시 상품 데이터
        'itemName': '사과',
        'itemPrice': '1500',
        'itemInfo': '맛있는 사과',
        'itemImg': 'asset/img/apple.jpg',
        'shopNum': '1',
      },
      {
        'itemName': '포도',
        'itemPrice': '3000',
        'itemInfo': '맛있는 포도',
        'itemImg': 'asset/img/grape.jpg',
        'shopNum': '1',
      },
      {
        'itemName': '바나나',
        'itemPrice': '2000',
        'itemInfo': '맛있는 바나나',
        'itemImg': 'asset/img/banana.jpg',
        'shopNum': '1',
      },
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                child: Image.asset(
                  'asset/img/test_img.jpg',
                  fit: BoxFit.cover,
                ),
                // Image.file(
                // File(받아온 가게 이미지),
                // fit: BoxFit.cover,
                // ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          width: 10.0,
                          color: Colors.grey.withOpacity(0.1),
                        )
                    )
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 50,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue, // 로고 색상
                              ),
                              // 가게 로고 이미지를 넣으세요.
                              child: Image.asset(
                                  'asset/img/logo.png'
                              )
                              // Image.file(
                              // File(가게 로고),
                              //),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '가게 이름',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('가게 주소'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ),


              // 상품 목록 표시
              Container(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: products_test.length,
                  itemBuilder: (context, index) {
                    final product = products_test[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 250,
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product['itemImg']!.isNotEmpty)
                              Container(
                                height: 70,
                                width: 100,
                                child: Image.asset( // 임시
                                  product['itemImg']!,
                                  fit: BoxFit.cover,
                                ),
                                // Image.file(
                                // File(product['itemImg']!),
                                // fit: BoxFit.cover,
                                // ),
                              ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['itemName']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('가격: ${product['itemPrice']}원'),
                                Text(product['itemInfo']!),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
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

  // 가게 데이터 불러오기
  Future<http.Response> _showShop(String address) async {
    String url = 'http://10.0.2.2:3000/shop/showShop';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'address': address,
    };

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('respone : ${response.body}');
        return response;
      } else {
        // 기타 오류
        print('가게 데이터 불러오기 오류 ${response.statusCode}');
        _showDialog('오류', '가게 데이터 불러오기 오류');
        return Future.error('가게 데이터 불러오기 오류');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
      return Future.error('서버와 통신 중에 오류가 발생했습니다.');
    }
  }

  // 상품 데이터 불러오기
  Future<http.Response> _showItem(String shopNum) async {
    String url = 'http://10.0.2.2:3000/item/showList';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'shopNum': shopNum,
    };

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('respone : ${response.body}');
        return response;
      } else {
        // 기타 오류
        print('상품 데이터 불러오기 오류 ${response.statusCode}');
        _showDialog('오류', '상품 데이터 불러오기 오류');
        return Future.error('상품 데이터 불러오기 오류');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
      return Future.error('서버와 통신 중에 오류가 발생했습니다.');
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