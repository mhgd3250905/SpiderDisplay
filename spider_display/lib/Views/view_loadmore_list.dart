import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Views/view_pull_load.dart';

/**
 * created by
 * on 2019/7/31
 * note
 **/
typedef BuildFooterWidget = Widget Function(
    LoadMoreState state, double percent);

class LoadMoreListView<T> extends StatefulWidget {
  IndexedWidgetBuilder builder;
  int childCount;
  BuildFooterWidget buildFooter;
  LoadMoreUpdateCallback loadMoreUpdateCallback;
  LoadMoreCallback loadMoreCallback;
  Future<T> Function() loadMore;

  LoadMoreListView({
    @required this.builder,
    @required this.childCount,
    this.buildFooter,
    this.loadMoreUpdateCallback,
    this.loadMoreCallback,
    this.loadMore
  });

  @override
  _LoadMoreListViewState createState() => new _LoadMoreListViewState<T>();
}

class _LoadMoreListViewState<T> extends State<LoadMoreListView>
    with TickerProviderStateMixin {
  double percent = 0.0;
  AnimationController animController;
  Animation<double> animation;
  bool isSuccess = false;

  LoadMoreState state;
  double loadingPercent = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = new Tween(begin: 0.0, end: 1.0).animate(animController);
    animation.addListener(_onProgressChange);

    widget.loadMoreCallback ??= buildLoadMoreCallback;
    widget.loadMoreUpdateCallback ??= buildLoadMoreUpdateCallback;
    widget.loadMore ??= loadMore;
  }

  void _onProgressChange() {
//    print("anim: ${animation.value}");
    setState(() {
      loadingPercent = animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.buildFooter == null) {
      widget.buildFooter = (state, percent) {
        return buildDefaultFooter(state, isSuccess, percent);
      };
    }
    return PullLoadView<T>(
      child: buildSliverList(widget.builder, widget.childCount),
      footer: widget.buildFooter(state, percent),
      loadMoreUpdateCallback: widget.loadMoreUpdateCallback,
      loadMoreCallback: widget.loadMoreCallback,
      loadMore: widget.loadMore,
    );
  }

  void buildLoadMoreCallback(state) {
    print("callback: ${state}");
    this.state = state;

    if (state == LoadMoreState.Loading) {
      startAnim(animController, 0);
      setState(() {
        isSuccess = false;
      });
    } else if (state == LoadMoreState.Normal) {
      setState(() {
        stopAnim(animController, 0);
        isSuccess = false;
      });
    } else if (state == LoadMoreState.Success) {
      setState(() {
        stopAnim(animController, 0);
        isSuccess = true;
      });
    } else {
      setState(() {
        stopAnim(animController, 0);
      });
    }
  }

  void buildLoadMoreUpdateCallback(state, percent) {
    this.percent = percent;
    setState(() {});
  }

  Widget buildDefaultFooter(
      LoadMoreState state, bool isSuccess, double percent) {
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
          angle: isSuccess ? 0.0 : 4 * pi * (percent + loadingPercent),
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
              isSuccess ? Icons.done : Icons.refresh,
              key: ValueKey(isSuccess ? Icons.done : Icons.refresh),
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

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

Future<String> loadMore() async {
  print("loadMore: ${DateTime.now()}");
  await Future.delayed(Duration(seconds: 3), () {
    return "LoadMore Success!";
  });
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
