import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Views/news/view_refresh.dart';

/**
 * created by
 * on 2019/7/31
 * note
 **/
typedef HeaderBuilder = Widget Function(
    RefreshState state, double dragPercent, double loadingPercent);

class RefreshListView<T> extends StatefulWidget {
  //Item构建器
  IndexedWidgetBuilder builder;

  //Item数量
  int childCount;

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

  RefreshListView({
    @required this.builder,
    @required this.childCount,
    this.buildHeader,
    this.refreshDataDragCallback,
    this.refreshDataCallback,
    @required this.refreshDataFunc,
    this.refreshSuccessCallback,
  });

  @override
  _RefreshListViewState createState() => new _RefreshListViewState<T>();
}

class _RefreshListViewState<T> extends State<RefreshListView>
    with TickerProviderStateMixin {
  double refreshDragPercent = 0.0;
  double refreshLoadingPercent = 0.0;

  AnimationController refreshAnimController;
  Animation<double> refreshAnimation;

  FinishState refreshFinishState = FinishState.None;

  RefreshState refreshState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshAnimController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    refreshAnimation =
        new Tween(begin: 0.0, end: 1.0).animate(refreshAnimController);
    refreshAnimation.addListener(onRefreshDragChange);
  }

  void onRefreshDragChange() {
    setState(() {
      refreshLoadingPercent = refreshAnimation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.refreshDataDragCallback ??= buildRefreshDragCallback;
    widget.refreshDataCallback ??= buildRefreshCallback;
    widget.buildHeader ??= (state, dragPercent, loadingPercent) {
      return buildDefaultHeader(
          state, dragPercent, loadingPercent, refreshFinishState);
    };

    return RefreshView<T>(
      child: buildSliverList(widget.builder, widget.childCount),
      header: widget.buildHeader(
          refreshState, refreshDragPercent, refreshLoadingPercent),
      refreshDataDragCallback: widget.refreshDataDragCallback,
      refreshDataCallback: widget.refreshDataCallback,
      refreshGetDataFunc: widget.refreshDataFunc,
      onRefreshSuccessCallback: widget.refreshSuccessCallback,
      refreshFinsihStateCallBack: buildFinishStateCallback,
    );
  }

  void buildFinishStateCallback(FinishState finishState) {
    this.refreshFinishState = finishState;
  }

  void buildRefreshCallback(state) {
//    print("callback: ${state}");
    this.refreshState = state;

    setState(() {
      if (state == RefreshState.Loading) {
        startAnim(refreshAnimController, 0);
      } else {
        stopAnim(refreshAnimController, 0);
      }
    });
  }

  void buildRefreshDragCallback(percent) {
    this.refreshDragPercent = percent;
    setState(() {});
  }

  ///
  /// LoadMore Footer构建
  /// state : 状态
  /// loadResultState : 加载数据结果状态
  /// dragPercent : 拖拽比例（0-1）
  /// loadingPercent : Loading期间动画Value(0-1)
  ///
  Widget buildDefaultHeader(RefreshState state, double dragPercent,
      double loadingPercent, FinishState finishState) {
    IconData iconData = Icons.refresh;

    if (finishState != FinishState.None) {
      iconData = finishState == FinishState.Success ? Icons.done : Icons.error;
    } else {
      if (state == RefreshState.Normal ||
          state == RefreshState.Update ||
          state == RefreshState.Ready ||
          state == RefreshState.Loading) {
        iconData = Icons.refresh;
      } else if (state == RefreshState.Success) {
        iconData = Icons.done;
      } else if (state == RefreshState.Error) {
        iconData = Icons.error;
      }
    }

    double angle = 0.0;

    if (finishState == FinishState.None) {
      if (state == RefreshState.Update || state == RefreshState.Ready) {
        angle = 4 * pi * dragPercent;
      } else if (state == RefreshState.Loading) {
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
    super.dispose();
    print("anim dispose");
    refreshAnimController.dispose();
  }
}

void startAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    controller.repeat();
  }).catchError((e) {});
}

void stopAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    print("anim reset");
    controller.reset();
  }).catchError((e) {});
}
