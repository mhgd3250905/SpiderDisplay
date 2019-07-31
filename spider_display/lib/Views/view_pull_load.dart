import 'package:flutter/material.dart';
/**
 * created by ksheng
 * on 2019/7/30
 * note 下拉刷新控件
 **/

class PullLoadView<T> extends StatefulWidget {
  SliverList child;
  Widget footer;
  LoadMoreCallback loadMoreCallback;
  LoadMoreUpdateCallback loadMoreUpdateCallback;
  Future<T> Function() loadMore;

  PullLoadView(
      {@required this.child,
      @required this.footer,
      this.loadMoreCallback,
      this.loadMoreUpdateCallback,
      @required this.loadMore}) {
    assert(child != null);
    assert(footer != null);
    assert(loadMore != null);
    loadMoreCallback ??= (state) {};
    loadMoreUpdateCallback ??= (state, percent) {};
  }

  @override
  _PullLoadViewState createState() => new _PullLoadViewState();
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
typedef LoadMoreUpdateCallback = void Function(LoadMoreState, double);

class _PullLoadViewState extends State<PullLoadView>
    with AutomaticKeepAliveClientMixin {
  double move = 0.0;
  bool isLoading = false;
  bool isRefresh = false;
  ScrollController scrollController;

  double normalMaxHeight = 0.0;
  double dragPercent = 0.0;

  bool isMoving = false;

  int state = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
//    print("build!");
    return NotificationListener<ScrollNotification>(
      onNotification: (notication) {
        double pixels = notication.metrics.pixels;
        double curMaxHeight = notication.metrics.maxScrollExtent;

        print("normalH: ${normalMaxHeight}, curMaxH: ${curMaxHeight}, isLoading: ${isLoading}");

        //设置触发区域为footer的1/5
        double readyTiggerRange = (curMaxHeight - normalMaxHeight) / 10;

        if (!isLoading) {
          //在未开启footer的时候获取到标准最大高度
          if (widget.loadMoreCallback != null) {
            setState(() {
              widget.loadMoreCallback(LoadMoreState.Normal);
            });
          }
          normalMaxHeight = notication.metrics.maxScrollExtent;
        }

        if (notication is ScrollStartNotification) {
//          print("开始滑动！");
          isMoving = true;
          if (pixels >= normalMaxHeight) {
            if (!isLoading) {
              //未开启刷新
//              print("滑动到底部！");

              setState(() {
                if (widget.loadMoreCallback != null) {
                  widget.loadMoreCallback(LoadMoreState.Start);
                }
                isLoading = true;
              });
            }
          }
        } else if (notication is ScrollEndNotification) {
//          print("结束滑动！");
          isMoving = false;
          if (curMaxHeight > normalMaxHeight) {
            if (pixels > normalMaxHeight &&
                pixels < curMaxHeight - readyTiggerRange) {
//              print("回弹！");
              doSomeThingDelay(Duration(seconds: 0), () {
                scrollController
                    .animateTo(
                  normalMaxHeight,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.linear,
                )
                    .whenComplete(() {
                  //回弹完成时候恢复正常状态
                  if (widget.loadMoreCallback != null) {
                    widget.loadMoreCallback(LoadMoreState.Normal);
                  }
                  setState(() {
                    isLoading = false;
                  });
                });
              });
            } else if (pixels >= curMaxHeight - readyTiggerRange) {
              //Ready
              if (widget.loadMoreCallback != null) {
                setState(() {
                  widget.loadMoreCallback(LoadMoreState.Loading);
                });
                widget.loadMore().then((T) {
//                  print("success: ${DateTime.now()}");
                  setState(() {
                    widget.loadMoreCallback(LoadMoreState.Success);
                    doSomeThingDelay(Duration(seconds: 2000), () {
                      scrollController
                          .animateTo(
                        normalMaxHeight,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.linear,
                      )
                          .whenComplete(() {
                        //回弹完成时候恢复正常状态
                        if (widget.loadMoreCallback != null) {
                          widget.loadMoreCallback(LoadMoreState.Normal);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      });
                    });
                  });
                }).catchError((error) {
                  setState(() {
                    widget.loadMoreCallback(LoadMoreState.Error);
                  });
                });
              }
            }
          }
        } else if (notication is ScrollUpdateNotification) {
          //如果是滑动过程中
//          print("滑动中！");

          if (notication.depth == 0 && !isRefresh) {
//          print(notication.metrics.pixels);
            if (pixels >= normalMaxHeight) {
              //如果当前已经到达底部，就要显示footer了
              if (!isLoading) {
                //未开启刷新
//                print("滑动到底部！");
                doSomeThingDelay(Duration(seconds: 0), () {
                  scrollController.jumpTo(normalMaxHeight);
                });
                setState(() {
                  if (widget.loadMoreCallback != null) {
                    widget.loadMoreCallback(LoadMoreState.Start);
                  }
                  isLoading = true;
                });
              }
            } else if (pixels > normalMaxHeight &&
                pixels < curMaxHeight - readyTiggerRange) {
              //开启刷新后继续下拉
//              print("update!");
              setState(() {
                dragPercent = (pixels - normalMaxHeight) /
                    (curMaxHeight - normalMaxHeight);

                if (widget.loadMoreUpdateCallback != null) {
                  widget.loadMoreUpdateCallback(
                      LoadMoreState.Update, dragPercent);
                }
//                print("dragPercent: ${dragPercent}");
              });
            } else if (pixels >= curMaxHeight - readyTiggerRange) {
//              print("Ready ${isLoading}");
              if (widget.loadMoreCallback != null) {
                setState(() {
                  widget.loadMoreCallback(LoadMoreState.Ready);
                });
              }
            }
          }
        }
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          buildBody(),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildBody() {
    return widget.child;
  }

  SliverToBoxAdapter buildFooter() {
    return SliverToBoxAdapter(
      child: Visibility(
        child: widget.footer,
        visible: isLoading,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void doSomeThingDelay(Duration duration, void Function() doSomething) {
  Future.delayed(Duration(seconds: 0), doSomething);
}
