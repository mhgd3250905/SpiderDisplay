import 'package:flutter/material.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Views/comic/comic_book_page/i_comic_book_view.dart';
import 'package:spider_display/Views/comic/comic_chapter_page/presenter_comic_chapter.dart';

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
  double lastOffset = 0;

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
          nextOffset = screenWidth * ((lastOffset / screenWidth).toInt() + 1);
          Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
//            print("前进执行完毕！");
            lastOffset = nextOffset;
          });
        } else if (touchRange < -1 * screenWidth / 8) {
          nextOffset = screenWidth * (lastOffset / screenWidth).toInt() - 1;
          Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
//            print("回退执行完毕！");
            lastOffset = nextOffset;
          });
        } else {
          nextOffset = lastOffset;
          Future.delayed(Duration(seconds: 0), () {
//            print("animate to ${nextOffset}");
            _scrollController.animateTo(nextOffset,
                duration: Duration(milliseconds: 100), curve: Curves.linear);
          }).then((T) {
//            print("返回完毕！");
            lastOffset = nextOffset;
          });
        }
      },
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        semanticChildCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: screenWidth,
            child: Image.network(
                "http://49.234.76.105:80/spider/comic/chapter/image?path=${data[index]}"),
          );
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
}
