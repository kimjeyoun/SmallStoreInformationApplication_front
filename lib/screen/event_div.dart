import 'package:flutter/material.dart';

class EventDiv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 4.0
                )
              )
            ),
            width: double.infinity,
            height: 111,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'asset/img/event_img.png',
                height: double.infinity,
              )
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 4.0
                    )
                )
            ),
            width: double.infinity,
            height: 111,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'asset/img/event_img.png',
                height: double.infinity,
              )
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 4.0
                    )
                )
            ),
            width: double.infinity,
            height: 111,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'asset/img/event_img.png',
                 height: double.infinity,
              )
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 4.0
                    )
                )
            ),
            width: double.infinity,
            height: 111,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'asset/img/event_img.png',
                height: double.infinity,
              )
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 4.0
                    )
                )
            ),
            width: double.infinity,
            height: 111,
            child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'asset/img/event_img.png',
                  height: double.infinity,
                )
            ),
          ),
        ],
      ),
    );
  }
}