import 'package:flutter/material.dart';
import 'package:spider_display/Res/res_text_style.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/news/page_refresh_test.dart';

import 'comic/comic_book_page/view_comic_book.dart';
import 'huxiu_main_page.dart';

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

  double screenWidth;
  double nextOffset = 0;

  double pointerStart = 0;
  double pointerEnd = 0;
  double touchRange = 0;

  //上一次停留位置
  int lastPage = 0;

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
    Size screenSize = MediaQuery.of(context).size;
    print("screen width is ${screenSize.width}");
    screenWidth = screenSize.width;

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
          child: Listener(
            onPointerDown: (event) {
              pointerStart = event.position.dx;
            },
            onPointerMove: (event) {},
            onPointerUp: (event) {
              pointerEnd = event.position.dx;
              touchRange = pointerStart - pointerEnd;

              if ((touchRange < 0 && lastPage == 0) ||
                  (touchRange > 0 && lastPage == _pages.length - 1)) {
                return;
              }
//        print("本次拖动距离： ${touchRange}");
//        print("上次位置： ${lastOffset}");
              if (touchRange > screenWidth / 8) {
                nextOffset = screenWidth * (lastPage + 1);
                Future.delayed(Duration(seconds: 0), () {
                  print("animate to ${nextOffset}");
                  _pageController.animateTo(nextOffset,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear);
                }).then((T) {
                  print("前进执行完毕！");
                  lastPage++;
                }).catchError((e) {
                  print(e);
                });
              } else if (touchRange < -1 * screenWidth / 8) {
                nextOffset = screenWidth * (lastPage - 1);
                Future.delayed(Duration(seconds: 0), () {
                  print("animate to ${nextOffset}");
                  _pageController.animateTo(nextOffset,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear);
                }).then((T) {
                  print("回退执行完毕！");
                  lastPage--;
                }).catchError((e) {
                  print(e);
                });
              } else {
                nextOffset = screenWidth * lastPage;
                Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
                  _pageController.animateTo(nextOffset,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear);
                }).then((T) {
//            print("返回完毕！");
                }).catchError((e) {
                  print(e);
                });
              }
            },
            child: PageView(
              physics: BouncingScrollPhysics(),
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
