import 'package:flutter/material.dart';
/**
 * created by ksheng
 * on 2019/7/30
 * note 下拉刷新控件
 **/

enum FinishState {
  Success,
  Error,
  None,
}

enum RefreshState {
  Normal,
  Start,
  Update,
  Ready,
  Loading,
  Success,
  Error,
}

typedef RefreshDataCallback = void Function(RefreshState);
typedef RefreshDataDragCallback = void Function(double);

typedef FinsihStateCallBack = void Function(FinishState);
typedef RefreshGetDataFunc<T> = Future<T> Function();
typedef OnRefreshSuccessCallback<T> = void Function(T);

class RefreshView<T> extends StatefulWidget {
  SliverList child;
  Widget header;
  RefreshDataCallback refreshDataCallback;
  RefreshDataDragCallback refreshDataDragCallback;
  RefreshGetDataFunc<T> refreshGetDataFunc;
  OnRefreshSuccessCallback onRefreshSuccessCallback;
  FinsihStateCallBack refreshFinsihStateCallBack;

  RefreshView({
    @required this.child,
    @required this.header,
    this.refreshDataCallback,
    this.refreshDataDragCallback,
    @required this.refreshGetDataFunc,
    @required this.onRefreshSuccessCallback,
    @required this.refreshFinsihStateCallBack,
  }) {
    assert(child != null);
    assert(header != null);
    assert(refreshGetDataFunc != null);
    assert(refreshFinsihStateCallBack != null);
//    loadMoreCallback ??= (state) {};
//    loadMoreUpdateCallback ??= (state, percent) {};
  }

  @override
  _RefreshViewState createState() => new _RefreshViewState();
}

class _RefreshViewState extends State<RefreshView>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController;

  double refreshDragPercent = 0.0;

  double headerHeight = 100.0;

  RefreshState refreshState = RefreshState.Normal;

  //是否加载完成的判断，决定回弹时候的动画是否执行
  FinishState refreshFinishState = FinishState.None;

  bool isRefreshFinish = false;

  int cancelBackDuration = 200;
  int finishDelayDuration = 200;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 100.0);
  }

  @override
  Widget build(BuildContext context) {
//    print("build!");
    return NotificationListener<ScrollNotification>(
      onNotification: buildNotification,
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          buildHeader(),
          buildBody(),
        ],
      ),
    );
  }

  bool buildNotification(notication) {
    double pixels = notication.metrics.pixels;

    //设置触发区域为header的1/10
    double refreshReadyRange = headerHeight / 10;

    if (notication is ScrollStartNotification ||
        notication is ScrollUpdateNotification) {
      if (pixels > headerHeight) {
        refreshState = RefreshState.Normal;
        widget.refreshDataCallback(RefreshState.Normal);
        isRefreshFinish = false;
      } else if (pixels <= headerHeight && pixels > refreshReadyRange) {
        refreshState = RefreshState.Update;
        widget.refreshDataCallback(RefreshState.Update);
        refreshDragPercent = (headerHeight - pixels) / headerHeight;
        widget.refreshDataDragCallback(refreshDragPercent);
      } else if (pixels <= refreshReadyRange) {
        //Ready状态
        refreshState = RefreshState.Ready;
        widget.refreshDataCallback(RefreshState.Ready);
        refreshDragPercent = (headerHeight - pixels) / headerHeight;
        widget.refreshDataDragCallback(refreshDragPercent);
      }
      if (!isRefreshFinish) {
        refreshFinishState = FinishState.None;
        widget.refreshFinsihStateCallBack(refreshFinishState);
      }
    } else if (notication is ScrollEndNotification) {
      //滑动结束
      if (refreshState == RefreshState.Normal) {
        //Normal状态
        refreshFinishState = FinishState.None;
        widget.refreshFinsihStateCallBack(refreshFinishState);
      } else if (refreshState == RefreshState.Start) {
        //Start状态 显示footer
        refreshFinishState = FinishState.None;
        widget.refreshFinsihStateCallBack(refreshFinishState);
      } else if (refreshState == RefreshState.Update) {
        //如果是Update状态就需要回弹
        //print("回弹！");
        Future.delayed(Duration(seconds: 0), () {
          scrollController.animateTo(
            headerHeight,
            duration: Duration(milliseconds: cancelBackDuration),
            curve: Curves.linear,
          );
        }).catchError((e) {});
      } else if (refreshState == RefreshState.Ready) {
        setState(() {
          widget.refreshDataCallback(RefreshState.Loading);
        });
        //运行耗时方法
        widget
            .refreshGetDataFunc()
            .then((T) {
              widget.refreshDataCallback(RefreshState.Success);
              refreshFinishState = FinishState.Success;
              widget.refreshFinsihStateCallBack(refreshFinishState);

              isRefreshFinish = true;

              Future.delayed(Duration(milliseconds: finishDelayDuration))
                  .then((_) {
                print("执行回弹： ${DateTime.now()}");
                scrollController
                    .animateTo(
                  headerHeight,
                  duration: Duration(milliseconds: cancelBackDuration),
                  curve: Curves.linear,
                )
                    .whenComplete(() {
                  //回弹完成时候恢复正常状态
                  if (widget.onRefreshSuccessCallback != null) {
                    widget.onRefreshSuccessCallback(T);
                  }
                  if (widget.refreshDataCallback != null) {
                    widget.refreshDataCallback(RefreshState.Normal);
                  }
                  setState(() {
                    isRefreshFinish = false;
                  });
                });
              }).catchError((e) {});
            })
            .whenComplete(() {})
            .catchError((error) {
              widget.refreshDataCallback(RefreshState.Error);
              refreshFinishState = FinishState.Error;
              widget.refreshFinsihStateCallBack(refreshFinishState);

              isRefreshFinish = true;

              Future.delayed(Duration(milliseconds: finishDelayDuration))
                  .then((_) {
                print("执行回弹： ${DateTime.now()}");
                scrollController
                    .animateTo(
                  headerHeight,
                  duration: Duration(milliseconds: cancelBackDuration),
                  curve: Curves.linear,
                )
                    .whenComplete(() {
                  if (widget.refreshDataCallback != null) {
                    widget.refreshDataCallback(RefreshState.Normal);
                  }
                  setState(() {
                    isRefreshFinish = false;
                  });
                });
              }).catchError((e) {});
            });
      }
    }
  }

  Widget buildBody() {
    return widget.child;
  }

  SliverToBoxAdapter buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        child: widget.header,
        height: headerHeight,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void doSomeThingDelay(Duration duration, void Function() doSomething) {}
