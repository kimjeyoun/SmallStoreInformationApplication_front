import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}