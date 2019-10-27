import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Res/res_text_style.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/news/page_refresh_test.dart';

import 'comic/comic_book_page/view_comic_book.dart';
import 'news/news_page/view_huxiu_main.dart';

class SpiderMainPage extends StatefulWidget {
  @override
  _SpiderMainPageState createState() => new _SpiderMainPageState();
}

class _SpiderMainPageState extends State<SpiderMainPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _pages = [];
  final _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  bool isPageCanChange = true;

  final List<Tab> titleTabs = <Tab>[
    Tab(
      text: "漫画",
    ),
    Tab(
      text: "虎嗅",
    ),
    Tab(
      text: "触乐网",
    ),
    Tab(
      text: "爱范儿",
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages.add(ComicBookPage());
    _pages.add(new NewsMainPage("huxiu"));
    _pages.add(new NewsMainPage("chule"));
    _pages.add(new NewsMainPage("ifanr"));

    _tabController = TabController(length: titleTabs.length, vsync: this);

    //监听PageView
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        onPageChange(_tabController.index, p: _pageController);
      }
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChange = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      isPageCanChange = true;
    } else {
      _tabController.animateTo(index);
    }
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
        color: Colors.white,
        child: Container(
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: false,
            children: _pages,
            onPageChanged: (index) {
              if (isPageCanChange) {
                onPageChange(index);
              }
            },
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
//          showCustomSearch(context: context, delegate: HomeSearchPage());

          NavigatorRouterUtils.pushToPage(context, RefreshTestPage());
        },
      )
    ];
  }
}

Future<String> loadMore() async {
  print("loadMore: ${DateTime.now()}");
  await Future.delayed(Duration(seconds: 3), () {
    return "LoadMore Success!";
  });
}
