import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoreAddItemPage extends StatefulWidget {
  final String shopNumber;
  final String userroll;

  const StoreAddItemPage(this.shopNumber, this.userroll);

  @override
  _StoreAddItemPageState createState() => _StoreAddItemPageState();
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

class _StoreAddItemPageState extends State<StoreAddItemPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey 생성
  int _currentIndex = 4;

  late List<Product> products = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool showAddProductFields = false;
  String? selectedImagePath;
  XFile? imageFile;

  late Map shopData; // 가게 데이터
  late List itemData; // 상품 데이터


  void fetchAndDisplayShopData() async {
    shopData = await _showShop();
    print("$shopData");
  }

  void fetchAndDisplayItemData() async {
    itemData = await _showItem(widget.shopNumber);
    for(Map value in itemData){
      products.add(Product(
        name: value['itemName'],
        price: value['itemPrice'],
        description: value['itemInfo'],
        imageUrl: value['itemImg'] ?? '',
      ));
    }

  }

  @override
  void initState() {
    fetchAndDisplayShopData();
    fetchAndDisplayItemData();
    super.initState();
  }

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImagePath = pickedFile.path;
      });
    }
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
                  )
                  // Image.file(
                  // File(받아온 가게 이미지),
                  // fit: BoxFit.cover,
                  //),
                )
              else
                Container(
                    height: 200,
                    child: Image.asset(
                      '${shopData['shopPicture']}',
                      fit: BoxFit.cover,
                    )
                  // Image.file(
                  // File(받아온 가게 이미지),
                  // fit: BoxFit.cover,
                  //),
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
                                  style: const TextStyle(
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
              Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          if (selectedImagePath != null)
                            Container(
                              height: 70,
                              width: 100,
                              child: Image.file(
                                File(selectedImagePath!),
                              ),
                            ),
                          if (selectedImagePath != null)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // 이미지 초기화 로직
                                  setState(() {
                                    selectedImagePath = null;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 20),
                      if (selectedImagePath == null)
                        ElevatedButton(
                          onPressed: () {
                            _pickImageFromGallery();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(40, 100), // 버튼의 최소 너비를 설정
                            primary: Color(0xff4876F2), // 버튼의 배경색을 회색으로 설정
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text('상품 이미지'),
                        ),
                      SizedBox(width: 20),
                      // 상품 정보 입력 필드
                      Column(
                        children: [
                          Container(
                            width: 250,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(labelText: '상품 이름'),
                            ),
                          ),
                          Container(
                            width: 250,
                            child: TextField(
                              controller: priceController,
                              decoration: InputDecoration(labelText: '상품 가격'),
                            ),
                          ),
                          Container(
                            width: 250,
                            child: TextField(
                              controller: descriptionController,
                              decoration: InputDecoration(labelText: '상품 설명'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // 완료 버튼
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // 새 상품을 목록에 추가
                    products.add(Product(
                      name: nameController.text,
                      price: priceController.text,
                      description: descriptionController.text,
                      imageUrl: selectedImagePath ?? '',
                    ));
                    _itemRegist(nameController.text, priceController.text,
                        descriptionController.text, selectedImagePath ?? '', widget.shopNumber);
                    // 입력 필드 초기화
                    nameController.clear();
                    priceController.clear();
                    descriptionController.clear();
                    // 이미지 초기화
                    selectedImagePath = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff4876F2), // 버튼의 배경색을 회색으로 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('상품 추가'),
              ),
              // 상품 목록 표시
              Container(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 250,
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.imageUrl!.isNotEmpty)
                              Container(
                                height: 70,
                                width: 100,
                                child: Image.file(
                                  File(product.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('가격: ${product.price}원'),
                                Text(product.description),
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
  Future<Map> _showShop() async {
    String url = 'http://10.0.2.2:3000/shop/myShop';
    final storage = FlutterSecureStorage();
    String? refreshToken = await storage.read(key: 'refreshToken');
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $accessToken',
      'refreshToken': 'bearer $refreshToken',
    };

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        Map res = jsonDecode(utf8.decode(response.bodyBytes));
        print('respone : ${res['data']}');
        return res['data'];
      } else {
        // 기타 오류
        print('가게 데이터 불러오기 오류 ${response.statusCode}');
        _showDialog('오류', '가게 데이터 불러오기 오류');
        return {};
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
      return {};
    }
  }

  // 상품 등록
  void _itemRegist(String name, String price, String info, String img, String shopNum) async {
    String url = 'http://10.0.2.2:3000/item/registItem';
    final storage = FlutterSecureStorage();
    String? refreshToken = await storage.read(key: 'refreshToken');
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $accessToken',
      'refreshToken': 'bearer $refreshToken',
    };

    Map<String, String> body = {
      'itemName': name,
      'itemPrice': price,
      'itemInfo': info,
      'itemImg': img,
      'shopNum': shopNum,
    };

    print("body : $body");
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        print('respone : ${response.body}');
        _showDialog('성공', '아이템 등록 성공');
      } else {
        // 기타 오류
        print('가게 데이터 불러오기 오류 ${response.statusCode}');
        _showDialog('오류', '가게 데이터 불러오기 오류');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }

  // 상품 데이터 불러오기
  Future<List> _showItem(String shopNum) async {
    String url = 'http://10.0.2.2:3000/item/showList?shopNum=$shopNum';
    final storage = FlutterSecureStorage();
    String? refreshToken = await storage.read(key: 'refreshToken');
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $accessToken',
      'refreshToken': 'bearer $refreshToken',
    };

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        List res = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        print('respone : $res');
        return res;
      } else if(response.statusCode == 400){
        _showDialog('완료', '상품 데이터가 없습니다.');
        return [];
      }else {
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