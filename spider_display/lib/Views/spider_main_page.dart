import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/search_delegate.dart';
import 'package:spider_display/Modle/bookset_modle.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Res/res_text_style.dart';
import 'package:spider_display/Views/bookset_list_page.dart';
import 'package:spider_display/Views/huxiu_main_page.dart';
import 'package:spider_display/Views/search_page.dart';

class SpiderMainPage extends StatefulWidget {
  @override
  _SpiderMainPageState createState() => new _SpiderMainPageState();
}

class _SpiderMainPageState extends State<SpiderMainPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> titleTabs = <Tab>[
    Tab(
      text: "虎嗅",
    ),
    Tab(
      text: "Bookset",
    ),
    Tab(
      text: "触乐网",
    ),
    Tab(
      text: "V2EX",
    ),
    Tab(
      text: "端传媒",
    ),
    Tab(
      text: "LOL",
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: titleTabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Book> bookList =
        BookList.fromJson(json.decode(BOOK_LIST_JSON_STR)).data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: getAppBarMenuBtns(),
        title: TabBar(
          controller: _tabController,
          tabs: titleTabs,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey[700],
          labelStyle: TabBarViewTitleSelectedStyle,
          unselectedLabelStyle: TabBarViewTitleUnselectedStyle,
          isScrollable: true,
          indicator: UnderlineTabIndicator(
            insets: const EdgeInsets.all(5.0),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 3.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.green,
        child: Container(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              HuxiuMainPage(),
              BooksetListPage(bookList, null),
              TestPage(),
              TestPage(),
              TestPage(),
              TestPage(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  /**
   * 获取AppBar上的点按菜单按钮
   */
  List<Widget> getAppBarMenuBtns() {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: () {
          //跳转到搜索界面
          showCustomSearch(context: context, delegate: SearchPage());
        },
      )
    ];
  }
}
