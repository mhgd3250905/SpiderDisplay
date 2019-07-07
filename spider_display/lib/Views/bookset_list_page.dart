import 'package:flutter/material.dart';
import 'package:spider_display/Modle/bookset_modle.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/bookset_detail_page.dart';

class BooksetListPage extends StatefulWidget {
  List<Book> bookList;
  ScrollController scrollController;

  BooksetListPage(this.bookList, this.scrollController) {
    if (scrollController == null) {
      scrollController = new ScrollController();
    }
  }

  @override
  _BooksetListPageState createState() => new _BooksetListPageState();
}

class _BooksetListPageState extends State<BooksetListPage>
    with AutomaticKeepAliveClientMixin {
  /**
   * 构建列表ItemView
   */
  Widget buildBookListItemView(Book book, int pos) {
    return BookItemView(book, pos);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: ListView.builder(
          controller: widget.scrollController,
          itemCount: widget.bookList.length,
          itemBuilder: (BuildContext context, int i) {
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
                    child: buildBookListItemView(widget.bookList[i], i),
                    onTap: () {
                      NavigatorRouterUtils.pushToPage(
                          context, BookDetailPage(i));
                    },
                  ),
                ),
              ),
            );
          }),
    );
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
