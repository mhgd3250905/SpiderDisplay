import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Views/huxiu_list_page.dart';

class ChuleItemView extends StatefulWidget {
  final NewsBean huxiuNews;

  ChuleItemView(this.huxiuNews);

  @override
  _ChuleItemViewState createState() => new _ChuleItemViewState();
}

class _ChuleItemViewState extends State<ChuleItemView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                child: Hero(
                  tag: widget.huxiuNews.newsId + widget.huxiuNews.createTime,
                  child: Image.network(
                    widget.huxiuNews.imageLink
                        .replaceAll("w/390/h/219", "w/600/h/320"),
                    fit: BoxFit.cover,
                  ),
                ),
                left: 0.0,
                top: 0.0,
                right: 0.0,
                bottom: 0.0,
              ),
              Column(
                children: <Widget>[
                  buildCategorysItemView(widget.huxiuNews),
                  Container(
                    height: widget.huxiuNews.category == null
                        ? 80.0
                        : widget.huxiuNews.category.length >= 1 ? 80.0 : 100.0,
                  ),
                  buildAuthorItemView(widget.huxiuNews),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Text(
                      widget.huxiuNews.title.trim(),
                      style: TextStyle(
                          letterSpacing: 0.8,
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0.5, 0.5),
                              blurRadius: 4.0,
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 15.0),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Text(
                      widget.huxiuNews.desc.trim(),
                      style: TextStyle(
                        letterSpacing: 0.8,
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget buildCategorysItemView(NewsBean huxiuNews) {
    List<Widget> categoryViews = [];
    if (huxiuNews.category == null) {
      return Container();
    }
    huxiuNews.category.forEach((category) {
      categoryViews.add(Container(
        margin: const EdgeInsets.only(left: 10.0, top: 15.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          category.categoryName,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                color: Colors.black,
                offset: Offset(0.5, 0.5),
                blurRadius: 4.0,
              ),
            ],
          ),
        ),
      ));
    });
    return Container(
      child: Row(
        children: categoryViews,
      ),
    );
  }

  Widget buildAuthorItemView(NewsBean huxiuNews) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          //作者头像
//          Container(
//            margin: const EdgeInsets.only(left: 10.0),
//            child: ClipOval(
//              child: Container(
//                padding: const EdgeInsets.all(1.0),
//                color: Colors.white,
//                child: ClipOval(
//                  child: Image.network(
//                    huxiuNews.author.authorImg,
//                    fit: BoxFit.cover,
//                    width: 15.0,
//                    height: 15.0,
//                  ),
//                ),
//              ),
//            ),
//          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(
              huxiuNews.author.authorName,
              style: titleStyle.copyWith(
                fontSize: 13.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
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
