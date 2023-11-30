import 'package:flutter/material.dart';

class HomeDiv extends StatefulWidget {
  @override
  _HomeDivState createState() => _HomeDivState();
}

class _HomeDivState extends State<HomeDiv> {
  PageController _eventViewController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool isLiked_0 = false;
  bool isLiked_1 = false;
  bool isLiked_2 = false;
  bool isLiked_3 = false;
  bool isLiked_4 = false;
  bool isLiked_5 = false;

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
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               width: 160,
               height: 180.0,
               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Color(0xFFCFDAF6), // 그림자의 색상
                     offset: Offset(6, 6), // 그림자의 위치 (수직, 수평)
                     blurRadius: 6.0, // 그림자의 흐림 정도
                     spreadRadius: 1.0, // 그림자의 전파 정도
                   ),
                 ],
               ),
               child: Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 10,
                 ),
                 child: Column(
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
                     // 좋아요 버튼
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         // 텍스트
                         Text(
                           '프루티프룻',
                           style: TextStyle(
                               fontSize: 12.0,
                               color: Color(0xFF7C869F),
                               fontWeight: FontWeight.w600
                           ),
                         ),
                         Text(
                           '군포시 산본동',
                           style: TextStyle(
                             fontSize: 6.2,
                             color: Colors.grey,
                           ),
                         ),
                         IconButton(
                           icon: Icon(
                             isLiked_0 ? Icons.favorite : Icons.favorite_border,
                             color: isLiked_0 ? Colors.red : null,
                           ),
                           iconSize: 20,
                           padding: EdgeInsets.zero,
                           constraints: BoxConstraints(),
                           onPressed: () {
                             setState(() {
                               isLiked_0 = !isLiked_0;
                             });
                           },
                         ),
                       ],
                     ),
                     SizedBox(height: 3),
                     Text(
                       '산본역 3번출구 5분 거리에 위치한 합리적인 가격의 과일...',
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
             SizedBox(width: 5),
             Container(
               width: 160,
               height: 180.0,
               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Color(0xFFCFDAF6), // 그림자의 색상
                     offset: Offset(6, 6), // 그림자의 위치 (수직, 수평)
                     blurRadius: 6.0, // 그림자의 흐림 정도
                     spreadRadius: 1.0, // 그림자의 전파 정도
                   ),
                 ],
               ),
               child: Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 10,
                 ),
                 child: Column(
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
                     // 좋아요 버튼
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         // 텍스트
                         Text(
                           '프루티프룻',
                           style: TextStyle(
                               fontSize: 12.0,
                               color: Color(0xFF7C869F),
                               fontWeight: FontWeight.w600
                           ),
                         ),
                         Text(
                           '군포시 산본동',
                           style: TextStyle(
                             fontSize: 6.2,
                             color: Colors.grey,
                           ),
                         ),
                         IconButton(
                           icon: Icon(
                             isLiked_1 ? Icons.favorite : Icons.favorite_border,
                             color: isLiked_1 ? Colors.red : null,
                           ),
                           iconSize: 20,
                           padding: EdgeInsets.zero,
                           constraints: BoxConstraints(),
                           onPressed: () {
                             setState(() {
                               isLiked_1 = !isLiked_1;
                             });
                           },
                         ),
                       ],
                     ),
                     SizedBox(height: 3),
                     Text(
                       '산본역 3번출구 5분 거리에 위치한 합리적인 가격의 과일...',
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
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               width: 160,
               height: 180.0,
               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Color(0xFFCFDAF6), // 그림자의 색상
                     offset: Offset(6, 6), // 그림자의 위치 (수직, 수평)
                     blurRadius: 6.0, // 그림자의 흐림 정도
                     spreadRadius: 1.0, // 그림자의 전파 정도
                   ),
                 ],
               ),
               child: Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 10,
                 ),
                 child: Column(
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
                     // 좋아요 버튼
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         // 텍스트
                         Text(
                           '프루티프룻',
                           style: TextStyle(
                               fontSize: 12.0,
                               color: Color(0xFF7C869F),
                               fontWeight: FontWeight.w600
                           ),
                         ),
                         Text(
                           '군포시 산본동',
                           style: TextStyle(
                             fontSize: 6.2,
                             color: Colors.grey,
                           ),
                         ),
                         IconButton(
                           icon: Icon(
                             isLiked_2 ? Icons.favorite : Icons.favorite_border,
                             color: isLiked_2 ? Colors.red : null,
                           ),
                           iconSize: 20,
                           padding: EdgeInsets.zero,
                           constraints: BoxConstraints(),
                           onPressed: () {
                             setState(() {
                               isLiked_2 = !isLiked_2;
                             });
                           },
                         ),
                       ],
                     ),
                     SizedBox(height: 3),
                     Text(
                       '산본역 3번출구 5분 거리에 위치한 합리적인 가격의 과일...',
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
             SizedBox(width: 5),
             Container(
               width: 160,
               height: 180.0,
               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Color(0xFFCFDAF6), // 그림자의 색상
                     offset: Offset(6, 6), // 그림자의 위치 (수직, 수평)
                     blurRadius: 6.0, // 그림자의 흐림 정도
                     spreadRadius: 1.0, // 그림자의 전파 정도
                   ),
                 ],
               ),
               child: Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 10,
                 ),
                 child: Column(
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
                     // 좋아요 버튼
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         // 텍스트
                         Text(
                           '프루티프룻',
                           style: TextStyle(
                               fontSize: 12.0,
                               color: Color(0xFF7C869F),
                               fontWeight: FontWeight.w600
                           ),
                         ),
                         Text(
                           '군포시 산본동',
                           style: TextStyle(
                             fontSize: 6.2,
                             color: Colors.grey,
                           ),
                         ),
                         IconButton(
                           icon: Icon(
                             isLiked_3 ? Icons.favorite : Icons.favorite_border,
                             color: isLiked_3 ? Colors.red : null,
                           ),
                           iconSize: 20,
                           padding: EdgeInsets.zero,
                           constraints: BoxConstraints(),
                           onPressed: () {
                             setState(() {
                               isLiked_3 = !isLiked_3;
                             });
                           },
                         ),
                       ],
                     ),
                     SizedBox(height: 3),
                     Text(
                       '산본역 3번출구 5분 거리에 위치한 합리적인 가격의 과일...',
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
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               width: 160,
               height: 180.0,
               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Color(0xFFCFDAF6), // 그림자의 색상
                     offset: Offset(6, 6), // 그림자의 위치 (수직, 수평)
                     blurRadius: 6.0, // 그림자의 흐림 정도
                     spreadRadius: 1.0, // 그림자의 전파 정도
                   ),
                 ],
               ),
               child: Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 10,
                 ),
                 child: Column(
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
                     // 좋아요 버튼
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         // 텍스트
                         Text(
                           '프루티프룻',
                           style: TextStyle(
                               fontSize: 12.0,
                               color: Color(0xFF7C869F),
                               fontWeight: FontWeight.w600
                           ),
                         ),
                         Text(
                           '군포시 산본동',
                           style: TextStyle(
                             fontSize: 6.2,
                             color: Colors.grey,
                           ),
                         ),
                         IconButton(
                           icon: Icon(
                             isLiked_4 ? Icons.favorite : Icons.favorite_border,
                             color: isLiked_4 ? Colors.red : null,
                           ),
                           iconSize: 20,
                           padding: EdgeInsets.zero,
                           constraints: BoxConstraints(),
                           onPressed: () {
                             setState(() {
                               isLiked_4 = !isLiked_4;
                             });
                           },
                         ),
                       ],
                     ),
                     SizedBox(height: 3),
                     Text(
                       '산본역 3번출구 5분 거리에 위치한 합리적인 가격의 과일...',
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
             SizedBox(width: 5),
             Container(
               width: 160,
               height: 180.0,
               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Color(0xFFCFDAF6), // 그림자의 색상
                     offset: Offset(6, 6), // 그림자의 위치 (수직, 수평)
                     blurRadius: 6.0, // 그림자의 흐림 정도
                     spreadRadius: 1.0, // 그림자의 전파 정도
                   ),
                 ],
               ),
               child: Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 10,
                 ),
                 child: Column(
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
                     // 좋아요 버튼
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         // 텍스트
                         Text(
                           '프루티프룻',
                           style: TextStyle(
                               fontSize: 12.0,
                               color: Color(0xFF7C869F),
                               fontWeight: FontWeight.w600
                           ),
                         ),
                         Text(
                           '군포시 산본동',
                           style: TextStyle(
                             fontSize: 6.2,
                             color: Colors.grey,
                           ),
                         ),
                         IconButton(
                           icon: Icon(
                             isLiked_5 ? Icons.favorite : Icons.favorite_border,
                             color: isLiked_5 ? Colors.red : null,
                           ),
                           iconSize: 20,
                           padding: EdgeInsets.zero,
                           constraints: BoxConstraints(),
                           onPressed: () {
                             setState(() {
                               isLiked_5 = !isLiked_5;
                             });
                           },
                         ),
                       ],
                     ),
                     SizedBox(height: 3),
                     Text(
                       '산본역 3번출구 5분 거리에 위치한 합리적인 가격의 과일...',
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
           ],
         ),
       ],
     );
  }
}