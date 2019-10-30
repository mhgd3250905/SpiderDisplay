import 'package:flutter/material.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Views/news/comic/comic_book_page/presenter_comic_book.dart';
import 'package:spider_display/CustomView/comic_generic_view.dart';

import 'i_comic_book_view.dart';

class ComicBookPage extends StatefulWidget {
  @override
  _ComicBookPageState createState() => new _ComicBookPageState();
}

class _ComicBookPageState extends State<ComicBookPage>
    with AutomaticKeepAliveClientMixin
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
    presenter
        .showData("http://49.234.76.105:80/spider/comic/book?start=0&end=10");
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
    return Container(
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int i) {
          return getComicDescItemView(context, data[i]);
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
      color: Colors.white,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
