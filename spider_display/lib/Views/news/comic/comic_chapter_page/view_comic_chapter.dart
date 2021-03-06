import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/view_toast.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Res/res_string.dart';
import 'package:spider_display/Views/news/comic/comic_chapter_page/presenter_comic_chapter.dart';
import 'package:spider_display/Views/news/comic/comic_chapter_page/widgets_comic_chapter.dart';

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
  Widget content;
  ComicChapterPresenter presenter;

  ScrollController _scrollController = new ScrollController();

  //设置按钮图标列表
  List<IconInfoBean> iconInfoArr;

  double screenWidth;
  double screenHeight;
  double nextOffset = 0;

  Offset pointerStart;
  Offset pointerEnd;
  double touchRangeX = 0;
  double touchRangeY = 0;

  //上一次停留位置
  int lastPage = 0;

  //当前获取并显示的章节
  Chapter _chapter;

  //是否处于上一章下一章提示等待时间
  bool isWaitingJump;

  //显示的图片地址列表
  ChapterDetail _chapterDetail;

  double sliderMax;

  double sliderValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    presenter = new ComicChapterPresenter();
    presenter.attach(this);

    //初始化默认章节信息
    resetChapterInfo(widget.index, widget.reverse);

    iconInfoArr = buildIconInfoArr();

//    _scrollController.addListener(() {
//      print("scroll: ${_scrollController.position.pixels}");
//    });
  }

  /**
   * 加载数据
   */
  void resetChapterInfo(int index, bool reverse) {
    lastPage = 0;
    nextOffset = 0;
    pointerStart;
    pointerEnd;
    touchRangeX = 0;
    touchRangeY = 0;

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
    screenHeight = screenSize.height;

    //获取Slider的最大值
    sliderMax =
        _chapterDetail == null ? 50.0 : _chapterDetail.data.length.toDouble();
    //获取Slider的选择值
    sliderValue =
        (widget.reverse ? _chapterDetail.data.length - lastPage : lastPage + 1)
            .toDouble();

    return Material(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            Container(
              child: GestureDetector(
                child: content,
                onTapDown: getViewTapDownCallback(),
              ),
            ),
            Positioned(
              child: ChapterAppbarView(
                title: widget.chapters[widget.index].name,
                show: presenter.isShowSetupView,
              ),
              top: 0.0,
              left: 0.0,
            ),
            Positioned(
              child: ChapterSetupView(
                show: presenter.isShowSetupView,
                chapterName: _chapter.name,
                sliderMax: sliderMax,
                sliderValue: sliderValue,
                reverse: widget.reverse,
                sliderValueChanged: buildSliderValueChanged,
                tapPrevious: buildTapPrevious,
                tapNext: buildTapNext,
                iconInfoBean: iconInfoArr,
              ),
              bottom: 0.0,
              left: 0.0,
            ),
            Positioned(
              child: buildChapterListContainer(widget.index,
                  presenter.isShowChapterListView, widget.chapters, () {
                //onTap
                if (presenter.isShowChapterListView) {
                  //如果设置界面未关闭，那么任何操作都需要先关闭设置界面
                  presenter.toggleChapterListView();
                  return;
                }
              }, (int index, bool reverse) {
                if (index == widget.index) {
                  if (presenter.isShowChapterListView) {
                    //如果设置界面未关闭，那么任何操作都需要先关闭设置界面
                    presenter.toggleChapterListView();
                  }
                } else {
                  resetChapterInfo(index, reverse);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * 设置下一页点击事件
   */
  void buildTapNext() {
    if (lastPage >= _chapterDetail.data.length - 1) {
      return;
    }
    scrollAnimToOffset(_scrollController, screenWidth * (lastPage + 1), () {
      setState(() {
        lastPage++;
        if (lastPage >= _chapterDetail.data.length - 1) {
          lastPage = _chapterDetail.data.length - 1;
        }
      });
    });
  }

  /**
   * 设置上一页点击事件
   */
  void buildTapPrevious() {
    if (lastPage <= 0) {
      return;
    }
    scrollAnimToOffset(_scrollController, screenWidth * (lastPage - 1), () {
      setState(() {
        lastPage--;
        if (lastPage < 0) {
          lastPage = 0;
        }
      });
    });
  }

  /**
   * 设置滑动触发事件
   */
  void buildSliderValueChanged(value) {
    int page = (widget.reverse ? _chapterDetail.data.length - value : value - 1)
        .toInt();
    _scrollController.jumpTo(screenWidth * page.toInt());
    lastPage = page.toInt();
  }

  /**
   * 滑动到指定位置
   */
  void scrollAnimToOffset(ScrollController controller, double offset,
      void Function() onScrollCompleted) {
    controller
        .animateTo(offset,
            duration: Duration(
              milliseconds: 200,
            ),
            curve: Curves.easeIn)
        .then((v) {
      if (onScrollCompleted != null) {
        onScrollCompleted();
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void loadDataSuccess(ChapterDetail chapter) {
    _chapterDetail = chapter;
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
        scrollDirection:
            presenter.isHorizontal ? Axis.horizontal : Axis.vertical,
        itemCount: data.length,
        semanticChildCount: 5,
        itemBuilder: (BuildContext context, int index) {
          String pageStr = "${_chapter.name} "
              "${widget.reverse ? (data.length - index) : (index + 1)}/${data.length}";
          return buildImageItemView(
            presenter.isHorizontal,
            data[index],
            presenter.isDarkMode,
            pageStr,
            data.length,
            screenWidth,
            screenHeight,
          );
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

      if (presenter.isShowSetupView) {
        //如果设置界面未关闭，那么任何操作都需要先关闭设置界面
        presenter.toggleSetupView();
        return;
      }

      //如果点击的区域是屏幕中间，那么就直接显示设置区域
      if (pointInSetupZone(e.globalPosition)) {
        presenter.toggleSetupView();
        return;
      }

      if (((lastPage <= 0) && (x < 2 * screenWidth / 5)) ||
          ((lastPage >= _chapterDetail.data.length - 1) &&
              (x > 3 * screenWidth / 5))) {
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
              lastPage >= _chapterDetail.data.length - 1) {
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
              lastPage >= _chapterDetail.data.length - 1) {
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
//          print("animate to ${nextOffset}");
        _scrollController
            .animateTo(nextOffset,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn)
            .then((T) {
//          print("前进执行完毕！");
          lastPage++;
          if (lastPage >= _chapterDetail.data.length - 1) {
            lastPage = _chapterDetail.data.length - 1;
          }
//          print("lastPage: ${lastPage}");
        }).catchError((e) {
          print(e);
        });
      } else {
        print("lastPage: ${lastPage}");
        nextOffset = screenWidth * (lastPage - 1);
//          print("animate to ${nextOffset}");
        _scrollController
            .animateTo(nextOffset,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn)
            .then((T) {
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
        pointerStart = event.position;
        print("down: ${event.position}");
      },
      onPointerMove: (event) {
        print("move: ${event.position}");
      },
      onPointerUp: presenter.isHorizontal
          ? getPonitUpListenerInHorizontal(data)
          : getPonitUpListenerInVertical(data),
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
  void toggleSetupView() {
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

  /*
    构建设置界面图标
   */
  List<IconInfoBean> buildIconInfoArr() {
    return <IconInfoBean>[
      IconInfoBean(
          iconData: presenter.isHorizontal
              ? Icons.keyboard_tab
              : Icons.vertical_align_bottom,
          onPressed: () {
            //喜爱
            presenter.toggleDirection();
//            Toast.toast(context,
//                msg: "点击了favorite", position: ToastPostion.bottom);
          },
          enable: false),
      IconInfoBean(
          iconData: Icons.menu,
          onPressed: () {
            //菜单
//            presenter.toggleSetupView();
            presenter.toggleChapterListView();
          },
          enable: false),
      IconInfoBean(
          iconData:
              presenter.isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
          onPressed: () {
            //切换明暗模式
//            Toast.toast(context,
//                msg: "点击了wb_sunny", position: ToastPostion.bottom);
            presenter.toggleDarkMode();
          },
          enable: false),
      IconInfoBean(
          iconData: Icons.settings,
          onPressed: () {
            //设置
            Toast.toast(context,
                msg: "点击了settings", position: ToastPostion.bottom);
          },
          enable: false),
    ];
  }

  @override
  void toggleDarkMode() {
    setState(() {
      iconInfoArr = buildIconInfoArr();
      content = getSuccessView(_chapterDetail.data);
    });
  }

  @override
  void toggleDirection() {
    setState(() {
      iconInfoArr = buildIconInfoArr();
      content = getSuccessView(_chapterDetail.data);
    });
  }

  /**
   * 构造横向滑动时候的触摸抬起监听
   */
  PointerUpEventListener getPonitUpListenerInHorizontal(List<String> data) {
    return (event) {
      print("Up: ${event.position}");

      pointerEnd = event.position;
      touchRangeX =
          (widget.reverse ? -1 : 1) * (pointerStart.dx - pointerEnd.dx);
      print("本次拖动距离X： ${touchRangeX}");
      touchRangeY =
          (widget.reverse ? -1 : 1) * (pointerStart.dy - pointerEnd.dy);
      print("本次拖动距离Y： ${touchRangeY}");

      //所有的操作必须要满足滑动距离>10才算是滑动
      if (touchRangeX.abs() < 10) {
        nextOffset = screenWidth * lastPage;
        scrollAnimToOffset(_scrollController, nextOffset, () {
          if (lastPage < 0) {
            lastPage = 0;
          }
        });
        return;
      }

      //纵向操作大于横向操作三倍视为纵向操作
      //这个判断拦截只有在纵向操作距离大于20.0的时候才生效
      if (touchRangeX.abs() < touchRangeY.abs() && touchRangeY.abs() > 20) {
        nextOffset = screenWidth * lastPage;
        scrollAnimToOffset(_scrollController, nextOffset, () {
          if (lastPage < 0) {
            lastPage = 0;
          }
        });
        return;
      }

      if (presenter.isShowSetupView) {
        //如果设置界面未关闭，那么任何操作都需要先关闭设置界面
        presenter.toggleSetupView();
        return;
      }

      //跳转到下一章或者上一章或者还原
      if ((touchRangeX < 0 && lastPage <= 0) ||
          (touchRangeX > 0 && lastPage >= data.length - 1)) {
        if (!widget.reverse) {
          if (widget.index == 0) {
            return;
          }
          if (touchRangeX < 0 &&
              lastPage <= 0 &&
              touchRangeX < -1 * screenWidth / 4) {
            if (!isWaitingJump) {
              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_PREVIOUS_TOUCH,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
            } else {
              //跳转到上一章
              presenter.jumpPage(widget.index + 1, true);
            }
          } else if (touchRangeX > 0 &&
              lastPage >= data.length - 1 &&
              touchRangeX > screenWidth / 4) {
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
          if (touchRangeX < 0 &&
              lastPage <= 0 &&
              touchRangeX < -1 * screenWidth / 4) {
            if (!isWaitingJump) {
              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_NEXT_TOUCH,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
            } else {
              //跳转到下一章
              presenter.jumpPage(widget.index - 1, false);
            }
          } else if (touchRangeX > 0 &&
              lastPage >= data.length - 1 &&
              touchRangeX > screenWidth / 4) {
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

      //跳转到下一页或者上一页或者不懂
      if (touchRangeX > screenWidth / 8) {
        nextOffset = screenWidth * (lastPage + 1);
//            print("animate to ${nextOffset}");
        scrollAnimToOffset(_scrollController, nextOffset, () {
          lastPage++;
          if (lastPage >= _chapterDetail.data.length - 1) {
            lastPage = _chapterDetail.data.length - 1;
          }
        });
      } else if (touchRangeX < -1 * screenWidth / 8) {
        nextOffset = screenWidth * (lastPage - 1);
//            print("animate to ${nextOffset}");

        scrollAnimToOffset(_scrollController, nextOffset, () {
          lastPage--;
          if (lastPage < 0) {
            lastPage = 0;
          }
        });
      } else {
        scrollAnimToOffset(_scrollController, screenWidth * lastPage, null);
      }
    };
  }

  /**
   * 构造纵向滑动滑动时候的触摸抬起监听
   * 纵向滑动的时候不需要智能识别到下一页，只需要判断上一章下一章就可以了
   */
  PointerUpEventListener getPonitUpListenerInVertical(List<String> data) {
    return (event) {
      print("Up: ${event.position}");

      pointerEnd = event.position;
      touchRangeY =
          (widget.reverse ? -1 : 1) * (pointerStart.dy - pointerEnd.dy);
      print("本次拖动距离Y： ${touchRangeY}");

      //所有的操作必须要满足滑动距离>10才算是滑动
      if (touchRangeY.abs() < 10) {
        return;
      }

      //纵向操作大于横向操作三倍视为纵向操作
      //这个判断拦截只有在纵向操作距离大于20.0的时候才生效
      if (touchRangeX.abs() > 20) {
        return;
      }

      if (presenter.isShowSetupView) {
        //如果设置界面未关闭，那么任何操作都需要先关闭设置界面
        presenter.toggleSetupView();
        return;
      }

      //跳转到下一章或者上一章或者还原
      if ((touchRangeY < 0 && lastPage <= 0) ||
          (touchRangeY > 0 && lastPage >= data.length - 1)) {
        if (!widget.reverse) {
          if (widget.index == 0) {
            return;
          }
          if (touchRangeY < 0 &&
              lastPage <= 0 &&
              touchRangeY < -1 * screenWidth / 6) {
            if (!isWaitingJump) {
              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_PREVIOUS_TOUCH,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
            } else {
              //跳转到上一章
              presenter.jumpPage(widget.index + 1, true);
            }
          } else if (touchRangeY > 0 &&
              lastPage >= data.length - 1 &&
              touchRangeY > screenWidth / 6) {
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
          if (touchRangeY < 0 &&
              lastPage <= 0 &&
              touchRangeY < -1 * screenWidth / 6) {
            if (!isWaitingJump) {
              Toast.toast(context,
                  msg: TOAST_CHAPTER_IMAGE_JUMP_NEXT_TOUCH,
                  position: ToastPostion.bottom);
              postJumpWaitingDelay();
            } else {
              //跳转到下一章
              presenter.jumpPage(widget.index - 1, false);
            }
          } else if (touchRangeY > 0 &&
              lastPage >= data.length - 1 &&
              touchRangeY > screenWidth / 6) {
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
    };
  }
}
