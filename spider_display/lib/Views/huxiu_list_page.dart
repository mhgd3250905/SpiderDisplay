import 'package:flutter/material.dart';
import 'package:spider_display/Modle/huxiu_modle.dart';

const TextStyle titleStyle = TextStyle(
    letterSpacing: 1.0,
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        color: Colors.black,
        offset: Offset(0.5, 0.5),
        blurRadius: 4.0,
      ),
    ]);

class HuxiuNewsListPage extends StatelessWidget {
  List<HuxiuNews> huxiuNewsList;
  ScrollController scrollController;

  HuxiuNewsListPage(this.huxiuNewsList, this.scrollController) {
    if (scrollController == null) {
      scrollController = new ScrollController();
    }
  }

  /**
   * 构建列表ItemView
   */
  Widget buildHuxiuListItemView(HuxiuNews huxiuNews, int pos) {
    return HuxiuNewsItemView_2(huxiuNews, pos);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: ListView.builder(
          controller: scrollController,
          itemCount: huxiuNewsList.length,
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
              margin: i == 0
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.only(top: 1.0),
              child: Material(
                child: Ink(
                  child: InkWell(
                    child: buildHuxiuListItemView(huxiuNewsList[i], i),
                    onTap: () {},
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class HuxiuNewsItemView extends StatefulWidget {
  final HuxiuNews huxiuNews;
  final pos;

  HuxiuNewsItemView(this.huxiuNews, this.pos);

  @override
  _HuxiuNewsItemViewState createState() => new _HuxiuNewsItemViewState();
}

class _HuxiuNewsItemViewState extends State<HuxiuNewsItemView>
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
                      widget.huxiuNews.image_link,
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
                        child: Text('${widget.huxiuNews.title}'),
                      ),
                      //纵向占满
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text('${widget.huxiuNews.author.author_name}'),
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

class HuxiuNewsItemView_2 extends StatefulWidget {
  final HuxiuNews huxiuNews;
  final pos;

  HuxiuNewsItemView_2(this.huxiuNews, this.pos);

  @override
  _HuxiuNewsItemView_2State createState() => new _HuxiuNewsItemView_2State();
}

class _HuxiuNewsItemView_2State extends State<HuxiuNewsItemView_2>
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
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.huxiuNews.image_link
                    .replaceAll("w/400/h/225", "w/800/h/450"),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              buildCategorysItemView(widget.huxiuNews),
              Container(
                height: 60.0,
              ),
              buildAuthorItemView(widget.huxiuNews),
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 15.0),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text(
                  widget.huxiuNews.title.trim(),
                  style: TextStyle(
                      letterSpacing: 1.0,
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
//              Container(
//                margin: const EdgeInsets.only(
//                    left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
//                alignment: Alignment.centerLeft,
//                width: double.infinity,
//                child: Text(
//                  widget.huxiuNews.desc
//                      .trim()
//                      .replaceAll(" ", "")
//                      .replaceAll("\n", " ")
//                      .replaceAll("\r", ""),
//                  style: TextStyle(
//                      fontSize: 13.0,
//                      color: Colors.white,
//                      shadows: <Shadow>[
//                        Shadow(
//                          color: Colors.black,
//                          offset: Offset(0.5, 0.5),
//                          blurRadius: 4.0,
//                        ),
//                      ]),
//                ),
//              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget buildCategorysItemView(HuxiuNews huxiuNews) {
    List<Widget> categoryViews = [];
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
          category.category_name,
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

  Widget buildAuthorItemView(HuxiuNews huxiuNews) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(1.0),
                color: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    huxiuNews.author.author_img,
                    fit: BoxFit.cover,
                    width: 15.0,
                    height: 15.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5.0),
            child: Text(
              huxiuNews.author.author_name,
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
