import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final SearchController _searchController = SearchController();

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
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    const Icon(
                      Icons.location_on,
                      color: Color(0xff4876F2),
                      size: 20,
                    ),
                    TextButton(
                      onPressed: (){},
                      child: const Text(
                        '현위치 ⌵',
                        style: TextStyle(
                          fontFamily: 'Sandoll',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff4876F2)
                        ),
                      ),
                    ),
                    Container(
                      width: 225,
                      height: 30,
                      child: SearchAnchor(
                          builder:
                              (BuildContext context, SearchController controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 요소들을 가로 방향으로 최대한 분산 배치
                              children: [
                                SearchBar(
                                  controller: _searchController,
                                  trailing: <Widget> [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.search,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }, suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        return List<ListTile>.generate(5, (int index) {
                          final String item = 'item $index';
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                controller.closeView(item);
                              });
                            },
                          );
                        });
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}