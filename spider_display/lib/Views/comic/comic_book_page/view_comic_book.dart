import 'package:flutter/material.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/comic/comic_book_page/presenter_comic_book.dart';
import 'package:spider_display/Views/comic/comic_chapter_list_page/view_comic_chapter_list.dart';

import 'i_comic_book_view.dart';

class ComicBookPage extends StatefulWidget {
  @override
  _ComicBookPageState createState() => new _ComicBookPageState();
}

class _ComicBookPageState extends State<ComicBookPage>
    implements IComicBookView<ComicList> {
  List<Book> dataList;
  Widget content;
  ComicBookPresenter presenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    content = getWaitingView();

    presenter = new ComicBookPresenter();
    presenter.attach(this);
    presenter.showData("http://49.234.76.105:80/spider/comic/book");
  }

  @override
  Widget build(BuildContext context) {
    return content;
  }

  @override
  void loadDataSuccess(ComicList comicList) {
    content = getSuccessView(comicList.data);
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

  Widget getSuccessView(List<Book> data) {
    return new Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              child: GestureDetector(
                onTap: () {
                  NavigatorRouterUtils.pushToPage(
                    context,
//                    ComicChapterPage(
//                      chapterId: "452607",
//                    ),
                    ComicChapterListPage(
                      book: data[i],
                    ),
                  );
                },
                child: Image.network(data[i].image_link),
              ),
            );
          }),
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
