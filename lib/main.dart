import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:where_shop_project/screen/login_page.dart';
import 'package:where_shop_project/screen/user_type_selection_page.dart';
import 'package:where_shop_project/screen/logo_page.dart';
import 'package:where_shop_project/screen/kakao_map_page.dart';
import 'package:where_shop_project/screen/main_page.dart';
import 'package:where_shop_project/screen/my_page.dart';
import 'package:where_shop_project/screen/pw_find_first_page.dart';
import 'package:where_shop_project/screen/pw_find_second_page.dart';
import 'package:where_shop_project/screen/business_registration_num_verify_page.dart';
import 'package:where_shop_project/screen/additional_business_info_page.dart';
import 'package:where_shop_project/screen/customer_add_indo_page.dart';

void main() {
  AuthRepository.initialize(appKey: 'fa4f3ec1c61f1d480b71d4d0c2ce927b');
  KakaoSdk.init(nativeAppKey: 'a91268cc8e8aa84cc31131d407c3076a');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LogoPage(),
        '/login' : (context) => LoginPage(),
        '/selection':  (context) => UserTypeSelectionPage(),
        '/map': (context) => KakaoMapPage(),
        '/main': (context) => MainPage(),
        '/mypage': (context) => MyPage(),
        '/pwfindfirst': (context) => PwFindFirstPage(),
        '/pwfindsecond': (context) => PwFindSecondPage(),
        '/customerAddInfo': (context) => CustomerAddInfoPage(),
      },
    );
  }
}




