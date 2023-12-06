import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:where_shop_project/screen/store_page.dart';

class HomeDiv extends StatefulWidget {
  final List resList;

  HomeDiv({super.key, required this.resList});
  @override
  State<HomeDiv> createState() => _HomeDivState();
}

class _HomeDivState extends State<HomeDiv> {
  final PageController _eventViewController = PageController(initialPage: 0);
  int _currentPage = 0;
  List shopData = [];
  List<bool> isLikedList = [];

  @override
  void initState() {
    super.initState();
    shopData = widget.resList;
    isLikedList = List.generate(shopData.length, (index) => false);
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
     return Column(
       children: [
         Container(
           height: 200,
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
             SizedBox(width: 36),
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
           height: MediaQuery.of(context).size.height - 247, // 화면의 높이에서 헤더 등의 높이를 빼서 남은 부분에 리스트뷰가 채워지도록 설정
           child: ListView.builder(
             physics: ClampingScrollPhysics(), // 스크롤 가능하도록 설정
             shrinkWrap: true,
             itemCount: (shopData.length / 2).ceil(),
             itemBuilder: (context, rowIndex) {
               final isLastRow = rowIndex == (shopData.length / 2).ceil() - 1;
               return Container(
                 margin: EdgeInsets.only(left: isLastRow ? 20 : 0),
                 child: Row(
                   mainAxisAlignment: isLastRow ? MainAxisAlignment.start : MainAxisAlignment.center,
                   children: [
                     buildShopContainer(shopData[rowIndex * 2], isLikedList[rowIndex * 2], () {
                       setState(() {
                         isLikedList[rowIndex * 2] = !isLikedList[rowIndex * 2];
                       });
                     }),
                     SizedBox(width: 10),
                     if (rowIndex * 2 + 1 < shopData.length)
                       buildShopContainer(shopData[rowIndex * 2 + 1], isLikedList[rowIndex * 2 + 1], () {
                         setState(() {
                           isLikedList[rowIndex * 2 + 1] = !isLikedList[rowIndex * 2 + 1];
                         });
                       }),
                   ],
                 ),
               );
             },
           ),
         ),
       ],
     );
  }

  Widget buildShopContainer(Map<String, dynamic> shop, bool isLiked, VoidCallback onPressed) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StorePage()),
        );
      },
      child: Container(
        width: 160,
        height: 180.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFCFDAF6),
              offset: Offset(6, 6),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('asset/img/test_img.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    shop['storeName'] ?? '',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF7C869F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    shop['storeAddress'] ?? '',
                    style: TextStyle(
                      fontSize: 6.2,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : null,
                    ),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: onPressed,
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                shop['storeInfo'] ?? '',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF7C869F),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}