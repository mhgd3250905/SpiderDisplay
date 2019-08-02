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

enum LoadMoreState {
  Normal,
  Start,
  Update,
  Ready,
  Loading,
  Success,
  Error,
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

typedef RefreshGetDataFunc<T> = Future<T> Function();
typedef OnRefreshSuccessCallback<T> = void Function(T);

typedef FinsihStateCallBack = void Function(FinishState);

typedef LoadMoreCallback = void Function(LoadMoreState);
typedef LoadMoreDragCallback = void Function(double);

typedef LodaMoreGetDataFunc<T> = Future<T> Function();
typedef OnLoadMoreSuccessCallback<T> = void Function(T);

class AutoRefreshView<T> extends StatefulWidget {
  SliverList child;
  Widget footer;
  LoadMoreCallback loadMoreCallback;
  LoadMoreDragCallback loadMoreUpdateCallback;
  LodaMoreGetDataFunc<T> loadMoreGetDataFunc;
  OnLoadMoreSuccessCallback<T> onLoadMoreSuccessCallback;
  FinsihStateCallBack finsihStateCallBack;

  Widget header;
  RefreshDataCallback refreshDataCallback;
  RefreshDataDragCallback refreshDataDragCallback;
  RefreshGetDataFunc<T> refreshGetDataFunc;
  OnRefreshSuccessCallback onRefreshSuccessCallback;
  FinsihStateCallBack refreshFinsihStateCallBack;

  AutoRefreshView({
    @required this.child,
    @required this.footer,
    this.loadMoreCallback,
    this.loadMoreUpdateCallback,
    @required this.loadMoreGetDataFunc,
    @required this.onLoadMoreSuccessCallback,
    @required this.finsihStateCallBack,

    @required this.header,
    this.refreshDataCallback,
    this.refreshDataDragCallback,
    @required this.refreshGetDataFunc,
    @required this.onRefreshSuccessCallback,
    @required this.refreshFinsihStateCallBack,
  }) {
    assert(child != null);
    assert(footer != null);
    assert(loadMoreGetDataFunc != null);
    assert(finsihStateCallBack != null);

    assert(header != null);
    assert(refreshGetDataFunc != null);
    assert(refreshFinsihStateCallBack != null);
//    loadMoreCallback ??= (state) {};
//    loadMoreUpdateCallback ??= (state, percent) {};
  }

  @override
  _AutoRefreshViewState createState() => new _AutoRefreshViewState();
}

class _AutoRefreshViewState extends State<AutoRefreshView>
    with AutomaticKeepAliveClientMixin {
  bool isLoadMoreLoading = false;
  ScrollController scrollController;

  double normalMaxHeight = 0.0;
  double loadMoreDragPercent = 0.0;

  LoadMoreState loadMoreState = LoadMoreState.Normal;

  //是否加载完成的判断，决定回弹时候的动画是否执行
  FinishState loadMoreFinishState = FinishState.None;

  int cancelBackDuration = 200;
  int finishDelayDuration = 200;

  bool isLoadMoreFinish = false;

  double refreshDragPercent = 0.0;

  double headerHeight = 100.0;

  RefreshState refreshState = RefreshState.Normal;

  //是否加载完成的判断，决定回弹时候的动画是否执行
  FinishState refreshFinishState = FinishState.None;

  bool isRefreshFinish = false;


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
          buildFooter(),
        ],
      ),
    );
  }

  bool buildNotification(notication) {
    double pixels = notication.metrics.pixels;
    double curMaxHeight = notication.metrics.maxScrollExtent;

    //设置触发区域为footer的1/10
    double loadMoreReadyRange = (curMaxHeight - normalMaxHeight) / 10;

    //设置触发区域为header的1/10
    double refreshReadyRange = headerHeight / 10;

    if (!isLoadMoreLoading) {
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

    if (notication is ScrollStartNotification ||
        notication is ScrollUpdateNotification) {
      if (pixels <= headerHeight && pixels > refreshReadyRange) {

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
      } else if (pixels > headerHeight && pixels < normalMaxHeight) {
        //Normal状态

        refreshState = RefreshState.Normal;
        widget.refreshDataCallback(RefreshState.Normal);
        isRefreshFinish = false;

        loadMoreState = LoadMoreState.Normal;
        widget.loadMoreCallback(LoadMoreState.Normal);
        isLoadMoreLoading = false;
        isLoadMoreFinish = false;
      } else if (pixels >= normalMaxHeight && normalMaxHeight >= curMaxHeight) {
        //开始状态，要加载footer了
        isLoadMoreLoading = true;
        isLoadMoreFinish = false;
      } else if (pixels > normalMaxHeight &&
          normalMaxHeight < curMaxHeight &&
          pixels < curMaxHeight - loadMoreReadyRange) {
        //Update状态
        isLoadMoreLoading = true;
        loadMoreState = LoadMoreState.Update;
        widget.loadMoreCallback(LoadMoreState.Update);
        loadMoreDragPercent =
            (pixels - normalMaxHeight) / (curMaxHeight - normalMaxHeight);
        widget.loadMoreUpdateCallback(loadMoreDragPercent);
      } else if (pixels >= curMaxHeight - loadMoreReadyRange &&
          normalMaxHeight < curMaxHeight) {
        //Ready状态
        isLoadMoreLoading = true;
        loadMoreState = LoadMoreState.Ready;
        widget.loadMoreCallback(LoadMoreState.Ready);
        loadMoreDragPercent =
            (pixels - normalMaxHeight) / (curMaxHeight - normalMaxHeight);
        widget.loadMoreUpdateCallback(loadMoreDragPercent);
      }
      if (!isLoadMoreFinish) {
        loadMoreFinishState = FinishState.None;
        widget.finsihStateCallBack(loadMoreFinishState);
      }
      if (!isRefreshFinish) {
        refreshFinishState = FinishState.None;
        widget.refreshFinsihStateCallBack(refreshFinishState);
      }
    } else if (notication is ScrollEndNotification) {
      //滑动结束
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
        });
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
          });
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
          });
        });
      }

      if (loadMoreState == LoadMoreState.Normal) {
        //Normal状态
        isLoadMoreLoading = false;
        loadMoreFinishState = FinishState.None;
        widget.finsihStateCallBack(loadMoreFinishState);
      } else if (loadMoreState == LoadMoreState.Start) {
        //Start状态 显示footer
        isLoadMoreLoading = true;
        loadMoreFinishState = FinishState.None;
        widget.finsihStateCallBack(loadMoreFinishState);
      } else if (loadMoreState == LoadMoreState.Update) {
        //如果是Update状态就需要回弹
        //print("回弹！");
        Future.delayed(Duration(seconds: 0), () {
          scrollController.animateTo(
            normalMaxHeight,
            duration: Duration(milliseconds: cancelBackDuration),
            curve: Curves.linear,
          );
        });
      } else if (loadMoreState == LoadMoreState.Ready) {
        setState(() {
          widget.loadMoreCallback(LoadMoreState.Loading);
        });
        //运行耗时方法
        widget
            .loadMoreGetDataFunc()
            .then((T) {
          widget.loadMoreCallback(LoadMoreState.Success);
          loadMoreFinishState = FinishState.Success;
          widget.finsihStateCallBack(loadMoreFinishState);

          isLoadMoreFinish = true;

          //成功后500毫秒回弹
//              print("接收数据：${T} \n ${DateTime.now()}");

          Future.delayed(Duration(milliseconds: finishDelayDuration))
              .then((_) {
//                print("执行回弹： ${DateTime.now()}");
            scrollController
                .animateTo(
              normalMaxHeight,
              duration: Duration(milliseconds: cancelBackDuration),
              curve: Curves.linear,
            )
                .whenComplete(() {
              //回弹完成时候恢复正常状态
              if (widget.onLoadMoreSuccessCallback != null) {
                widget.onLoadMoreSuccessCallback(T);
              }
              if (widget.loadMoreCallback != null) {
                widget.loadMoreCallback(LoadMoreState.Normal);
              }
              setState(() {
                isLoadMoreLoading = false;
                isLoadMoreFinish = false;
              });
            });
          });
        })
            .whenComplete(() {})
            .catchError((error) {
          widget.loadMoreCallback(LoadMoreState.Error);
          loadMoreFinishState = FinishState.Error;
          widget.finsihStateCallBack(loadMoreFinishState);

          isLoadMoreFinish = true;

          Future.delayed(Duration(milliseconds: finishDelayDuration))
              .then((_) {
            print("执行回弹： ${DateTime.now()}");
            scrollController
                .animateTo(
              normalMaxHeight,
              duration: Duration(milliseconds: cancelBackDuration),
              curve: Curves.linear,
            )
                .whenComplete(() {
              if (widget.loadMoreCallback != null) {
                widget.loadMoreCallback(LoadMoreState.Normal);
              }
              setState(() {
                isLoadMoreLoading = false;
                isLoadMoreFinish = false;
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

  SliverToBoxAdapter buildFooter() {
    return SliverToBoxAdapter(
      child: Visibility(
        child: widget.footer,
        visible: isLoadMoreLoading,
      ),
    );
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
    print("dispose!");
    scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void doSomeThingDelay(Duration duration, void Function() doSomething) {}
