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

typedef LoadMoreCallback = void Function(LoadMoreState);
typedef LoadMoreDragCallback = void Function(double);

typedef FinsihStateCallBack = void Function(FinishState);
typedef LodaMoreGetDataFunc<T> = Future<T> Function();
typedef OnLoadMoreSuccessCallback<T> = void Function(T);

class PullLoadView<T> extends StatefulWidget {
  SliverList child;
  Widget footer;
  LoadMoreCallback loadMoreCallback;
  LoadMoreDragCallback loadMoreUpdateCallback;
  LodaMoreGetDataFunc<T> loadMoreGetDataFunc;
  OnLoadMoreSuccessCallback<T> onLoadMoreSuccessCallback;
  FinsihStateCallBack finsihStateCallBack;

  PullLoadView({
    @required this.child,
    @required this.footer,
    this.loadMoreCallback,
    this.loadMoreUpdateCallback,
    @required this.loadMoreGetDataFunc,
    @required this.onLoadMoreSuccessCallback,
    @required this.finsihStateCallBack,
  }) {
    assert(child != null);
    assert(footer != null);
    assert(loadMoreGetDataFunc != null);
    assert(finsihStateCallBack != null);
//    loadMoreCallback ??= (state) {};
//    loadMoreUpdateCallback ??= (state, percent) {};
  }

  @override
  _PullLoadViewState createState() => new _PullLoadViewState();
}

class _PullLoadViewState extends State<PullLoadView>
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

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
//    print("build!");
    return NotificationListener<ScrollNotification>(
      onNotification: buildNotification,
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
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
      if (pixels < normalMaxHeight) {
        //Normal状态
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
          pixels < curMaxHeight - readyTiggerRange) {
        //Update状态
        isLoadMoreLoading = true;
        loadMoreState = LoadMoreState.Update;
        widget.loadMoreCallback(LoadMoreState.Update);
        loadMoreDragPercent =
            (pixels - normalMaxHeight) / (curMaxHeight - normalMaxHeight);
        widget.loadMoreUpdateCallback(loadMoreDragPercent);
      } else if (pixels >= curMaxHeight - readyTiggerRange &&
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
    } else if (notication is ScrollEndNotification) {
      //滑动结束
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
        }).catchError((e) {});
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
              }).catchError((e) {});
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
              }).catchError((e) {});
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
