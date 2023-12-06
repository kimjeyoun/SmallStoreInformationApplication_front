import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdditionalBusinessInfoPage extends StatefulWidget {
  final String id;
  final String businessNum;
  final String businessName;
  final String businesLocation;
  final String businessPhoneNum;

  const AdditionalBusinessInfoPage(
      this.id, this.businessNum, this.businessName,
      this.businesLocation, this.businessPhoneNum
      );

  @override
  _AdditionalBusinessInfoPageState createState() => _AdditionalBusinessInfoPageState();
}

class _AdditionalBusinessInfoPageState extends State<AdditionalBusinessInfoPage> {
  // FocusNode 변수
  String selectedCategory = '';
  List<String> categories = ['선택해주세요', '1 : 음식점', '2 : 잡화점', '3 : 상점', '4 : 뷰티', '5 : 푸드트럭'];

  // image 변수
  final picker = ImagePicker();
  XFile? _logoImage; // 가게 로고
  XFile? _storeImage; // 가게 사진

  // 이벤트 초기화
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCategory = categories[0];
    });
  }

  // 함수
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
  void dispose() {
    super.dispose();
  }

  // 컨트롤러

  // 위젯 빌드 시작
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Color(0xFF4876F2),
          body: SingleChildScrollView(
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1.0,
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.white, // 뒤로가기 버튼 색상
                          ),
                          const SizedBox(width: 100),
                          Image.asset(
                            'asset/img/wordmark_white.png',
                            width: 90,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 40
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '추가 정보를 입력해주세요',
                              style: TextStyle(
                                fontFamily: 'Sandoll',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),

                            SizedBox(height: 45),

                            // businessNum TextField
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '가게 카테고리 번호',
                                  style: TextStyle(
                                      fontFamily: 'Sandoll',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15
                                  ),
                                ),
                                Container(
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.white24
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton(
                                    value: selectedCategory,
                                    style: TextStyle(
                                        fontFamily: 'Sandoll',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    dropdownColor: Colors.white,
                                    items: categories
                                        .map((e) => DropdownMenuItem(
                                      value: e, // 선택 시 onChanged 를 통해 반환할 value
                                      child: Text(e),
                                    ))
                                        .toList(),
                                    onChanged: (value) { // items 의 DropdownMenuItem 의 value 반환
                                      setState(() {
                                        selectedCategory = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 15),

                            //가게 로고
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '가게 로고\n(100 X 100)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Sandoll',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                  ),
                                ),
                                _logoImage != null ? Container(
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.all(10),
                                    child: _logoImage != null ?
                                    Stack(
                                      children: [
                                        Image.file(
                                            File(_logoImage!.path)
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            //삭제 버튼
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              icon: Icon(Icons.close,
                                                  color: Colors.white,
                                                  size: 15),
                                              onPressed: () {
                                                //버튼을 누르면 해당 이미지가 삭제됨
                                                setState(() {
                                                  _logoImage = null;
                                                });
                                              },
                                            )
                                        )
                                      ],
                                    ) : Text('이미지를 선택해 주세요')
                                ) :
                                Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: IconButton(
                                        onPressed: () async {
                                          _logoImage = await picker.pickImage(source: ImageSource.gallery);
                                          setState(() {
                                            //multiImage를 통해 갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                                            this._logoImage = _logoImage;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                              ],
                            ),

                            SizedBox(height: 15),

                            //가게 사진
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '가게 사진\n(150 X 100)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Sandoll',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15
                                  ),
                                ),
                                _storeImage != null ? Container(
                                    width: 150,
                                    height: 100,
                                    margin: EdgeInsets.all(10),
                                    child: _storeImage != null ?
                                    Stack(
                                      children: [
                                        Image.file(
                                            File(_storeImage!.path)
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            //삭제 버튼
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              icon: Icon(Icons.close,
                                                  color: Colors.white,
                                                  size: 15),
                                              onPressed: () {
                                                //버튼을 누르면 해당 이미지가 삭제됨
                                                setState(() {
                                                  _storeImage = null;
                                                });
                                              },
                                            )
                                        )
                                      ],
                                    ) : Text('이미지를 선택해 주세요')
                                ) :
                                Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: IconButton(
                                        onPressed: () async {
                                          _storeImage = await picker.pickImage(source: ImageSource.gallery);
                                          setState(() {
                                            //multiImage를 통해 갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                                            this._storeImage = _storeImage;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                    )
                                ),

                              ],
                            ),

                            SizedBox(height: 25),

                            // next btn
                            ElevatedButton(
                              onPressed: () {
                                String categortNum = selectedCategory.split(" ")[0];
                                String id = widget.id;
                                String shopAddress = widget.businesLocation;
                                String? shopLogo = _logoImage?.path;
                                String shopName = widget.businessName;
                                String shopNumber = widget.businessNum;
                                String shopPhoneNumber = widget.businessPhoneNum;
                                String? shopPicture = _storeImage?.path;
                                _storeRegistration(
                                  categortNum, id, shopAddress, shopLogo,
                                  shopName, shopNumber, shopPhoneNumber, shopPicture
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF143386),
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                '다음으로',
                                style: TextStyle(
                                  fontFamily: 'Sandoll',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
          )
      ),
    );
  }

  void _storeRegistration(String categoryNum, String id, String shopAddress,
      String? shopLogo, String shopName, String shopNumber,
      String shopPhoneNumber, String? shopPicture) async {
    String url = 'http://10.0.2.2:3000/shop/regist';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'categoryNum' : categoryNum,
      'id': id,
      'shopAddress': shopAddress,
      'shopLogo' : shopLogo,
      'shopName' : shopName,
      'shopNumber' : shopNumber,
      'shopPhoneNumber' : shopPhoneNumber,
      'shopPicture' : shopPicture,
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        _showDialog('가게 등록 성공', '로그인을 해주세요.');
        Navigator.pushNamed(context, '/login');
      } else {
        // 기타 오류
        print('가게 등록 오류 ${response.statusCode}');
        print('body: $body');
        _showDialog('오류', '가게 등록 중 오류가 발생했습니다.');
      }
    } catch (e) {
      print("response : ${e}");
      _showDialog('오류', '서버와 통신 중에 오류가 발생했습니다.');
    }
  }
}