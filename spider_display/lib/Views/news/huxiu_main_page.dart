import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/news/view_auto_refresh.dart';
import 'package:spider_display/Views/news/view_auto_refresh_list.dart';
import 'package:spider_display/Views/news/view_chule_item.dart';
import 'package:spider_display/Views/news/view_huxiu_item.dart';

import 'huxiu_detail_page.dart';
import 'huxiu_list_page.dart';

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

  FutureBuilder<List<NewsBean>> futureBuilder;

  @override
  void initState() {
    super.initState();
    dio = new Dio();

    futureBuilder = buildFutureBuilder();
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

  void setDataList(list) {
    setState(() {
      dataList = list;
    });
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
                  child: GestureDetector(
                    child: Text(
                      "连接错误...",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
                onRefresh: resetData,
              );
            }
            dataList.clear();
            dataList = fliterNews(snapshot.data);
            return buildNewsList();
//            return RefreshIndicator(
//              key: _refreshIndicaterState,
//              child: buildNewsList(),
//              onRefresh: resetData,
//            );
            break;
        }
      },
      future: getData(),
    );
  }

  /**
   * 构建列表ItemView
   */
  Widget buildNewsListItemView(NewsBean huxiuNews, int pos) {
    switch (widget.tag) {
      case TAG_HUXIU:
        return HuxiuNewsItemView(huxiuNews, pos);
      case TAG_CHULE:
        return ChuleItemView(huxiuNews, pos);
      default:
        return ChuleItemView(huxiuNews, pos);
    }
  }

  Widget buildNewsList() {
    return Container(
        color: Colors.white,
        child: AutoRefreshListView<List<NewsBean>>(
          childCount: dataList.length,
          builder: (context, i) {
            return buildNewsItem(i, context);
          },
          footerEnable: true,
          headerEnable: true,
          loadMoreDataFunc: getMoreData,
          loadMoreSuccessCallback: setDataList,
          refreshDataFunc: refreshData,
          refreshSuccessCallback: setRefreshDataList,
          buildHeader: buildHeader,
        ));
  }

  Future<List<NewsBean>> refreshData() async {
    page = 0;
    Response response = await dio.get(getNewsListUrl(widget.tag, page));
    NewsListBean bean =
        NewsListBean(response.data.toString().replaceAll("\n", ""));
    await Future.delayed(Duration(seconds: 3), () {
      return bean.data;
    }).catchError((e) {});
    return bean.data;
  }

  void setRefreshDataList(list) {
    setState(() {
      dataList = list;
    });
  }

  Future<List<NewsBean>> getMoreData() async {
    page++;
    Response response = await dio.get(getNewsListUrl(widget.tag, page));
    NewsListBean bean =
        NewsListBean(response.data.toString().replaceAll("\n", ""));
    List<NewsBean> tempList = dataList;
    tempList.addAll(bean.data);
    tempList = fliterNews(dataList);
    print("getMoreData dataList.length= ${dataList.length}");
    return tempList;
  }

  void setLoadMoreDataList(list) {
    setState(() {
      dataList = list;
    });
  }

  Container buildNewsItem(int i, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
//        borderRadius: BorderRadius.circular(3.0),
//        boxShadow: <BoxShadow>[
//          BoxShadow(
//            color: Colors.grey[300],
//            offset: Offset(2.0, 2.0),
//            blurRadius: 2.0,
//          ),
//          BoxShadow(
//            color: Colors.grey[300],
//            offset: Offset(2.0, 0.0),
//            blurRadius: 2.0,
//          )
//        ],
      ),
      margin:
          i == 0 ? const EdgeInsets.all(0.0) : const EdgeInsets.only(top: 1.0),
      child: Material(
        child: Ink(
          child: InkWell(
            child: buildNewsListItemView(dataList[i], i),
            onTap: () {
              NavigatorRouterUtils.pushToPage(context,
                  HuxiuDetailPage(dataList[i], "${widget.tag}_detail", i));
            },
          ),
        ),
      ),
    );
  }

  Future<List<NewsBean>> loadMore() async {
    print("loadMore: ${DateTime.now()}");
    await Future.delayed(Duration(seconds: 3), () {
      return dataList;
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return dataList.length == 0 ? futureBuilder : buildNewsList();
//        : RefreshIndicator(
//            key: _refreshIndicaterState,
//            child: buildNewsList(),
//            onRefresh: resetData,
//          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget buildHeader(DragState state, double dragPercent, double loadingPercent,
      FinishState finishState) {
//    print(
//        "refreshState: ${state},FinishState: ${finishState},dragPercent: ${dragPercent},loadingPercent: ${loadingPercent}");

    IconData iconData = Icons.refresh;
    double angle = 0.0;
    String text = "下拉刷新...";

    if (finishState != FinishState.None) {
      iconData = finishState == FinishState.Success ? Icons.done : Icons.error;
    } else {
      if (state == DragState.Normal ||
          state == DragState.Update ||
          state == DragState.Ready ||
          state == DragState.Loading) {
        iconData = Icons.refresh;
      } else if (state == DragState.Success) {
        iconData = Icons.done;
      } else if (state == DragState.Error) {
        iconData = Icons.error;
      }
    }

    if (finishState == FinishState.None) {
      if (state == DragState.Update || state == DragState.Ready) {
        angle = 4 * pi * dragPercent;
      } else if (state == DragState.Loading) {
        angle = 4 * pi * (dragPercent + loadingPercent);
      } else {
        angle = 0.0;
      }
    }

    if (finishState != FinishState.None) {
      text = finishState == FinishState.Success ? "刷新完成！" : "出现错误！";
    } else {
      if (state == DragState.Normal || state == DragState.Update) {
        text = "下拉刷新...";
      } else if (state == DragState.Ready) {
        text = "松开刷新...";
      } else if (state == DragState.Loading) {
        text = "正在刷新...";
      } else if (state == DragState.Success) {
        text = "刷新完成！";
      } else if (state == DragState.Error) {
        text = "出现错误！";
      }
    }

//    print("angle: ${angle}, text: ${text}");

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Transform.scale(
        scale: dragPercent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5.0),
              child: Transform.rotate(
                angle: angle,
                child: AnimatedSwitcher(
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  transitionBuilder: (child, anim) {
                    return ScaleTransition(
                      scale: anim,
                      child: child,
                    );
                  },
                  child: Icon(
                    iconData,
                    key: ValueKey(iconData),
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getNewsListUrl(String tag, int page) {
  String url =
      "http://49.234.76.105:80/spider/news/$tag?start=${page * PAGE_COUNT}&end=${page * PAGE_COUNT + PAGE_COUNT - 1}";
  print(url);
  return url;
}
