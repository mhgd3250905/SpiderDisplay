import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/page_news_detail.dart';
import 'package:spider_display/Views/view_chule_item.dart';
import 'package:spider_display/Views/view_huxiu_item.dart';
import 'package:spider_display/Views/view_loadmore_list.dart';

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

const TAG_HUXIU = "huxiu";
const TAG_CHULE = "chule";

class NewsListPage extends StatelessWidget {
  String tag;
  List<NewsBean> newsList;
  ScrollController scrollController;

  NewsListPage(this.tag, this.newsList, this.scrollController) {
    if (scrollController == null) {
      scrollController = new ScrollController();
    }
  }

  /**
   * 构建列表ItemView
   */
  Widget buildNewsListItemView(NewsBean news, int pos) {
    switch (tag) {
      case TAG_HUXIU:
        return HuxiuNewsItemView(news);
      case TAG_CHULE:
        return ChuleItemView(news);
      default:
        return HuxiuNewsItemView(news);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: LoadMoreListView(
        builder: (context, i) {
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
                  child: buildNewsListItemView(newsList[i], i),
                  onTap: () {
//                      HuxiuDetail detial =
//                          HuxiuDetail.fromJson(json.decode(HUXIU_DETAIL_STR));
//                      detial.huxiu_news = huxiuNewsList[i];
                    NavigatorRouterUtils.pushToPage(
                        context, NewsDetailPage(newsList[i], "${tag}_detail"));
                  },
                ),
              ),
            ),
          );
        },
        childCount: newsList.length,
        loadMoreFunc: (){

        },
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
