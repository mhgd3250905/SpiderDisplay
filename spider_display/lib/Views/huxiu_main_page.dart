import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:spider_display/Modle/huxiu_modle.dart';
import 'package:spider_display/Views/huxiu_list_page.dart';

const int PAGE_COUNT = 10;

class HuxiuMainPage extends StatefulWidget {
  ScrollController scrollController = new ScrollController();
  GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();
  List<HuxiuNews> dataList = [];
  int page = 0;

  @override
  _HuxiuMainPageState createState() => new _HuxiuMainPageState();
}

class _HuxiuMainPageState extends State<HuxiuMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  Future<List<HuxiuNews>> getData() async {
    var dio = new Dio();
    Response response = await dio.get(getHuxiuListUrl("huxiu", widget.page));
    HuxiuNewsList bean = HuxiuNewsList(response.data);
    print("getData dataList.length= ${widget.dataList.length}");
    return bean.data;
  }

  Future<List<HuxiuNews>> resetData() async {
    widget.page = 0;
    var dio = new Dio();
    Response response = await dio.get(getHuxiuListUrl("huxiu", widget.page));
    HuxiuNewsList bean = HuxiuNewsList(response.data);
    widget.dataList.clear();
    widget.dataList.addAll(bean.data);
    print("resetData dataList.length= ${widget.dataList.length}");
    setState(() {});
  }

  Future<List<HuxiuNews>> getMoreData() async {
    widget.page++;
    var dio = new Dio();
    Response response = await dio.get(getHuxiuListUrl("huxiu", widget.page));
    HuxiuNewsList bean = HuxiuNewsList(response.data);
    widget.dataList.addAll(bean.data);
    print("getMoreData dataList.length= ${widget.dataList.length}");
    setState(() {});
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
            widget.dataList = snapshot.data;
            return RefreshIndicator(
              key: widget._refreshIndicaterState,
              child:
                  HuxiuNewsListPage(widget.dataList, widget.scrollController),
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
    return widget.dataList.length == 0
        ? buildFutureBuilder()
        : RefreshIndicator(
            key: widget._refreshIndicaterState,
            child: HuxiuNewsListPage(widget.dataList, widget.scrollController),
            onRefresh: resetData,
          );
    ;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

String getHuxiuListUrl(String tag, int page) {
  String url =
      "http://49.234.76.105:80/spider/bookset/$tag?start=${page * PAGE_COUNT}&end=${page * PAGE_COUNT + PAGE_COUNT - 1}";
  print(url);
  return url;
}
