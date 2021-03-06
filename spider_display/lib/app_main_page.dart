import 'dart:convert';

import 'package:flutter/material.dart';

import 'Views/news/spider_main_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      title: '爬虫展示',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Widget> _pages = [];
  final _controller = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages.add(SpiderMainPage());
  }

  ///BottomNavigationBar点击事件
  void onBottomNavigationItemTap(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /**
   * 获取BottomNavigationItem
   */
  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData iconData, String title) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
      ),
      title: Text(
        title,
        style: TextStyle(
          height: 1.1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.green,
      body: SpiderMainPage(),
//      bottomNavigationBar: BottomNavigationBar(
//        items: <BottomNavigationBarItem>[
//          buildBottomNavigationBarItem(Icons.book, 'Bookset'),
//          buildBottomNavigationBarItem(Icons.cloud_circle, 'Test'),
//        ],
//        currentIndex: _selectedIndex,
//        fixedColor: Colors.green,
//        onTap: onBottomNavigationItemTap,
//        type: BottomNavigationBarType.fixed,
//      ),
    );
  }
}
