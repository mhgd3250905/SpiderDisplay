import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/search_delegate.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Res/res_text_style.dart';
import 'package:spider_display/Views/bookset_list_page.dart';
import 'package:spider_display/Views/page_news_main.dart';
import 'package:spider_display/Views/page_search.dart';

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
      text: "触乐网",
    ),
    Tab(
      text: "V2EX",
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
    List<NewsBean> chuleList =
        NewsListBean.fromJson(json.decode(CHULE_LIST_JSON_STR)).data;
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
              NewsMainPage("huxiu"),
              NewsMainPage("chule"),
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
          showCustomSearch(context: context, delegate: HomeSearchPage());
        },
      )
    ];
  }
}
