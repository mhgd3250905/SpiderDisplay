import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/search_delegate.dart';
import 'package:spider_display/Modle/bookset_modle.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Views/bookset_list_page.dart';
import 'package:spider_display/Views/huxiu_main_page.dart';
import 'package:spider_display/Views/search_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      title: '爬虫展示',
      home: new HomePage(),
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
    _pages.add(HuxiuMainPage());
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
   * 获取AppBar上的点按菜单按钮
   */
  List<Widget> getAppBarMenuBtns() {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          //跳转到搜索界面
          showCustomSearch(context: context, delegate: SearchPage());
        },
      )
    ];
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
      appBar: AppBar(
        //边界阴影
        elevation: 0.0,
        //标题
        title: new Text('爬虫展示'),
        //侧边按钮
        actions: getAppBarMenuBtns(),
      ),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
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
