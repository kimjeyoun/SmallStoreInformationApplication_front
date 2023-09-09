import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KakaoMapPage extends StatefulWidget {
  const KakaoMapPage({Key? key, this.title}) : super(key: key);
  
  final String? title;
  
  @override
  _KakaoMapPageState createState() => _KakaoMapPageState();
}

class _KakaoMapPageState extends State<KakaoMapPage> {
  late KakaoMapController mapController;
  Set<Marker> markers = {}; // 마커 변수
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("kakao map"),
      ),
      body: Stack(
        children: [
          KakaoMap(
            onMapCreated: ((controller) async {
              mapController = controller;

              markers.add(Marker(
                markerId: UniqueKey().toString(),
                latLng: await mapController.getCenter(),
              ));

              setState(() { });
            }),
            currentLevel: 8,
            onZoomChangeCallback: ((zoomLevel, zoomType) {
              message = '현재 지도 레벨은 $zoomLevel 입니다';

              setState(() {});
            }),
            markers: markers.toList(),
            center: LatLng(37.3608681, 126.9306506),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.white,
              child: Text(message),
            ),
          )
        ],
      )
    );
  }
}

