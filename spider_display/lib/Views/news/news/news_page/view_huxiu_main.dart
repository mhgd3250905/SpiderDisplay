import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/news/huxiu_detail_page.dart';
import 'package:spider_display/Views/news/huxiu_list_page.dart';
import 'package:spider_display/Views/news/news/news_page/presenter_news.dart';
import 'package:spider_display/Views/news/view_chule_item.dart';
import 'package:spider_display/Views/news/view_huxiu_item.dart';

import '../../view_auto_refresh.dart';
import '../../view_auto_refresh_list.dart';
import 'i_news_view.dart';

const int PAGE_COUNT = 10;

Dio dio;

class NewsMainPage extends StatefulWidget {
  String tag;

  NewsMainPage(this.tag);

  @override
  _NewsMainPageState createState() => new _NewsMainPageState();
}

class _NewsMainPageState extends State<NewsMainPage>
    with AutomaticKeepAliveClientMixin
    implements INewsView<NewsListBean> {
  ScrollController scrollController = new ScrollController();
  GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();
  List<NewsBean> dataList = [];
  int page = 0;

  NewsPresenter presenter;

  Widget content;

  @override
  void initState() {
    super.initState();

    print("initState: ${widget.tag}");

    dio = new Dio();

    content = getWaitingView();

    presenter = new NewsPresenter();
    presenter.attach(this);
    presenter.showData(getNewsListUrl(widget.tag, page));
  }

  @override
  void dispose() {
    dio.clear();
    super.dispose();
  }

  Future<List<NewsBean>> resetData() async {
    page = 0;
    Response response = await dio.get(getNewsListUrl(widget.tag, page));
    NewsListBean bean =
        NewsListBean(response.data.toString().replaceAll("\n", ""));

    setState(() {
      dataList.clear();
      dataList.addAll(bean.data);
      dataList = fliterNews(dataList);
      print("resetData dataList.length= ${dataList.length}");
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
          loadMoreSuccessCallback: presenter.setLoadMoreDataList,
          refreshDataFunc: refreshData,
          refreshSuccessCallback: presenter.setRefreshDataList,
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

  Container buildNewsItem(int i, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(2.0, 2.0),
            blurRadius: 2.0,
          ),
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(2.0, 0.0),
            blurRadius: 2.0,
          )
        ],
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
    return content;
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


  @override
  void loadDataFailed() {
    content = getFailedView();
    setState(() {});
  }

  @override
  void loadDataSuccess(NewsListBean bean) {
    setState(() {
      dataList.clear();
      dataList.addAll(bean.data);
      content = getSuccessView();
    });
  }

  @override
  void loadDataWaiting() {
    content = getWaitingView();
    setState(() {});
  }

  Widget getWaitingView() {
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87),
          ),
        ),
      ),
      onRefresh: resetData,
    );
  }

  Widget getSuccessView() {
    print(getSuccessView);
    return buildNewsList();
  }

  Widget getFailedView() {
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

  @override
  void setLoadMoreDataList(list) {
    print("setState setLoadMoreDataList");
    setState(() {
      dataList = list;
      content = getSuccessView();
    });
  }

  @override
  void setRefreshDataList(list) {
    print("setState setRefreshDataList");
    setState(() {
      dataList = list;
      content = getSuccessView();
    });
  }
}

String getNewsListUrl(String tag, int page) {
  String url =
      "http://49.234.76.105:80/spider/news/$tag?start=${page * PAGE_COUNT}&end=${page * PAGE_COUNT + PAGE_COUNT - 1}";
  print(url);
  return url;
}
