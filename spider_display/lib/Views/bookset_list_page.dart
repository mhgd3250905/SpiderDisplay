import 'package:flutter/material.dart';
import 'package:spider_display/Modle/bookset_modle.dart';
import 'package:spider_display/Modle/test_content.dart';

class BooksetListPage<T> extends StatefulWidget {
  List<Book> bookList;
  ScrollController scrollController;

  LoadMoreCallback loadMoreCallback;
  LoadMoreUpdateCallback loadMoreUpdateCallback;
  Future<T> Function() loadMore;

  BooksetListPage(this.bookList, this.scrollController, this.loadMoreCallback,
      this.loadMoreUpdateCallback, this.loadMore) {
    if (scrollController == null) {
      scrollController = new ScrollController();
    }
  }

  @override
  _BooksetListPageState createState() => new _BooksetListPageState();
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

class _BooksetListPageState extends State<BooksetListPage>
    with AutomaticKeepAliveClientMixin {
  double move = 0.0;
  bool isLoading = false;
  bool isRefresh = false;
  String loadText = "正在加载...";
  String refreshText = "正在刷新...";
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

  /**
   * 构建列表ItemView
   */
  Widget buildBookListItemView(Book book, int pos) {
    return BookItemView(book, pos);
  }

  @override
  Widget build(BuildContext context) {
//    print("build!");
    return NotificationListener<ScrollNotification>(
      onNotification: (notication) {
        double pixels = notication.metrics.pixels;
        double curMaxHeight = notication.metrics.maxScrollExtent;

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
          if (pixels == curMaxHeight) {
            if (!isLoading) {
              //未开启刷新
//              print("滑动到底部！");

              setState(() {
                if (widget.loadMoreCallback != null) {
                  widget.loadMoreCallback(LoadMoreState.Start);
                }
                loadText = "加载中...";
                isLoading = true;
              });
            }
          }
        } else if (notication is ScrollEndNotification) {
//          print("结束滑动！");
          isMoving = false;
          if (curMaxHeight > normalMaxHeight) {
            if (pixels > normalMaxHeight && pixels < curMaxHeight - 20.0) {
              print("回弹！");
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
            } else if (pixels >= curMaxHeight - 20.0) {
              //拉到最下方松手
              if (widget.loadMoreCallback != null) {
                setState(() {
                  widget.loadMoreCallback(LoadMoreState.Loading);
                });
                print("松手：${DateTime.now()}");
                widget.loadMore().then((T) {
                  print(T);
                  setState(() {
                    print("完成：${DateTime.now()}");
                    widget.loadMoreCallback(LoadMoreState.Success);

                    doSomeThingDelay(Duration(seconds: 200), () {
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
            if (pixels == curMaxHeight) {
              if (!isLoading) {
                //未开启刷新
                print("滑动到底部！");
                doSomeThingDelay(Duration(seconds: 0), () {
                  scrollController.jumpTo(normalMaxHeight);
                });
                setState(() {
                  if (widget.loadMoreCallback != null) {
                    widget.loadMoreCallback(LoadMoreState.Start);
                  }
                  loadText = "加载中...";
                  isLoading = true;
                });
              }
            } else if (pixels > normalMaxHeight &&
                pixels < curMaxHeight - 20.0) {
              //开启刷新后继续下拉
              print("update!");
              setState(() {
                dragPercent = (pixels - normalMaxHeight) /
                    (curMaxHeight - normalMaxHeight);

                if (widget.loadMoreUpdateCallback != null) {
                  widget.loadMoreUpdateCallback(
                      LoadMoreState.Update, dragPercent);
                }
//                print("dragPercent: ${dragPercent}");
              });
            } else if (pixels >= curMaxHeight - 20.0) {
              print("Ready");
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
          SliverToBoxAdapter(
            child: Visibility(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(refreshText),
              ),
              visible: isRefresh,
            ),
          ),
          buildSliverList,
          buildSliverToBoxAdapter,
        ],
      ),
    );
  }

  SliverToBoxAdapter get buildSliverToBoxAdapter {
    return SliverToBoxAdapter(
      child: Visibility(
        child: Container(
          padding: const EdgeInsets.only(top: 60.0, bottom: 60.0),
          color: Colors.white,
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            width: 20.0,
            height: 20.0,
//            child: Text("${dragPercent}"),
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              backgroundColor: Colors.blue,
              // value: 0.2,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87),
            ),
          ),
        ),
        visible: isLoading,
      ),
    );
  }

  SliverList get buildSliverList {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(2.0, 2.0),
                  blurRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(2.0, 0.0),
                  blurRadius: 2.0,
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
            child: Material(
              borderRadius: BorderRadius.circular(3.0),
              child: Ink(
                child: InkWell(
                  child: buildBookListItemView(widget.bookList[index], index),
                  onTap: () {
                    scrollController.animateTo(
                      normalMaxHeight,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
//                    NavigatorRouterUtils.pushToPage(
//                        context, BookDetailPage(index));
                  },
                ),
              ),
            ),
          );
        },
        childCount: widget.bookList.length,
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

class BookItemView extends StatefulWidget {
  final Book book;
  final pos;

  BookItemView(this.book, this.pos);

  @override
  _BookItemViewState createState() => new _BookItemViewState();
}

class _BookItemViewState extends State<BookItemView>
    with AutomaticKeepAliveClientMixin {
  bool _isStared = false;

  //点击收藏的效果
  onStarClick() {
    setState(() {
      _isStared = !_isStared;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Row(
            children: <Widget>[
              //左侧图片
              Container(
                width: 180.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3.0),
                    bottomLeft: Radius.circular(3.0),
                    topRight: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                ),
                child: Hero(
                  tag: "IMAGE${widget.pos}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3.0),
                      bottomLeft: Radius.circular(3.0),
                      topRight: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                    child: Image.network(
                      BOOK_LIST_IMG_URL_ARR[widget.pos % 5],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              //右侧内容，横向占满
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: Text('${widget.book.title}'),
                      ),
                      //纵向占满
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text('${widget.book.author}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  width: 80.0,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      _isStared ? Icons.favorite : Icons.favorite_border,
                      color: _isStared ? Colors.pink : Colors.grey,
                    ),
                    onPressed: onStarClick,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blue,
      child: Center(
        child: Text('TestPage'),
      ),
    );
  }
}

void doSomeThingDelay(Duration duration, void Function() doSomething) {
  Future.delayed(Duration(seconds: 0), doSomething);
}
