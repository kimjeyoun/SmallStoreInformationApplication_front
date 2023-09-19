import 'package:flutter/material.dart';
import 'package:where_shop_project/screen/register_first_page.dart';

class UserTypeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // 앱바의 그림자 없애기
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: const Color(0xFF143386), // 뒤로가기 버튼 색상
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 45),
            const Text(
              '어떤 유형의 고객이신가요?',
              style: TextStyle(
                fontFamily: 'Sandoll',
                color: Color(0xFF4876F2),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // 오른쪽 정렬 설정
              children: [
                SizedBox(
                  width: 350,
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4876F2).withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 7), // 오른쪽과 아래로 그림자 적용
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FirstRegisterForm('SHOPOWNE')
                          )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF4876F2),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.person, color: Colors.white, size: 40),
                          ),
                          const SizedBox(width: 30),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '좋은 물건을 합리적인',
                                  style: TextStyle(
                                    fontFamily: 'Sandoll',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '가격에 판매하는 셀러',
                                  style: TextStyle(
                                    fontFamily: 'Sandoll',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // 오른쪽 정렬 설정
              children: [
                SizedBox(
                  width: 350,
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF488f43).withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 7), // 오른쪽과 아래로 그림자 적용
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstRegisterForm('USER')
                            )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFb3ec9d),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: const Icon(Icons.person, color: Colors.white, size: 40),
                          ),
                          const SizedBox(width: 30),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬 설정
                              children: [
                                Text(
                                  '뛰어난 안목으로 알뜰한',
                                  style: TextStyle(
                                    fontFamily: 'Sandoll',
                                    fontSize: 16,
                                    color: Color(0xFF166319),
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  '소비를 하는 구매자',
                                  style: TextStyle(
                                    fontFamily: 'Sandoll',
                                    fontSize: 16,
                                    color: Color(0xFF166319),
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
