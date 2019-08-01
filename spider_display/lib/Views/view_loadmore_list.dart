import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Views/view_pull_load.dart';

/**
 * created by
 * on 2019/7/31
 * note
 **/
typedef FooterBuilder = Widget Function(
    LoadMoreState state, double dragPercent, double loadingPercent);

typedef LoadMoreSuccessCallBack<T> = void Function(T);
typedef LoadMoreDataFunc<T> = Future<T> Function();

class LoadMoreListView<T> extends StatefulWidget {
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

  LoadMoreListView({
    @required this.builder,
    @required this.childCount,
    this.buildFooter,
    this.loadMoreUpdateCallback,
    this.loadMoreCallback,
    @required this.loadMoreFunc,
    this.loadMoreSuccessCallback,
  });

  @override
  _LoadMoreListViewState createState() => new _LoadMoreListViewState<T>();
}

class _LoadMoreListViewState<T> extends State<LoadMoreListView>
    with TickerProviderStateMixin {
  double dragPercent = 0.0;
  double loadingPercent = 0.0;

  AnimationController animController;
  Animation<double> animation;
  LoadResultSate loadResultSate;
  bool isError = false;

  LoadMoreState loadMoreState;

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
    widget.loadMoreUpdateCallback ??= buildLoadMoreUpdateCallback;
    widget.buildFooter ??= (state, dragPercent, loadingPercent) {
      return buildDefaultFooter(
          state, loadResultSate, dragPercent, loadingPercent);
    };

    return PullLoadView<T>(
      child: buildSliverList(widget.builder, widget.childCount),
      footer: widget.buildFooter(loadMoreState, dragPercent, loadingPercent),
      loadMoreUpdateCallback: widget.loadMoreUpdateCallback,
      loadMoreCallback: widget.loadMoreCallback,
      loadMore: widget.loadMoreFunc,
      onLoadMoreSuccess: widget.loadMoreSuccessCallback,
    );
  }

  void buildLoadMoreCallback(state) {
    print("callback: ${state}");
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

  void buildLoadMoreUpdateCallback(percent) {
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
