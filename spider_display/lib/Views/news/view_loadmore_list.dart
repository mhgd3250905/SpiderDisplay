import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Views/news/view_pull_load.dart';

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
  LoadMoreDataFunc<T> loadMoreDataFunc;

  //LoadMore 获取数据回调
  LoadMoreSuccessCallBack<T> loadMoreSuccessCallback;

  LoadMoreListView({
    @required this.builder,
    @required this.childCount,
    this.buildFooter,
    this.loadMoreUpdateCallback,
    this.loadMoreCallback,
    @required this.loadMoreDataFunc,
    this.loadMoreSuccessCallback,
  });

  @override
  _LoadMoreListViewState createState() => new _LoadMoreListViewState<T>();
}

class _LoadMoreListViewState<T> extends State<LoadMoreListView>
    with TickerProviderStateMixin {
  double loadDragPercent = 0.0;
  double loadMoreLoadingPercent = 0.0;

  FinishState loadMoreFinishState = FinishState.None;

  AnimationController animController;
  Animation<double> animation;

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
    setState(() {
      loadMoreLoadingPercent = animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.loadMoreCallback ??= buildLoadMoreCallback;
    widget.loadMoreUpdateCallback ??= buildLoadMoreUpdateCallback;
    widget.buildFooter ??= (state, dragPercent, loadingPercent) {
      return buildDefaultFooter(
          state, dragPercent, loadingPercent, loadMoreFinishState);
    };

    return PullLoadView<T>(
      child: buildSliverList(widget.builder, widget.childCount),
      footer: widget.buildFooter(
          loadMoreState, loadDragPercent, loadMoreLoadingPercent),
      loadMoreUpdateCallback: widget.loadMoreUpdateCallback,
      loadMoreCallback: widget.loadMoreCallback,
      loadMoreGetDataFunc: widget.loadMoreDataFunc,
      onLoadMoreSuccessCallback: widget.loadMoreSuccessCallback,
      finsihStateCallBack: buildFinishStateCallback,
    );
  }

  void buildLoadMoreCallback(state) {
    this.loadMoreState = state;
    setState(() {
      if (state == LoadMoreState.Loading) {
        startAnim(animController, 0);
      } else {
        stopAnim(animController, 0);
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
  Widget buildDefaultFooter(LoadMoreState state, double dragPercent,
      double loadingPercent, FinishState finishState) {
    IconData iconData = Icons.refresh;

    if (finishState != FinishState.None) {
      iconData = finishState == FinishState.Success ? Icons.done : Icons.error;
    } else {
      if (state == LoadMoreState.Normal ||
          state == LoadMoreState.Update ||
          state == LoadMoreState.Ready ||
          state == LoadMoreState.Loading) {
        iconData = Icons.refresh;
      } else if (state == LoadMoreState.Success) {
        iconData = Icons.done;
      } else if (state == LoadMoreState.Error) {
        iconData = Icons.error;
      }
    }

    double angle = 0.0;

    if (finishState == FinishState.None) {
      if (state == LoadMoreState.Update || state == LoadMoreState.Ready) {
        angle = 4 * pi * dragPercent;
      } else if (state == LoadMoreState.Loading) {
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
    animController.dispose();
  }

  void buildFinishStateCallback(FinishState finishState) {
    this.loadMoreFinishState = finishState;
  }
}

void startAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    controller.repeat();
  }).catchError((e) {});
}

void stopAnim(AnimationController controller, int delay) async {
  Future.delayed(Duration(milliseconds: delay), () {
    controller.reset();
  }).catchError((e) {});
}
