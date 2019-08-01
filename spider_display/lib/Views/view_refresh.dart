import 'package:flutter/material.dart';
/**
 * created by ksheng
 * on 2019/7/30
 * note 下拉刷新控件
 **/

class RefreshView<T> extends StatefulWidget {
  SliverList child;
  Widget footer;
  RefreshDataCallback refreshDataCallback;
  RefreshDataDragCallback refreshDataDragCallback;
  Future<T> Function() refresh;
  void Function(T) onRefreshSuccess;

  RefreshView({
    @required this.child,
    @required this.footer,
    this.refreshDataCallback,
    this.refreshDataDragCallback,
    @required this.refresh,
    @required this.onRefreshSuccess,
  }) {
    assert(child != null);
    assert(footer != null);
    assert(refresh != null);
//    loadMoreCallback ??= (state) {};
//    loadMoreUpdateCallback ??= (state, percent) {};
  }

  @override
  _RefreshViewState createState() => new _RefreshViewState();
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

enum RefreshResultSate {
  Success,
  Error,
  None,
}

typedef RefreshDataCallback = void Function(RefreshState);
typedef RefreshDataDragCallback = void Function(double);

class _RefreshViewState extends State<RefreshView>
    with AutomaticKeepAliveClientMixin {
  double move = 0.0;
  bool isLoading = false;
  bool isRefresh = false;
  ScrollController scrollController;

  double dragPercent = 0.0;

  double headerHeight = 100.0;

  bool isMoving = false;

  RefreshState state = RefreshState.Normal;

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
    double readyTiggerRange = headerHeight / 10;

    print("pixels: ${pixels.toInt()},headerHeight: ${headerHeight.toInt()}"
        " readyTiggerRange: ${readyTiggerRange.toInt()}");

    if (notication is ScrollStartNotification ||
        notication is ScrollUpdateNotification) {
      if (pixels > headerHeight) {
        state = RefreshState.Normal;
        widget.refreshDataCallback(RefreshState.Normal);
      } else if (pixels <= headerHeight && pixels > readyTiggerRange) {
        state = RefreshState.Update;
        widget.refreshDataCallback(RefreshState.Update);
        dragPercent = (headerHeight - pixels) / headerHeight;
        widget.refreshDataDragCallback(dragPercent);
      } else if (pixels <= readyTiggerRange) {
        //Ready状态
        state = RefreshState.Ready;
        widget.refreshDataCallback(RefreshState.Ready);
        dragPercent = (headerHeight - pixels) / headerHeight;
        widget.refreshDataDragCallback(dragPercent);
      }
    } else if (notication is ScrollEndNotification) {
      //滑动结束
      if (state == RefreshState.Normal) {
        //Normal状态
      } else if (state == RefreshState.Start) {
        //Start状态 显示footer
      } else if (state == RefreshState.Update) {
        //如果是Update状态就需要回弹
        //print("回弹！");
        Future.delayed(Duration(seconds: 0), () {
          scrollController.animateTo(
            headerHeight,
            duration: Duration(milliseconds: 100),
            curve: Curves.linear,
          );
        });
      } else if (state == RefreshState.Ready) {
        setState(() {
          widget.refreshDataCallback(RefreshState.Loading);
        });
        //运行耗时方法
        widget
            .refresh()
            .then((T) {
          widget.refreshDataCallback(RefreshState.Success);
          //成功后500毫秒回弹
          print("接收数据：${T} \n ${DateTime.now()}");

          Future.delayed(Duration(milliseconds: 500)).then((_) {
            print("执行回弹： ${DateTime.now()}");
            scrollController
                .animateTo(
              headerHeight,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            )
                .whenComplete(() {
              //回弹完成时候恢复正常状态
              if (widget.onRefreshSuccess != null) {
                widget.onRefreshSuccess(T);
              }
              if (widget.refreshDataCallback != null) {
                widget.refreshDataCallback(RefreshState.Normal);
              }
              setState(() {
                isLoading = false;
              });
            });
          });
        })
            .whenComplete(() {})
            .catchError((error) {
          widget.refreshDataCallback(RefreshState.Error);
          Future.delayed(Duration(milliseconds: 500)).then((_) {
            print("执行回弹： ${DateTime.now()}");
            scrollController
                .animateTo(
              headerHeight,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            )
                .whenComplete(() {
              if (widget.refreshDataCallback != null) {
                widget.refreshDataCallback(RefreshState.Normal);
              }
              setState(() {
                isLoading = false;
              });
            });
          });
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
        child: widget.footer,
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
