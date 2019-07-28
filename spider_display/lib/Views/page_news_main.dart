import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Views/page_news_list.dart';

const int PAGE_COUNT = 10;

Dio dio;

class NewsMainPage extends StatefulWidget {
  String tag;

  NewsMainPage(this.tag);

  @override
  _NewsMainPageState createState() => new _NewsMainPageState();
}

class _NewsMainPageState extends State<NewsMainPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = new ScrollController();
  GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();
  List<NewsBean> dataList = [];
  int page = 0;

  @override
  void initState() {
    super.initState();
    dio = new Dio();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }

  Future<List<NewsBean>> getData() async {
    Response response = await dio.get(getNewsListUrl(widget.tag, page));
    NewsListBean bean =
        NewsListBean(response.data.toString().replaceAll("\n", ""));
    print("getData dataList.length= ${dataList.length}");
    return bean.data;
  }

  Future<List<NewsBean>> resetData() async {
    page = 0;
    Response response = await dio.get(getNewsListUrl(widget.tag, page));
    NewsListBean bean =
        NewsListBean(response.data.toString().replaceAll("\n", ""));
    dataList.clear();
    dataList.addAll(bean.data);
    dataList = fliterNews(dataList);
    print("resetData dataList.length= ${dataList.length}");
    setState(() {});
  }

  Future<List<NewsBean>> getMoreData() async {
    page++;
    Response response = await dio.get(getNewsListUrl(widget.tag, page));
    NewsListBean bean =
        NewsListBean(response.data.toString().replaceAll("\n", ""));
    dataList.addAll(bean.data);
    dataList = fliterNews(dataList);
    print("getMoreData dataList.length= ${dataList.length}");
    setState(() {});
  }

  /**
   * 筛选出非空的条目
   */
  List<NewsBean> fliterNews(List<NewsBean> dataList) {
    List<NewsBean> tempList = [];
    dataList.forEach((huxiuNews) {
      if (huxiuNews.newsId.isNotEmpty) {
        tempList.add(huxiuNews);
      }
    });
    dataList.clear();
    dataList.addAll(tempList);
    return dataList;
  }

  FutureBuilder<List<NewsBean>> buildFutureBuilder() {
    return FutureBuilder<List<NewsBean>>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        ConnectionState state = snapshot.connectionState;
        switch (state) {
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.none:
            //等待状态
            return RefreshIndicator(
              key: _refreshIndicaterState,
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    backgroundColor: Colors.blue,
                    // value: 0.2,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.black87),
                  ),
                ),
              ),
              onRefresh: resetData,
            );
          case ConnectionState.done:
            //完成状态
            if (snapshot.hasError) {
              //结果错误
              print("snapshot.hasErrpr: ${snapshot.error}");
              return RefreshIndicator(
                key: _refreshIndicaterState,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    "连接错误...",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onRefresh: resetData,
              );
            }
            dataList = snapshot.data;
            dataList = fliterNews(dataList);
            return RefreshIndicator(
              key: _refreshIndicaterState,
              child: NewsListPage(widget.tag, dataList, scrollController),
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
            child: NewsListPage(widget.tag, dataList, scrollController),
            onRefresh: resetData,
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

String getNewsListUrl(String tag, int page) {
  String url =
      "http://49.234.76.105:80/spider/news/$tag?start=${page * PAGE_COUNT}&end=${page * PAGE_COUNT + PAGE_COUNT - 1}";
  print(url);
  return url;
}
