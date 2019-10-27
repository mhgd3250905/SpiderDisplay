import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Views/news/view_auto_refresh.dart';

/**
 * created by
 * on 2019/7/31
 * note
 **/
typedef FooterBuilder = Widget Function(DragState state, double dragPercent,
    double loadingPercent, FinishState finishState);

typedef HeaderBuilder = Widget Function(DragState state, double dragPercent,
    double loadingPercent, FinishState finishState);

typedef LoadMoreSuccessCallBack<T> = void Function(T);
typedef LoadMoreDataFunc<T> = Future<T> Function();

typedef BuildSliverChildren = List<Widget> Function();

class AutoRefreshListView<T> extends StatefulWidget {
  //Item构建器
  IndexedWidgetBuilder builder;

  //Item数量
  int childCount;

  //LoadMore构建器
  FooterBuilder buildFooter;

  //LoadMore 拖拽回调
  LoadMoreDragCallback loadMoreDragCallback;

  //LoadMore 状态回调
  LoadMoreCallback loadMoreCallback;

  //LoadMore 获取数据方法
  LoadMoreDataFunc<T> loadMoreDataFunc;

  //LoadMore 获取数据回调
  LoadMoreSuccessCallBack<T> loadMoreSuccessCallback;

  //LoadMore构建器
  HeaderBuilder buildHeader;

  //LoadMore 拖拽回调
  RefreshDataDragCallback refreshDataDragCallback;

  //LoadMore 状态回调
  RefreshDataCallback refreshDataCallback;

  //LoadMore 获取数据方法
  RefreshGetDataFunc<T> refreshDataFunc;

  //LoadMore 获取数据回调
  OnRefreshSuccessCallback<T> refreshSuccessCallback;

  //获取列表上方自定义的Widgets
  BuildSliverChildren buildSliverChildren;

  //是否显示Footer
  bool footerEnable = false;

  //是否显示Header
  bool headerEnable = false;

  AutoRefreshListView({
    @required this.builder,
    @required this.childCount,
    @required this.footerEnable,
    this.buildFooter,
    this.loadMoreDragCallback,
    this.loadMoreCallback,
    this.loadMoreDataFunc,
    this.loadMoreSuccessCallback,
    @required this.headerEnable,
    this.buildHeader,
    this.refreshDataDragCallback,
    this.refreshDataCallback,
    this.refreshDataFunc,
    this.refreshSuccessCallback,
    this.buildSliverChildren,
  });

  @override
  _AutoRefreshListViewState createState() => new _AutoRefreshListViewState<T>();
}

class _AutoRefreshListViewState<T> extends State<AutoRefreshListView>
    with TickerProviderStateMixin {
  AnimationController loadMoreAnimController;
  Animation<double> loadMoreAnimation;
  double loadDragPercent = 0.0;
  double loadMoreLoadingPercent = 0.0;
  FinishState loadMoreFinishState = FinishState.None;
  DragState loadMoreState;

  AnimationController refreshAnimController;
  Animation<double> refreshAnimation;
  double refreshDragPercent = 0.0;
  double refreshLoadingPercent = 0.0;
  FinishState refreshFinishState = FinishState.None;
  DragState refreshState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMoreAnimController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    loadMoreAnimation =
        new Tween(begin: 0.0, end: 1.0).animate(loadMoreAnimController);
    loadMoreAnimation.addListener(onLoadMoreDragChange);

    refreshAnimController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    refreshAnimation =
        new Tween(begin: 0.0, end: 1.0).animate(refreshAnimController);
    refreshAnimation.addListener(onRefreshDragChange);
  }

  void onLoadMoreDragChange() {
    setState(() {
      loadMoreLoadingPercent = loadMoreAnimation.value;
    });
  }

  void onRefreshDragChange() {
    setState(() {
      refreshLoadingPercent = refreshAnimation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.footerEnable) {
      widget.loadMoreCallback ??= buildLoadMoreCallback;
      widget.loadMoreDragCallback ??= buildLoadMoreUpdateCallback;
      widget.buildFooter ??=
          (state, dragPercent, loadingPercent, loadMoreFinishState) {
        return buildDefaultFooter(
            state, dragPercent, loadingPercent, loadMoreFinishState);
      };
    } else {
      widget.loadMoreDragCallback = (percent) {};
      widget.loadMoreCallback = (state) {};
      widget.loadMoreDataFunc = () {};
      widget.loadMoreSuccessCallback = (T) {};
    }

    if (widget.headerEnable) {
      widget.refreshDataDragCallback ??= buildRefreshDragCallback;
      widget.refreshDataCallback ??= buildRefreshCallback;
      widget.buildHeader ??=
          (state, dragPercent, loadingPercent, refreshFinishState) {
        return buildDefaultHeader(
            state, dragPercent, loadingPercent, refreshFinishState);
      };
    } else {
      widget.refreshDataDragCallback = (percent) {};
      widget.refreshDataCallback = (state) {};
      widget.refreshDataFunc = () {};
      widget.refreshSuccessCallback = (T) {};
    }

    return AutoRefreshView<T>(
      child: buildSliverList(widget.builder, widget.childCount),
      footerEnable: widget.footerEnable,
      footer: widget.buildFooter == null
          ? null
          : widget.buildFooter(loadMoreState, loadDragPercent,
              loadMoreLoadingPercent, loadMoreFinishState),
      loadMoreUpdateCallback: widget.loadMoreDragCallback,
      loadMoreCallback: widget.loadMoreCallback,
      loadMoreGetDataFunc: widget.loadMoreDataFunc,
      onLoadMoreSuccessCallback: widget.loadMoreSuccessCallback,
      loadMoreFinsihStateCallBack: buildLoadMoreFinishStateCallback,
      headerEnable: widget.headerEnable,
      header: widget.buildHeader == null
          ? null
          : widget.buildHeader(refreshState, refreshDragPercent,
              refreshLoadingPercent, refreshFinishState),
      refreshDataDragCallback: widget.refreshDataDragCallback,
      refreshDataCallback: widget.refreshDataCallback,
      refreshGetDataFunc: widget.refreshDataFunc,
      onRefreshSuccessCallback: widget.refreshSuccessCallback,
      refreshFinsihStateCallBack: buildRefreshFinishStateCallback,
      buildOtherTopWidgets: widget.buildSliverChildren == null
          ? null
          : widget.buildSliverChildren(),
    );
  }

  void buildLoadMoreCallback(state) {
    this.loadMoreState = state;
    setState(() {
      if (state == DragState.Loading) {
        startAnim(loadMoreAnimController, 0);
      } else {
        stopAnim(loadMoreAnimController, 0);
      }
    });
  }

  void buildLoadMoreUpdateCallback(percent) {
    this.loadDragPercent = percent;
    setState(() {});
  }

  ///
  /// LoadMore Footer构建
  /// state : 状态
  /// loadResultState : 加载数据结果状态
  /// dragPercent : 拖拽比例（0-1）
  /// loadingPercent : Loading期间动画Value(0-1)
  ///
  Widget buildDefaultFooter(DragState state, double dragPercent,
      double loadingPercent, FinishState finishState) {
//    print(
//        "state: ${state}, drag: ${dragPercent}, loading: ${loadingPercent}, finish: ${finishState}");

    IconData iconData = Icons.refresh;

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

    double angle = 0.0;

    if (finishState == FinishState.None) {
      if (state == DragState.Update || state == DragState.Ready) {
        angle = 4 * pi * dragPercent;
      } else if (state == DragState.Loading) {
        angle = 4 * pi * (dragPercent + loadingPercent);
      } else {
        angle = 0.0;
      }
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
    );
  }

  void buildRefreshCallback(state) {
    print("buildRefreshCallback: ${state}");
    this.refreshState = state;

    if (state == DragState.Loading) {
      startAnim(refreshAnimController, 0);
    } else {
      stopAnim(refreshAnimController, 0);
    }
  }

  void buildRefreshDragCallback(percent) {
    this.refreshDragPercent = percent;
  }

  ///
  /// LoadMore Footer构建
  /// state : 状态
  /// loadResultState : 加载数据结果状态
  /// dragPercent : 拖拽比例（0-1）
  /// loadingPercent : Loading期间动画Value(0-1)
  ///
  Widget buildDefaultHeader(DragState state, double dragPercent,
      double loadingPercent, FinishState finishState) {
    IconData iconData = Icons.refresh;

//    print(
//        "state: ${state}, drag: ${dragPercent}, loading: ${loadingPercent}, finish: ${finishState}");

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

    double angle = 0.0;

    if (finishState == FinishState.None) {
      if (state == DragState.Update || state == DragState.Ready) {
        angle = 4 * pi * dragPercent;
      } else if (state == DragState.Loading) {
        angle = 4 * pi * (dragPercent + loadingPercent);
      } else {
        angle = 0.0;
      }
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
    loadMoreAnimController.dispose();
    refreshAnimController.dispose();
    super.dispose();
  }

  void buildLoadMoreFinishStateCallback(FinishState finishState) {
    this.loadMoreFinishState = finishState;
  }

  void buildRefreshFinishStateCallback(FinishState finishState) {
    this.refreshFinishState = finishState;
  }

  List<Widget> buildSliverChildren() {
    return null;
  }
}

void startAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    if (controller == null) {
      return;
    }
    controller.repeat();
  }).catchError((e) {});
}

void stopAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    if (controller == null) {
      return;
    }
    controller.reset();
  }).catchError((e) {});
}
