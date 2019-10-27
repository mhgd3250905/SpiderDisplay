import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spider_display/Modle/bookset_modle.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/news/view_pull_load.dart';

import 'bookset_detail_page.dart';
import 'bookset_list_page.dart';

/**
 * created by
 * on 2019/7/31
 * note
 **/

class RefreshTestPage extends StatefulWidget {
  List<Book> bookList;

  RefreshTestPage() {
    bookList = BookList.fromJson(json.decode(BOOK_LIST_JSON_STR)).data;
  }

  @override
  _RefreshTestPageState createState() => new _RefreshTestPageState();
}

class _RefreshTestPageState extends State<RefreshTestPage>
    with TickerProviderStateMixin {
  double percent = 0.0;
  AnimationController animController;
  Animation<double> animation;
  bool isSuccess = false;

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
      percent = animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RefreshTest"),
      ),
      body: PullLoadView<String>(
        child: buildSliverList,
        footer: Container(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
          color: Colors.white,
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            width: 30.0,
            height: 30.0,
            child: Transform.rotate(
              angle: isSuccess ? 0.0 : 4 * pi * percent,
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
        ),
        loadMoreUpdateCallback: (percent) {
          this.percent = percent;
          setState(() {});
        },
        loadMoreCallback: (state) {
          print("callback: ${state}");

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
        },
        loadMoreGetDataFunc: loadMore,
        onLoadMoreSuccessCallback: null,
        finsihStateCallBack: (FinishState) {},
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
                    NavigatorRouterUtils.pushToPage(
                        context, BookDetailPage(index));
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
    // TODO: implement dispose
    super.dispose();
    animController.dispose();
  }
}

/**
 * 构建列表ItemView
 */
Widget buildBookListItemView(Book book, int pos) {
  return BookItemView(book, pos);
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
