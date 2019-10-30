import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/view_toast.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Res/res_string.dart';
import 'package:spider_display/Views/news/comic/comic_chapter_page/presenter_comic_chapter.dart';

import 'i_comic_chapter_view.dart';

class ComicChapterPage extends StatefulWidget {
  //所有章节
  final List<Chapter> chapters;

  //选中章节
  int index;

  //从头开始还是从尾开始
  bool reverse = false;

  ComicChapterPage({
    @required this.chapters,
    @required this.index,
    this.reverse,
  });

  @override
  _ComicChapterPageState createState() => new _ComicChapterPageState();
}

class _ComicChapterPageState extends State<ComicChapterPage>
    implements IComicChapterView<ChapterDetail> {
  List<String> dataList;
  Widget content;
  ComicChapterPresenter presenter;

  ScrollController _scrollController = new ScrollController();
  double screenWidth;
  double nextOffset = 0;

  double pointerStart = 0;
  double pointerEnd = 0;
  double touchRange = 0;

  //上一次停留位置
  int lastPage = 0;

  //当前获取并显示的章节
  Chapter _chapter;

  //是否处于上一章下一章提示等待时间
  bool isWaitingJump;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    presenter = new ComicChapterPresenter();
    presenter.attach(this);

    //初始化默认章节信息
    resetChapterInfo(widget.index, widget.reverse);
  }

  /**
   * 加载数据
   */
  void resetChapterInfo(int index, bool reverse) {
    lastPage = 0;
    nextOffset = 0;
    pointerStart = 0;
    pointerEnd = 0;
    touchRange = 0;

    isWaitingJump = false;
    widget.index = index;
    widget.reverse = reverse;
    _chapter = widget.chapters[widget.index];
    content = getWaitingView();
    presenter.showData(
        "http://49.234.76.105:80/spider/comic/chapter?id=${_chapter.chapter_id}");
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print("screen width is ${screenSize.width}");
    screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(presenter.isShowSetupView
            ? MediaQuery.of(context).size.height * 0.07
            : 0.0),
        child: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: Text(
            _chapter.name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: presenter.isShowSetupView
                    ? 0.0
                    : MediaQuery.of(context).size.height * 0.07),
            child: GestureDetector(
              child: content,
              onTapDown: getViewTapDownCallback(),
            ),
          ),
          Positioned(
            child: Visibility(
              visible: presenter.isShowSetupView,
              child: Container(
                color: Colors.green,
                height: 200.0,
                width: screenWidth,
              ),
            ),
            bottom: 0.0,
            left: 0.0,
          ),
        ],
      ),
    );
  }

  void loadDataSuccess(ChapterDetail chapter) {
    content = getSuccessView(chapter.data);
    setState(() {});
  }

  @override
  void loadDataFailed() {
    content = getFailedView();
    setState(() {});
  }

  @override
  void loadDataWaiting() {
    content = getWaitingView();
    setState(() {});
  }

  Widget getSuccessView(List<String> data) {
    if (!widget.reverse) {
      data = data.reversed.toList();
    }
    return getChapterListener(
      data,
      ListView.builder(
        physics: BouncingScrollPhysics(),
        cacheExtent: 3 * screenWidth,
        reverse: widget.reverse,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        semanticChildCount: 5,
        itemBuilder: (BuildContext context, int index) {
          String pageStr = "${_chapter.name} "
              "${widget.reverse ? (data.length - index) : (index + 1)}/${data.length}";
          return buildImageItemView(data[index], pageStr, data.length);
        },
      ),
    );
  }

  /**
   * 返回界面点击的时间处理逻辑
   */
  GestureTapDownCallback getViewTapDownCallback() {
    return (e) {
      double x = widget.reverse
          ? (screenWidth - e.globalPosition.dx)
          : e.globalPosition.dx;
      print("${e.globalPosition}");

      //如果点击的区域是屏幕中间，那么就直接显示设置区域
      if (pointInSetupZone(e.globalPosition)) {
        presenter.toggleSetupView();
        return;
      }

      if (lastPage <= 0 || lastPage >= widget.chapters.length - 1) {
        if (!widget.reverse) {
          if (widget.index == 0) {
            return;
          }
          //如果是正向第一页，点击右半区域，应该为向右翻页
          if (x <= screenWidth / 2 && lastPage <= 0) {
            if (!isWaitingJump) {
              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_PREVIOUS_CLICK,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
              return;
            } else {
              //跳转到上一章
              presenter.jumpPage(widget.index + 1, true);
            }
          } else if (x > screenWidth / 2 &&
              lastPage >= widget.chapters.length - 1) {
            if (!isWaitingJump) {
              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_NEXT_CLICK,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
              return;
            } else {
              //跳转到下一章
              presenter.jumpPage(widget.index - 1, false);
            }
          }
        } else {
          if (x <= screenWidth / 2 && lastPage <= 0) {
            if (!isWaitingJump) {
              print("222");

              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_NEXT_CLICK,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
              return;
            } else {
              //跳转到下一章
              print("111");
              presenter.jumpPage(widget.index - 1, false);
            }
          } else if (x > screenWidth / 2 &&
              lastPage >= widget.chapters.length - 1) {
            if (!isWaitingJump) {
              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_PREVIOUS_CLICK,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
              return;
            } else {
              //跳转到上一章
              presenter.jumpPage(widget.index + 1, true);
            }
          }
        }
      }

      if (x >= screenWidth / 2) {
//        print("lastPage: ${lastPage}");
        nextOffset = screenWidth * (lastPage + 1);
        Future.delayed(Duration(seconds: 0), () {
//          print("animate to ${nextOffset}");
          _scrollController.animateTo(nextOffset,
              duration: Duration(milliseconds: 100), curve: Curves.linear);
        }).then((T) {
//          print("前进执行完毕！");
          lastPage++;
//          print("lastPage: ${lastPage}");
        }).catchError((e) {
          print(e);
        });
      } else {
        print("lastPage: ${lastPage}");
        nextOffset = screenWidth * (lastPage - 1);
        Future.delayed(Duration(seconds: 0), () {
//          print("animate to ${nextOffset}");
          _scrollController.animateTo(nextOffset,
              duration: Duration(milliseconds: 100), curve: Curves.linear);
        }).then((T) {
//          print("回退执行完毕！");
          lastPage--;
//          print("lastPage: ${lastPage}");
          if (lastPage < 0) {
            lastPage = 0;
          }
        }).catchError((e) {
          print(e);
        });
      }
    };
  }

  /**
   * 构建章节触摸监听部件
   */
  Listener getChapterListener(List<String> data, Widget child) {
    return Listener(
      onPointerDown: (event) {
        pointerStart = event.position.dx;
        print("down: ${event.position}");
      },
      onPointerMove: (event) {},
      onPointerUp: (event) {
        print("Up: ${event.position}");

        pointerEnd = event.position.dx;
        touchRange = (widget.reverse ? -1 : 1) * (pointerStart - pointerEnd);
        print("本次拖动距离： ${touchRange}");

        if (touchRange.abs() < 10) {
          return;
        }

        if ((touchRange < 0 && lastPage <= 0) ||
            (touchRange > 0 && lastPage >= data.length - 1)) {
          if (!widget.reverse) {
            if (widget.index == 0) {
              return;
            }
            if (touchRange < 0 &&
                lastPage <= 0 &&
                touchRange < -1 * screenWidth / 4) {
              if (!isWaitingJump) {
                Toast.toast(context,
                    msg: TOAST_CHAPTER_IMAGE_JUMP_PREVIOUS_TOUCH,
                    position: ToastPostion.bottom);
                postJumpWaitingDelay();
              } else {
                //跳转到上一章
                presenter.jumpPage(widget.index + 1, true);
              }
            } else if (touchRange > 0 &&
                lastPage >= data.length - 1 &&
                touchRange > screenWidth / 4) {
              if (!isWaitingJump) {
                Toast.toast(context,
                    msg: TOAST_CHAPTER_IMAGE_JUMP_NEXT_TOUCH,
                    position: ToastPostion.bottom);
                postJumpWaitingDelay();
              } else {
                //跳转到下一章
                presenter.jumpPage(widget.index - 1, false);
              }
            } else {
              return;
            }
          } else {
            if (touchRange < 0 &&
                lastPage <= 0 &&
                touchRange < -1 * screenWidth / 4) {
              if (!isWaitingJump) {
                Toast.toast(context,
                    msg: TOAST_CHAPTER_IMAGE_JUMP_NEXT_TOUCH,
                    position: ToastPostion.bottom);
                postJumpWaitingDelay();
              } else {
                //跳转到下一章
                presenter.jumpPage(widget.index - 1, false);
              }
            } else if (touchRange > 0 &&
                lastPage >= data.length - 1 &&
                touchRange > screenWidth / 4) {
              if (!isWaitingJump) {
                Toast.toast(context,
                    msg: TOAST_CHAPTER_IMAGE_JUMP_PREVIOUS_TOUCH,
                    position: ToastPostion.bottom);
                postJumpWaitingDelay();
              } else {
                //跳转到上一章
                presenter.jumpPage(widget.index + 1, true);
              }
            } else {
              return;
            }
          }
          return;
        }

        if (touchRange > screenWidth / 8) {
          nextOffset = screenWidth * (lastPage + 1);
          Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
//            print("前进执行完毕！");
            lastPage++;
          }).catchError((e) {
            print(e);
          });
        } else if (touchRange < -1 * screenWidth / 8) {
          nextOffset = screenWidth * (lastPage - 1);
          Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
//            print("回退执行完毕！");
            lastPage--;
            if (lastPage < 0) {
              lastPage = 0;
            }
          }).catchError((e) {
            print(e);
          });
        } else {
          nextOffset = screenWidth * lastPage;
          Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
            print("返回完毕！");
          }).catchError((e) {
            print(e);
          });
        }
      },
      child: child,
    );
  }

  Widget getFailedView() {
    return new Container(
      child: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: GestureDetector(
          child: Text(
            "连接错误...",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget getWaitingView() {
    return new Container(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          backgroundColor: Colors.blue,
          // value: 0.2,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    presenter.dettach();
  }

  /**
   * 构建图片
   */
  Widget buildImageItemView(String path, String pageStr, int lengthStr) {
    return Container(
      width: screenWidth,
      child: Stack(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              backgroundColor: Colors.blue,
              // value: 0.2,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          Center(
            child: Image.network(
                "http://49.234.76.105:80/spider/comic/chapter/image?path=${path}"),
          ),
          Positioned(
            child: Text(
              pageStr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              ),
            ),
            right: 10.0,
            bottom: 10.0,
          ),
        ],
      ),
    );
  }

  //延迟1000ms 等待跳转失效
  void postJumpWaitingDelay() {
    isWaitingJump = true;
    Future.delayed(
        Duration(
          seconds: 2,
        ), () {
      isWaitingJump = false;
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void hideSetupView() {
    setState(() {});
  }

  @override
  void showSetupView() {
    setState(() {});
  }

  /**
   * 判断触摸点是否在屏幕中间的设置区域
   */
  bool pointInSetupZone(Offset p) {
    if (p.dx >= (screenWidth * 2 / 5) && p.dx <= (screenWidth * 3 / 5)) {
      return true;
    }
    return false;
  }

  @override
  void jumpPage(int index, bool reverse) {
    setState(() {
      resetChapterInfo(index, reverse);
    });
  }
}
