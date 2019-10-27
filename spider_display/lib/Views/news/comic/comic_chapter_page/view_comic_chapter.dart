import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Views/news/comic/comic_book_page/i_comic_book_view.dart';
import 'package:spider_display/Views/news/comic/comic_chapter_page/presenter_comic_chapter.dart';
import 'package:transparent_image/transparent_image.dart';

class ComicChapterPage extends StatefulWidget {
  final String chapterId;

  ComicChapterPage({@required this.chapterId});

  @override
  _ComicChapterPageState createState() => new _ComicChapterPageState();
}

class _ComicChapterPageState extends State<ComicChapterPage>
    implements IComicBookView<ChapterDetail> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    content = getWaitingView();

    presenter = new ComicChapterPresenter();
    presenter.attach(this);
    presenter.showData(
        "http://49.234.76.105:80/spider/comic/chapter?id=${widget.chapterId}");
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print("screen width is ${screenSize.width}");
    screenWidth = screenSize.width;
    return content;
  }

  @override
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
    data = data.reversed.toList();
    return Listener(
      onPointerDown: (event) {
        pointerStart = event.position.dx;
      },
      onPointerMove: (event) {},
      onPointerUp: (event) {
        pointerEnd = event.position.dx;
        touchRange = pointerStart - pointerEnd;
//        print("本次拖动距离： ${touchRange}");
//        print("上次位置： ${lastOffset}");
        if (touchRange > screenWidth / 8) {
          nextOffset = screenWidth * (lastPage + 1);
          Future.delayed(Duration(seconds: 0), () {
            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
            print("前进执行完毕！");
            lastPage++;
          }).catchError((e) {
            print(e);
          });
        } else if (touchRange < -1 * screenWidth / 8) {
          nextOffset = screenWidth * (lastPage - 1);
          Future.delayed(Duration(seconds: 0), () {
            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
            print("回退执行完毕！");
            lastPage--;
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
//            print("返回完毕！");
          }).catchError((e) {
            print(e);
          });
        }
      },
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        semanticChildCount: 5,
        itemBuilder: (BuildContext context, int index) {
          String pageStr = "${index + 1}/${data.length}";
          return buildImageItemView(data[index], pageStr);
        },
      ),
    );
  }

  Widget getFailedView() {
    return new Container(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: GestureDetector(
          child: Text(
            "连接错误...",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
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
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    presenter.dettach();
  }

  /**
   * 构建图片
   */
  Widget buildImageItemView(String path, String pageStr) {
    return GestureDetector(
      onTapDown: (e) {
        double x = e.globalPosition.dx;
        double y = e.globalPosition.dy;
        print("${e.globalPosition}");
        if (x >= screenWidth / 2) {
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
        } else {
          nextOffset = screenWidth * (lastPage - 1);
          Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
//            print("回退执行完毕！");
            lastPage--;
          }).catchError((e) {
            print(e);
          });
        }
      },
      child: Container(
        width: screenWidth,
        child: Stack(
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    "http://49.234.76.105:80/spider/comic/chapter/image?path=${path}",
                fit: BoxFit.cover,
              ),
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
      ),
    );
  }
}
