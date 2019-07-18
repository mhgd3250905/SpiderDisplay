import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Views/huxiu_list_page.dart';

const int PAGE_COUNT = 10;

class HuxiuMainPage extends StatefulWidget {
  @override
  _HuxiuMainPageState createState() => new _HuxiuMainPageState();
}

class _HuxiuMainPageState extends State<HuxiuMainPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = new ScrollController();
  GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();
  List<HuxiuNews> dataList = [];
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  Future<List<HuxiuNews>> getData() async {
    var dio = new Dio();
    Response response = await dio.get(getHuxiuListUrl("huxiu", page));
    HuxiuNewsList bean = HuxiuNewsList(response.data);
    print("getData dataList.length= ${dataList.length}");
    return bean.data;
  }

  Future<List<HuxiuNews>> resetData() async {
    page = 0;
    var dio = new Dio();
    Response response = await dio.get(getHuxiuListUrl("huxiu", page));
    HuxiuNewsList bean = HuxiuNewsList(response.data);
    dataList.clear();
    dataList.addAll(bean.data);
    dataList = fliterHuxiuNews(dataList);
    print("resetData dataList.length= ${dataList.length}");
    setState(() {});
  }

  Future<List<HuxiuNews>> getMoreData() async {
    page++;
    var dio = new Dio();
    Response response = await dio.get(getHuxiuListUrl("huxiu", page));
    HuxiuNewsList bean = HuxiuNewsList(response.data);
    dataList.addAll(bean.data);
    dataList = fliterHuxiuNews(dataList);
    print("getMoreData dataList.length= ${dataList.length}");
    setState(() {});
  }

  /**
   * 筛选出非空的条目
   */
  List<HuxiuNews> fliterHuxiuNews(List<HuxiuNews> dataList) {
    List<HuxiuNews> tempList = [];
    dataList.forEach((huxiuNews) {
      if (huxiuNews.news_id.isNotEmpty) {
        tempList.add(huxiuNews);
      }
    });
    dataList.clear();
    dataList.addAll(tempList);
    return dataList;
  }

  FutureBuilder<List<HuxiuNews>> buildFutureBuilder() {
    return FutureBuilder<List<HuxiuNews>>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        ConnectionState state = snapshot.connectionState;
        switch (state) {
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.none:
            //等待状态
            return Container(
              color: Colors.blue,
            );
          case ConnectionState.done:
            //完成状态
            if (snapshot.hasError) {
              //结果错误
              print("snapshot.hasErrpr: ${snapshot.error}");
              return Container(
                color: Colors.red,
              );
            }
            dataList = snapshot.data;
            dataList = fliterHuxiuNews(dataList);
            return RefreshIndicator(
              key: _refreshIndicaterState,
              child: HuxiuNewsListPage(dataList, scrollController),
              onRefresh: resetData,
            );
            break;
        }
      },
      future: getData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return dataList.length == 0
        ? buildFutureBuilder()
        : RefreshIndicator(
            key: _refreshIndicaterState,
            child: HuxiuNewsListPage(dataList, scrollController),
            onRefresh: resetData,
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

String getHuxiuListUrl(String tag, int page) {
  String url =
      "http://49.234.76.105:80/spider/huxiu/$tag?start=${page * PAGE_COUNT}&end=${page * PAGE_COUNT + PAGE_COUNT - 1}";
  print(url);
  return url;
}
