import 'package:flutter/material.dart';
import 'package:spider_display/Views/view_refresh.dart';
/**
 * created by ksheng
 * on 2019/7/30
 * note 下拉刷新控件
 **/

enum RefreshState {
  Normal,
  Start,
  Update,
  Ready,
  Loading,
  Success,
  Error,
}

enum RefreshResultState {
  Success,
  Error,
  None,
}

enum LoadMoreState {
  Normal,
  Start,
  Update,
  Ready,
  Loading,
  Success,
  Error,
}

enum LoadResultSate {
  Success,
  Error,
  None,
}

class RefreshLoadMoreView<T> extends StatefulWidget {
  SliverList child;

  Widget footer;
  LoadMoreCallback loadMoreCallback;
  LoadMoreDragCallback loadMoreUpdateCallback;
  Future<T> Function() loadMore;
  void Function(T) onLoadMoreSuccess;

  Widget header;
  RefreshDataCallback refreshDataCallback;
  RefreshDataDragCallback refreshDataDragCallback;
  Future<T> Function() refresh;
  void Function(T) onRefreshSuccess;

  RefreshLoadMoreView({
    @required this.child,
    @required this.footer,
    this.loadMoreCallback,
    this.loadMoreUpdateCallback,
    @required this.loadMore,
    @required this.onLoadMoreSuccess,
    @required this.header,
    this.refreshDataCallback,
    this.refreshDataDragCallback,
    @required this.refresh,
    @required this.onRefreshSuccess,
  }) {
    assert(child != null);
    assert(footer != null);
    assert(loadMore != null);
    assert(onLoadMoreSuccess != null);
    assert(header != null);
    assert(refresh != null);
    assert(onRefreshSuccess != null);
  }

  @override
  _RefreshLoadMoreViewState createState() => new _RefreshLoadMoreViewState();
}

typedef LoadMoreCallback = void Function(LoadMoreState);
typedef LoadMoreDragCallback = void Function(double);

typedef RefreshDataCallback = void Function(RefreshState);
typedef RefreshDataDragCallback = void Function(double);

class _RefreshLoadMoreViewState extends State<RefreshLoadMoreView>
    with AutomaticKeepAliveClientMixin {
  double move = 0.0;
  bool isLoading = false;
  bool isRefresh = false;
  ScrollController scrollController;

  double normalMaxHeight = 0.0;
  double dragPercent = 0.0;

  bool isMoving = false;

  double headerHeight = 100.0;

  RefreshState refreshState = RefreshState.Normal;

  LoadMoreState loadMoreState = LoadMoreState.Normal;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: headerHeight);
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
          buildFooter(),
        ],
      ),
    );
  }

  bool buildNotification(notication) {
    double pixels = notication.metrics.pixels;
    double curMaxHeight = notication.metrics.maxScrollExtent;

    //设置触发区域为footer的1/10
    double readyTiggerRange = (curMaxHeight - normalMaxHeight) / 10;

//    print(
//        "pixels: ${pixels.toInt()}, normalH: ${normalMaxHeight.toInt()}, curMaxH: ${curMaxHeight.toInt()},"
//        " readyTiggerRange: ${readyTiggerRange.toInt()}");

    bool isRefresh = false;

    if (pixels < headerHeight + 100) {
      isRefresh = true;
      //设置触发区域为header的1/10
      readyTiggerRange = headerHeight / 10;
    } else {
      isRefresh = false;
    }

    if (!isRefresh) {
      if (!isLoading) {
        //在未开启footer的时候获取到标准最大高度
        if (widget.loadMoreCallback != null) {
          setState(() {
            widget.loadMoreCallback(LoadMoreState.Normal);
          });
        }
        if (pixels < curMaxHeight) {
          normalMaxHeight = notication.metrics.maxScrollExtent;
        }
      }
    }

    if (notication is ScrollStartNotification ||
        notication is ScrollUpdateNotification) {
      //滑动开始的时候
      if (isRefresh) {
        if (pixels > headerHeight) {
          refreshState = RefreshState.Normal;
          widget.refreshDataCallback(RefreshState.Normal);
        } else if (pixels <= headerHeight && pixels > readyTiggerRange) {
          refreshState = RefreshState.Update;
          widget.refreshDataCallback(RefreshState.Update);
          dragPercent = (headerHeight - pixels) / headerHeight;
          widget.refreshDataDragCallback(dragPercent);
        } else if (pixels <= readyTiggerRange) {
          //Ready状态
          refreshState = RefreshState.Ready;
          widget.refreshDataCallback(RefreshState.Ready);
          dragPercent = (headerHeight - pixels) / headerHeight;
          widget.refreshDataDragCallback(dragPercent);
        }
      } else {
        if (pixels < normalMaxHeight) {
          //Normal状态
//
          loadMoreState = LoadMoreState.Normal;
          widget.loadMoreCallback(LoadMoreState.Normal);
          isLoading = false;
        } else if (pixels >= normalMaxHeight &&
            normalMaxHeight >= curMaxHeight) {
          //开始状态，要加载footer了
          isLoading = true;
        } else if (pixels > normalMaxHeight &&
            normalMaxHeight < curMaxHeight &&
            pixels < curMaxHeight - readyTiggerRange) {
          //Update状态
          isLoading = true;
          loadMoreState = LoadMoreState.Update;
          widget.loadMoreCallback(LoadMoreState.Update);
          dragPercent =
              (pixels - normalMaxHeight) / (curMaxHeight - normalMaxHeight);
          widget.loadMoreUpdateCallback(dragPercent);
        } else if (pixels >= curMaxHeight - readyTiggerRange &&
            normalMaxHeight < curMaxHeight) {
          //Ready状态
          isLoading = true;
          loadMoreState = LoadMoreState.Ready;
          widget.loadMoreCallback(LoadMoreState.Ready);
          dragPercent =
              (pixels - normalMaxHeight) / (curMaxHeight - normalMaxHeight);
          widget.loadMoreUpdateCallback(dragPercent);
        }
      }
    } else if (notication is ScrollEndNotification) {
      if (isRefresh) {
        //滑动结束
        if (refreshState == RefreshState.Normal) {
          //Normal状态
//        isLoading = false;
        } else if (refreshState == RefreshState.Start) {
          //Start状态 显示footer
//        isLoading = true;
        } else if (refreshState == RefreshState.Update) {
          //如果是Update状态就需要回弹
          //print("回弹！");
          Future.delayed(Duration(seconds: 0), () {
            scrollController.animateTo(
              headerHeight,
              duration: Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          });
        } else if (refreshState == RefreshState.Ready) {
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
//              setState(() {
//                isLoading = false;
//              });
                  });
                });
              });
        }
      } else {
        if (loadMoreState == LoadMoreState.Normal) {
          //Normal状态
          isLoading = false;
        } else if (loadMoreState == LoadMoreState.Start) {
          //Start状态 显示footer
          isLoading = true;
        } else if (loadMoreState == LoadMoreState.Update) {
          //如果是Update状态就需要回弹
          //print("回弹！");
          Future.delayed(Duration(seconds: 0), () {
            scrollController.animateTo(
              normalMaxHeight,
              duration: Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          });
        } else if (loadMoreState == LoadMoreState.Ready) {
          setState(() {
            widget.loadMoreCallback(LoadMoreState.Loading);
          });
          //运行耗时方法
          widget
              .loadMore()
              .then((T) {
                widget.loadMoreCallback(LoadMoreState.Success);
                //成功后500毫秒回弹
                print("接收数据：${T} \n ${DateTime.now()}");

                Future.delayed(Duration(milliseconds: 500)).then((_) {
                  print("执行回弹： ${DateTime.now()}");
                  scrollController
                      .animateTo(
                    normalMaxHeight,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear,
                  )
                      .whenComplete(() {
                    //回弹完成时候恢复正常状态
                    if (widget.onLoadMoreSuccess != null) {
                      widget.onLoadMoreSuccess(T);
                    }
                    if (widget.loadMoreCallback != null) {
                      widget.loadMoreCallback(LoadMoreState.Normal);
                    }
                    setState(() {
                      isLoading = false;
                    });
                  });
                });
              })
              .whenComplete(() {})
              .catchError((error) {
                widget.loadMoreCallback(LoadMoreState.Error);
                Future.delayed(Duration(milliseconds: 500)).then((_) {
                  print("执行回弹： ${DateTime.now()}");
                  scrollController
                      .animateTo(
                    normalMaxHeight,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear,
                  )
                      .whenComplete(() {
                    if (widget.loadMoreCallback != null) {
                      widget.loadMoreCallback(LoadMoreState.Normal);
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

  SliverToBoxAdapter buildFooter() {
    return SliverToBoxAdapter(
      child: Visibility(
        child: widget.footer,
        visible: isLoading,
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
