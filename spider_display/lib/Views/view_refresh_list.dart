import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Views/view_refresh.dart';

/**
 * created by
 * on 2019/7/31
 * note
 **/
typedef HeaderBuilder = Widget Function(
    RefreshState state, double dragPercent, double loadingPercent);

typedef RefreshSuccessCallBack<T> = void Function(T);
typedef RefreshDataFunc<T> = Future<T> Function();

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
  RefreshDataFunc<T> refreshDataFunc;

  //LoadMore 获取数据回调
  RefreshSuccessCallBack<T> refreshSuccessCallback;

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
  double dragPercent = 0.0;
  double loadingPercent = 0.0;

  AnimationController animController;
  Animation<double> animation;
  RefreshResultSate refreshResultSate;

  bool isError = false;

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
    widget.refreshDataDragCallback ??= buildRefreshDragCallback;
    widget.refreshDataCallback ??= buildRefreshCallback;
    widget.buildHeader ??= (state, dragPercent, loadingPercent) {
      return buildDefaultHeader(
          state, refreshResultSate, dragPercent, loadingPercent);
    };

    return RefreshView<T>(
      child: buildSliverList(widget.builder, widget.childCount),
      footer: widget.buildHeader(refreshState, dragPercent, loadingPercent),
      refreshDataDragCallback: widget.refreshDataDragCallback,
      refreshDataCallback: widget.refreshDataCallback,
      refresh: widget.refreshDataFunc,
      onRefreshSuccess: widget.refreshSuccessCallback,
    );
  }

  void buildRefreshCallback(state) {
    print("callback: ${state}");
    this.refreshState = state;

    if (state == RefreshState.Loading) {
      startAnim(animController, 0);
      setState(() {
        refreshResultSate = RefreshResultSate.None;
      });
    } else if (state == RefreshState.Normal) {
      setState(() {
        stopAnim(animController, 0);
        refreshResultSate = RefreshResultSate.None;
      });
    } else if (state == RefreshState.Success) {
      setState(() {
        stopAnim(animController, 0);
        refreshResultSate = RefreshResultSate.Success;
      });
    } else if (state == RefreshState.Error) {
      setState(() {
        stopAnim(animController, 0);
        refreshResultSate = RefreshResultSate.Error;
      });
    } else {
      setState(() {
        stopAnim(animController, 0);
      });
    }
  }

  void buildRefreshDragCallback(percent) {
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
  Widget buildDefaultHeader(
      RefreshState state,
      RefreshResultSate loadResultSate,
      double dragPercent,
      double loadingPercent) {
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
          angle: loadResultSate != RefreshResultSate.None
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
              loadResultSate == RefreshResultSate.None
                  ? Icons.refresh
                  : loadResultSate == RefreshResultSate.Success
                      ? Icons.done
                      : Icons.error_outline,
              key: ValueKey(loadResultSate == RefreshResultSate.None
                  ? Icons.refresh
                  : loadResultSate == RefreshResultSate.Success
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
