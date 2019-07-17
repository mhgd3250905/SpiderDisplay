import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spider_display/Modle/bookset_modle.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Views/bookset_list_page.dart';
import 'package:spider_display/Views/spider_main_page.dart';

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
    List<Book> bookList =
        BookList.fromJson(json.decode(BOOK_LIST_JSON_STR)).data;
    _pages.add(SpiderMainPage());
    _pages.add(BooksetListPage(bookList, null));
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
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        pageSnapping: false,
        children: _pages,
        onPageChanged: (index) {
          //切换的时候下方的bottomNavigationBar也需要响应的切换
          if (_selectedIndex != index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          buildBottomNavigationBarItem(Icons.book, 'Bookset'),
          buildBottomNavigationBarItem(Icons.cloud_circle, 'Test'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.green,
        onTap: onBottomNavigationItemTap,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}