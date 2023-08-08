import 'package:flutter/material.dart';
import 'package:where_shop_project/screen/login_page.dart';
import 'package:where_shop_project/screen/register_page.dart';
import 'package:where_shop_project/screen/user_type_selection_page.dart';
import 'package:where_shop_project/screen/logo_page.dart';

void main() {
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
        '/register': (context) => RegisterPage(),
        '/selection':  (context) => UserTypeSelectionPage(),
      },
    );
  }
}




