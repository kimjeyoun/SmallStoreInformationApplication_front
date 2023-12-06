import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:where_shop_project/screen/login_page.dart';
import 'package:where_shop_project/screen/user_type_selection_page.dart';
import 'package:where_shop_project/screen/logo_page.dart';
import 'package:where_shop_project/screen/kakao_map_page.dart';
import 'package:where_shop_project/screen/main_page.dart';
import 'package:where_shop_project/screen/my_page.dart';
import 'package:where_shop_project/screen/pw_find_first_page.dart';
import 'package:where_shop_project/screen/my_page_business.dart';
import 'package:where_shop_project/screen/store_add_item_page.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository.initialize(appKey: dotenv.get('Api_Key'));
  KakaoSdk.init(nativeAppKey: dotenv.get('Native_Key'));
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
        '/selection':  (context) => UserTypeSelectionPage(),
        '/map': (context) => KakaoMapPage(),
        '/mypage': (context) => MyPage(),
        '/pwfindfirst': (context) => PwFindFirstPage(),
      },
    );
  }
}




