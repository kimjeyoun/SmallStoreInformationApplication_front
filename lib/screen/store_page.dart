import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  final Map<String, dynamic> shopMap;
  final List itemList;
  const StorePage({super.key, required this.shopMap, required this.itemList});

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

  late Map shopData = widget.shopMap; // 가게 데이터
  late List itemData = widget.itemList; // 상품 데이터

  @override
  void initState() {
    super.initState();
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
              if(shopData['shopPicture'] == null)
                Container(
                  height: 200,
                  child: Image.asset(
                    'asset/img/wordmark_blue.jpg',
                    fit: BoxFit.cover,
                  ),
                  // Image.file(
                  // File(받아온 가게 이미지),
                  // fit: BoxFit.cover,
                  // ),
                )
              else
                Container(
                  height: 200,
                  child: Image.asset(
                    '${shopData['shopPicture']}',
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
                            if(shopData['shopLogo'] == null)
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
                              )
                            else
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
                                      '${shopData['shopLogo']}'
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
                                  '${shopData['shopName']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${shopData['shopAddress']}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ),

              if(itemData.isEmpty)
                Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: const Text('상품이 없습니다.',
                  style: TextStyle(
                    fontSize: 25,
                    ),
                  ),
                )
              else
              // 상품 목록 표시
                Container(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemData.length,
                    itemBuilder: (context, index) {
                      final product = itemData[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          height: 80,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                  height: 70,
                                  width: 100,
                                  child: Image.asset( // 임시
                                    product['itemImg'],
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
                                    product['itemName'],
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