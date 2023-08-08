import 'package:flutter/material.dart';

class UserTypeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // 앱바의 그림자 없애기
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Color(0xFF143386), // 뒤로가기 버튼 색상
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            '어떤 유형의 고객이신가요?',
            style: TextStyle(color: Color(0xFF4876F2), fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
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
                        color: Color(0xFF4876F2).withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 7), // 오른쪽과 아래로 그림자 적용
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4876F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.person, color: Colors.white, size: 40),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '좋은 물건을 합리적인',
                                style: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '가격에 판매하는 셀러',
                                style: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold),
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

          SizedBox(height: 40),
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
                        color: Color(0xFF488f43).withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 7), // 오른쪽과 아래로 그림자 적용
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFb3ec9d),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.person, color: Colors.white, size: 40),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬 설정
                            children: [
                              Text(
                                '뛰어난 안목으로 알뜰한',
                                style: TextStyle(fontSize: 19, color: Color(0xFF488f43), fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '소비를 하는 구매자',
                                style: TextStyle(fontSize: 19, color: Color(0xFF488f43), fontWeight: FontWeight.bold),
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

          // 새로운 버튼 추가
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 65, // 원하는 높이로 조정
                child: ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 시 동작 설정
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF143386), // 원하는 색상
                    shape: RoundedRectangleBorder(),
                  ),
                  child: Text(
                    '다음으로',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
