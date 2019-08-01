import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Views/view_refresh_loadmore.dart';

/**
 * created by
 * on 2019/7/31
 * note
 **/
typedef FooterBuilder = Widget Function(
    LoadMoreState state, double dragPercent, double loadingPercent);

typedef HeaderBuilder = Widget Function(
    RefreshState state, double dragPercent, double loadingPercent);

typedef LoadMoreSuccessCallBack<T> = void Function(T);
typedef LoadMoreDataFunc<T> = Future<T> Function();

typedef RefreshDataCallback = void Function(RefreshState);
typedef RefreshDataDragCallback = void Function(double);

typedef RefreshSuccessCallBack<T> = void Function(T);
typedef RefreshDataFunc<T> = Future<T> Function();

class RefreshLoadMoreListView<T> extends StatefulWidget {
  //Item构建器
  IndexedWidgetBuilder builder;

  //Item数量
  int childCount;

  //LoadMore构建器
  FooterBuilder buildFooter;

  //LoadMore 拖拽回调
  LoadMoreDragCallback loadMoreUpdateCallback;

  //LoadMore 状态回调
  LoadMoreCallback loadMoreCallback;

  //LoadMore 获取数据方法
  LoadMoreDataFunc<T> loadMoreFunc;

  //LoadMore 获取数据回调
  LoadMoreSuccessCallBack<T> loadMoreSuccessCallback;

  //LoadMore构建器
  HeaderBuilder buildHeader;

  //LoadMore 拖拽回调
  RefreshDataDragCallback refreshDataDragCallback;

  //LoadMore 状态回调
  RefreshDataCallback refreshDataCallback;

  //LoadMore 获取数据方法
  RefreshDataFunc<T> refreshDataFunc;

  //LoadMore 获取数据回调
  RefreshSuccessCallBack<T> refreshSuccessCallback;

  RefreshLoadMoreListView(
      {@required this.builder,
      @required this.childCount,
      this.buildFooter,
      this.loadMoreUpdateCallback,
      this.loadMoreCallback,
      @required this.loadMoreFunc,
      @required this.loadMoreSuccessCallback,
      this.buildHeader,
      this.refreshDataDragCallback,
      this.refreshDataCallback,
      @required this.refreshDataFunc,
      @required this.refreshSuccessCallback});

  @override
  _RefreshLoadMoreListViewState createState() =>
      new _RefreshLoadMoreListViewState<T>();
}

class _RefreshLoadMoreListViewState<T> extends State<RefreshLoadMoreListView>
    with TickerProviderStateMixin {
  double dragPercent = 0.0;
  double loadingPercent = 0.0;

  AnimationController animController;
  Animation<double> animation;
  LoadResultSate loadResultSate;
  bool isError = false;

  RefreshResultState refreshResultSate;

  LoadMoreState loadMoreState;
  RefreshState refreshState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = new Tween(begin: 0.0, end: 1.0).animate(animController);
    animation.addListener(_onProgressChange);
  }

  void _onProgressChange() {
//    print("anim: ${animation.value}");
    setState(() {
      loadingPercent = animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.loadMoreCallback ??= buildLoadMoreCallback;
    widget.loadMoreUpdateCallback ??= buildLoadMoreDragCallback;
    widget.buildFooter ??= (state, dragPercent, loadingPercent) {
      return buildDefaultFooter(
          state, loadResultSate, dragPercent, loadingPercent);
    };

    widget.refreshDataCallback ??= buildRefreshCallback;
    widget.refreshDataDragCallback ??= buildRefreshDragCallback;
    widget.buildHeader ??= (state, dragPercent, loadingPercent) {
      return buildDefaultHeader(
          state, refreshResultSate, dragPercent, loadingPercent);
    };

    return RefreshLoadMoreView<T>(
      child: buildSliverList(widget.builder, widget.childCount),
      footer: widget.buildFooter(loadMoreState, dragPercent, loadingPercent),
      loadMoreUpdateCallback: widget.loadMoreUpdateCallback,
      loadMoreCallback: widget.loadMoreCallback,
      loadMore: widget.loadMoreFunc,
      onLoadMoreSuccess: widget.loadMoreSuccessCallback,
      header: widget.buildHeader(refreshState, dragPercent, loadingPercent),
      refreshDataDragCallback: widget.refreshDataDragCallback,
      refreshDataCallback: widget.refreshDataCallback,
      refresh: widget.refreshDataFunc,
      onRefreshSuccess: widget.refreshSuccessCallback,
    );
  }

  void buildLoadMoreCallback(state) {
//    print("callback: ${state}");
    this.loadMoreState = state;

    if (state == LoadMoreState.Loading) {
      startAnim(animController, 0);
      setState(() {
        loadResultSate = LoadResultSate.None;
      });
    } else if (state == LoadMoreState.Normal) {
      setState(() {
        stopAnim(animController, 0);
        loadResultSate = LoadResultSate.None;
      });
    } else if (state == LoadMoreState.Success) {
      setState(() {
        stopAnim(animController, 0);
        loadResultSate = LoadResultSate.Success;
      });
    } else if (state == LoadMoreState.Error) {
      setState(() {
        stopAnim(animController, 0);
        loadResultSate = LoadResultSate.Error;
      });
    } else {
      setState(() {
        stopAnim(animController, 0);
      });
    }
  }

  void buildLoadMoreDragCallback(percent) {
    this.dragPercent = percent;
    setState(() {});
  }

  ///
  /// LoadMore Footer构建
  /// state : 状态
  /// loadResultState : 加载数据结果状态
  /// dragPercent : 拖拽比例（0-1）
  /// loadingPercent : Loading期间动画Value(0-1)
  ///
  Widget buildDefaultFooter(LoadMoreState state, LoadResultSate loadResultSate,
      double dragPercent, double loadingPercent) {
//    print("state: ${state}\t isSuccess: ${isSuccess}\t percent: ${percent}");
    return Container(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        width: 30.0,
        height: 30.0,
        child: Transform.rotate(
          angle: loadResultSate != LoadResultSate.None
              ? 0.0
              : 4 * pi * (dragPercent + loadingPercent),
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
              loadResultSate == LoadResultSate.None
                  ? Icons.refresh
                  : loadResultSate == LoadResultSate.Success
                      ? Icons.done
                      : Icons.error_outline,
              key: ValueKey(loadResultSate == LoadResultSate.None
                  ? Icons.refresh
                  : loadResultSate == LoadResultSate.Success
                      ? Icons.done
                      : Icons.error_outline),
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  void buildRefreshCallback(state) {
    print("callback: ${state}");
    this.refreshState = state;

    if (state == RefreshState.Loading) {
      startAnim(animController, 0);
      setState(() {
        refreshResultSate = RefreshResultState.None;
      });
    } else if (state == RefreshState.Normal) {
      setState(() {
        stopAnim(animController, 0);
        refreshResultSate = RefreshResultState.None;
      });
    } else if (state == RefreshState.Success) {
      setState(() {
        stopAnim(animController, 0);
        refreshResultSate = RefreshResultState.Success;
      });
    } else if (state == RefreshState.Error) {
      setState(() {
        stopAnim(animController, 0);
        refreshResultSate = RefreshResultState.Error;
      });
    } else {
      setState(() {
        stopAnim(animController, 0);
      });
    }
  }

  void buildRefreshDragCallback(percent) {
    this.dragPercent = percent;
//    print("refresh dragPercent: ${dragPercent}");
    setState(() {});
  }

  ///
  /// LoadMore Footer构建
  /// state : 状态
  /// loadResultState : 加载数据结果状态
  /// dragPercent : 拖拽比例（0-1）
  /// loadingPercent : Loading期间动画Value(0-1)
  ///
  Widget buildDefaultHeader(
      RefreshState state,
      RefreshResultState refreshResultState,
      double dragPercent,
      double loadingPercent) {
//    print("state: ${state}\t isSuccess: ${isSuccess}\t percent: ${percent}");
//    print("build header percent: ${dragPercent + loadingPercent}");

    if(refreshResultState==null){
      print("refreshResultState is null");
    }


    return Container(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        width: 30.0,
        height: 30.0,
        child: Transform.rotate(
          angle: refreshResultState != RefreshResultState.None
              ? 0.0
              : 4 * pi * (dragPercent + loadingPercent),
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
              refreshResultState == RefreshResultState.None
                  ? Icons.refresh
                  : refreshResultState == RefreshResultState.Success
                      ? Icons.done
                      : Icons.error_outline,
              key: ValueKey(refreshResultState == RefreshResultState.None
                  ? Icons.refresh
                  : refreshResultState == RefreshResultState.Success
                      ? Icons.done
                      : Icons.error_outline),
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  ///构建列表
  SliverList buildSliverList(IndexedWidgetBuilder builder, int childCount) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(builder, childCount: childCount),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animController.dispose();
  }
}

void startAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    controller.repeat();
  });
}

void stopAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    controller.reset();
  });
}
