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

enum DragState {
  Normal,
  Start,
  Update,
  Ready,
  Loading,
  Success,
  Error,
}

typedef RefreshDataCallback = void Function(DragState);
typedef RefreshDataDragCallback = void Function(double);

typedef RefreshGetDataFunc<T> = Future<T> Function();
typedef OnRefreshSuccessCallback<T> = void Function(T);

typedef FinsihStateCallBack = void Function(FinishState);

typedef LoadMoreCallback = void Function(DragState);
typedef LoadMoreDragCallback = void Function(double);

typedef LodaMoreGetDataFunc<T> = Future<T> Function();
typedef OnLoadMoreSuccessCallback<T> = void Function(T);

class AutoRefreshView<T> extends StatefulWidget {
  SliverList child;

  bool footerEnable;
  Widget footer;
  LoadMoreCallback loadMoreCallback;
  LoadMoreDragCallback loadMoreUpdateCallback;
  LodaMoreGetDataFunc<T> loadMoreGetDataFunc;
  OnLoadMoreSuccessCallback<T> onLoadMoreSuccessCallback;
  FinsihStateCallBack loadMoreFinsihStateCallBack;

  bool headerEnable;
  Widget header;
  RefreshDataCallback refreshDataCallback;
  RefreshDataDragCallback refreshDataDragCallback;
  RefreshGetDataFunc<T> refreshGetDataFunc;
  OnRefreshSuccessCallback onRefreshSuccessCallback;
  FinsihStateCallBack refreshFinsihStateCallBack;

  List<Widget> buildOtherTopWidgets;

  AutoRefreshView({
    @required this.child,
    @required this.footerEnable,
    this.footer,
    @required this.loadMoreCallback,
    @required this.loadMoreUpdateCallback,
    @required this.loadMoreGetDataFunc,
    @required this.onLoadMoreSuccessCallback,
    @required this.loadMoreFinsihStateCallBack,
    @required this.headerEnable,
    this.header,
    @required this.refreshDataCallback,
    @required this.refreshDataDragCallback,
    @required this.refreshGetDataFunc,
    @required this.onRefreshSuccessCallback,
    @required this.refreshFinsihStateCallBack,
    @required this.buildOtherTopWidgets,
  }) {
    assert(child != null);
    if (footerEnable) {
      assert(footer != null);
      assert(loadMoreCallback != null);
      assert(loadMoreUpdateCallback != null);
      assert(loadMoreGetDataFunc != null);
      assert(onLoadMoreSuccessCallback != null);
      assert(loadMoreFinsihStateCallBack != null);
    }
    if (headerEnable) {
      assert(header != null);
      assert(refreshDataCallback != null);
      assert(refreshDataDragCallback != null);
      assert(refreshGetDataFunc != null);
      assert(onRefreshSuccessCallback != null);
      assert(refreshFinsihStateCallBack != null);
    }
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

  DragState loadMoreState = DragState.Normal;

  //是否加载完成的判断，决定回弹时候的动画是否执行
  FinishState loadMoreFinishState = FinishState.None;

  int cancelBackDuration = 200;
  int finishDelayDuration = 200;

  bool isLoadMoreFinish = false;

  double refreshDragPercent = 0.0;

  double headerHeight = 100.0;

  DragState refreshState = DragState.Normal;

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
    List<Widget> children = [];
    //加载Header
    if (widget.headerEnable) {
      children.add(buildHeader());
    }
    if (widget.buildOtherTopWidgets != null) {
      widget.buildOtherTopWidgets.forEach((widget) {
        children.add(widget);
      });
    }
    children.add(buildBody());
    //加载Footer
    if (widget.footerEnable) {
      children.add(buildFooter());
    }
    return NotificationListener<ScrollNotification>(
      onNotification: buildNotification,
      child: CustomScrollView(
        controller: scrollController,
        slivers: children,
      ),
    );
  }

  bool buildNotification(notication) {
    if (!widget.headerEnable && !widget.footerEnable) {
      return false;
    }

    double pixels = notication.metrics.pixels;
    double curMaxHeight = notication.metrics.maxScrollExtent;

    //设置触发区域为footer的1/10
    double loadMoreReadyRange = (curMaxHeight - normalMaxHeight) / 10;

    //设置触发区域为header的1/10
    double refreshReadyRange = headerHeight / 10;

    if (!isLoadMoreLoading) {
      //在未开启footer的时候获取到标准最大高度
      if (widget.footerEnable) {
        if (widget.loadMoreCallback != null) {
          setState(() {
            widget.loadMoreCallback(DragState.Normal);
          });
        }
      }
      if (pixels < curMaxHeight) {
        normalMaxHeight = notication.metrics.maxScrollExtent;
      }
    }

    if (notication is ScrollStartNotification ||
        notication is ScrollUpdateNotification) {
      if (pixels <= headerHeight && pixels > refreshReadyRange) {
        refreshState = DragState.Update;
        widget.refreshDataCallback(DragState.Update);
        refreshDragPercent = (headerHeight - pixels) / headerHeight;
        widget.refreshDataDragCallback(refreshDragPercent);
      } else if (pixels <= refreshReadyRange) {
        //Ready状态

        refreshState = DragState.Ready;
        widget.refreshDataCallback(DragState.Ready);
        refreshDragPercent = (headerHeight - pixels) / headerHeight;
        widget.refreshDataDragCallback(refreshDragPercent);
      } else if (pixels > headerHeight && pixels < normalMaxHeight) {
        //Normal状态

        refreshState = DragState.Normal;
        widget.refreshDataCallback(DragState.Normal);
        isRefreshFinish = false;

        loadMoreState = DragState.Normal;
        widget.loadMoreCallback(DragState.Normal);
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
        loadMoreState = DragState.Update;
        widget.loadMoreCallback(DragState.Update);
        loadMoreDragPercent =
            (pixels - normalMaxHeight) / (curMaxHeight - normalMaxHeight);
        widget.loadMoreUpdateCallback(loadMoreDragPercent);
      } else if (pixels >= curMaxHeight - loadMoreReadyRange &&
          normalMaxHeight < curMaxHeight) {
        //Ready状态
        isLoadMoreLoading = true;
        loadMoreState = DragState.Ready;
        widget.loadMoreCallback(DragState.Ready);
        loadMoreDragPercent =
            (pixels - normalMaxHeight) / (curMaxHeight - normalMaxHeight);
        widget.loadMoreUpdateCallback(loadMoreDragPercent);
      }
      if (!isLoadMoreFinish) {
        loadMoreFinishState = FinishState.None;
        widget.loadMoreFinsihStateCallBack(loadMoreFinishState);
      }
      if (!isRefreshFinish) {
        refreshFinishState = FinishState.None;
        widget.refreshFinsihStateCallBack(refreshFinishState);
      }
    } else if (notication is ScrollEndNotification) {
      if (widget.headerEnable) {
        //滑动结束
        if (refreshState == DragState.Normal) {
          //Normal状态
          refreshFinishState = FinishState.None;
          widget.refreshFinsihStateCallBack(refreshFinishState);
        } else if (refreshState == DragState.Start) {
          //Start状态 显示footer
          refreshFinishState = FinishState.None;
          widget.refreshFinsihStateCallBack(refreshFinishState);
        } else if (refreshState == DragState.Update) {
          //如果是Update状态就需要回弹
          //print("回弹！");
          Future.delayed(Duration(seconds: 0), () {
            if (scrollController == null) {
              return true;
            }
            scrollController.animateTo(
              headerHeight,
              duration: Duration(milliseconds: cancelBackDuration),
              curve: Curves.linear,
            );
          }).catchError((e) {});
        } else if (refreshState == DragState.Ready) {
          setState(() {
            widget.refreshDataCallback(DragState.Loading);
          });
          //运行耗时方法
          widget
              .refreshGetDataFunc()
              .then((T) {
                widget.refreshDataCallback(DragState.Success);
                refreshFinishState = FinishState.Success;
                widget.refreshFinsihStateCallBack(refreshFinishState);

                isRefreshFinish = true;

                Future.delayed(Duration(milliseconds: finishDelayDuration))
                    .then((_) {
                  print("执行回弹： ${DateTime.now()}");
                  if (scrollController == null) {
                    return true;
                  }
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
                      widget.refreshDataCallback(DragState.Normal);
                    }
                    setState(() {
                      isRefreshFinish = false;
                    });
                  });
                }).catchError((e) {});
              })
              .whenComplete(() {})
              .catchError((error) {
                widget.refreshDataCallback(DragState.Error);
                refreshFinishState = FinishState.Error;
                widget.refreshFinsihStateCallBack(refreshFinishState);

                isRefreshFinish = true;

                Future.delayed(Duration(milliseconds: finishDelayDuration))
                    .then((_) {
                  print("执行回弹： ${DateTime.now()}");
                  if (scrollController == null) {
                    return true;
                  }
                  scrollController
                      .animateTo(
                    headerHeight,
                    duration: Duration(milliseconds: cancelBackDuration),
                    curve: Curves.linear,
                  )
                      .whenComplete(() {
                    if (widget.refreshDataCallback != null) {
                      widget.refreshDataCallback(DragState.Normal);
                    }
                    setState(() {
                      isRefreshFinish = false;
                    });
                  });
                }).catchError((e) {});
              });
        }
      }

      if (widget.footerEnable) {
        if (loadMoreState == DragState.Normal) {
          //Normal状态
          isLoadMoreLoading = false;
          loadMoreFinishState = FinishState.None;
          widget.loadMoreFinsihStateCallBack(loadMoreFinishState);
        } else if (loadMoreState == DragState.Start) {
          //Start状态 显示footer
          isLoadMoreLoading = true;
          loadMoreFinishState = FinishState.None;
          widget.loadMoreFinsihStateCallBack(loadMoreFinishState);
        } else if (loadMoreState == DragState.Update) {
          //如果是Update状态就需要回弹
          //print("回弹！");
          Future.delayed(Duration(seconds: 0), () {
            if (scrollController == null) {
              return true;
            }
            scrollController.animateTo(
              normalMaxHeight,
              duration: Duration(milliseconds: cancelBackDuration),
              curve: Curves.linear,
            );
          }).catchError((e) {});
        } else if (loadMoreState == DragState.Ready) {
          setState(() {
            widget.loadMoreCallback(DragState.Loading);
          });
          //运行耗时方法
          widget
              .loadMoreGetDataFunc()
              .then((T) {
                widget.loadMoreCallback(DragState.Success);
                loadMoreFinishState = FinishState.Success;
                widget.loadMoreFinsihStateCallBack(loadMoreFinishState);

                isLoadMoreFinish = true;

                //成功后500毫秒回弹
//              print("接收数据：${T} \n ${DateTime.now()}");

                Future.delayed(Duration(milliseconds: finishDelayDuration))
                    .then((_) {
//                print("执行回弹： ${DateTime.now()}");
                  if (scrollController == null) {
                    return true;
                  }
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
                      widget.loadMoreCallback(DragState.Normal);
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
                widget.loadMoreCallback(DragState.Error);
                loadMoreFinishState = FinishState.Error;
                widget.loadMoreFinsihStateCallBack(loadMoreFinishState);

                isLoadMoreFinish = true;

                Future.delayed(Duration(milliseconds: finishDelayDuration))
                    .then((_) {
                  print("执行回弹： ${DateTime.now()}");
                  if (scrollController == null) {
                    return true;
                  }
                  scrollController
                      .animateTo(
                    normalMaxHeight,
                    duration: Duration(milliseconds: cancelBackDuration),
                    curve: Curves.linear,
                  )
                      .whenComplete(() {
                    if (widget.loadMoreCallback != null) {
                      widget.loadMoreCallback(DragState.Normal);
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
    scrollController = null;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void doSomeThingDelay(Duration duration, void Function() doSomething) {}
