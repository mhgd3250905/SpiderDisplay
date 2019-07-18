import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Modle/modle_huxiu_detail.dart';
import 'package:spider_display/Res/res_text_style.dart';
import 'package:spider_display/Views/huxiu_list_page.dart';

int double_score_c_ount;
double douban_score;
String author;
String douban_link;
String download_link_azw3;
String download_link_epub;
String download_link_mobi;
String image;
String introduction;
String time;
String title;

class HuxiuDetailPage extends StatefulWidget {
  HuxiuNews huxiuNews;

  HuxiuDetailPage(this.huxiuNews);

  @override
  _HuxiuDetailPageState createState() => new _HuxiuDetailPageState();
}

class _HuxiuDetailPageState extends State<HuxiuDetailPage>
    with AutomaticKeepAliveClientMixin {
  HuxiuDetail detail;
  GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    detail = new HuxiuDetail([], widget.huxiuNews);
    getDataDelay();
  }

  FutureBuilder<HuxiuDetail> buildFutureBuilder() {
    return FutureBuilder<HuxiuDetail>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        ConnectionState state = snapshot.connectionState;
        switch (state) {
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.none:
            //等待状态
            return RefreshIndicator(
              key: _refreshIndicaterState,
              child: Container(
                color: Colors.white,
                child: CustomScrollView(
                  slivers: <Widget>[
                    buildSliverAppBar(context),
                    buildSliverToBoxAdapter(detail),
                  ],
                ),
              ),
              onRefresh: resetData,
            );

          case ConnectionState.done:
            //完成状态
            if (snapshot.hasError) {
              //结果错误
              print("snapshot.hasErrpr: ${snapshot.error}");
            } else {
              detail = snapshot.data;
            }
            return RefreshIndicator(
              key: _refreshIndicaterState,
              child: Container(
                color: Colors.white,
                child: CustomScrollView(
                  slivers: <Widget>[
                    buildSliverAppBar(context),
                    buildSliverToBoxAdapter(detail),
                  ],
                ),
              ),
              onRefresh: resetData,
            );
        }
      },
      future: getData(),
    );
  }

  ///延迟300ms获取数据，避免引起动画卡顿
  Future<HuxiuDetail> getDataDelay() async {
    Future.delayed(Duration(milliseconds: 300), () {
      resetData();
      setState(() {});
    });
  }

  ///进入时候展示外部的图片
  Future<HuxiuDetail> getData() async {
//    var dio = new Dio();
//    Response response =
//        await dio.get(getHuxiuDetailUrl(widget.huxiuNews.news_id));
//    HuxiuDetailBean bean = HuxiuDetailBean(response.data);
//    return bean.data[0];
    return detail;
  }

  ///重置数据
  Future<HuxiuDetail> resetData() async {
    var dio = new Dio();
    Response response =
        await dio.get(getHuxiuDetailUrl(widget.huxiuNews.news_id));
    HuxiuDetailBean bean = HuxiuDetailBean(response.data);
    detail = bean.data[0];
    setState(() {});
  }

  List<Widget> getAppBarMenuBtns() {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.share,
          color: Colors.white,
        ),
        onPressed: () {
          //跳转到分享页面
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return buildFutureBuilder();
  }

  SliverToBoxAdapter buildSliverToBoxAdapter(HuxiuDetail detail) {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: buildContentList(detail.contents),
        ),
      ),
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    int timeMillis = int.parse(detail.huxiu_news.create_time);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeMillis * 1000);
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: <Widget>[
            //头部图片
            Hero(
              tag: detail.huxiu_news.news_id,
              child: Image.network(
                detail.huxiu_news.image_link,
                fit: BoxFit.cover,
              ),
            ),
            //时间
            Container(
              margin: const EdgeInsets.only(left: 10.0,top: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute}",
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 0.8,
                  decoration: TextDecoration.none,
                  color: Colors.black87,
                ),
              ),
            ),

            //标题
            Container(
              margin: const EdgeInsets.only(left: 10.0,top: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                detail.huxiu_news.title.replaceAll(" ", ""),
                style: TextStyle(
                  fontSize: 24.0,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  color: Colors.black87,
                ),
              ),
            ),

            //作者
            Container(
              margin: const EdgeInsets.only(left: 10.0,top: 8.0),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(0.5),
                        color: Colors.black87,
                        child: ClipOval(
                          child: Image.network(
                            detail.huxiu_news.author.author_img,
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
                      detail.huxiu_news.author.author_name,
                      style: TextStyle(
                        fontSize: 13.0,
                        letterSpacing: 0.8,
                        decoration: TextDecoration.none,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
//    return SliverAppBar(
//      leading: IconButton(
//        icon: Icon(Icons.arrow_back),
//        onPressed: () {
//          Navigator.pop(context);
//        },
//      ),
//      /**
//       * 如果没有leading,automaticallyImplyLeading为true,默认显示返回箭头
//       * 如果没有leading,且设置为false,则没有箭头，空间留给title
//       * 如果有leading，这个参数无效
//       */
//      automaticallyImplyLeading: true,
//      //标题
////          title: Text("Test SliverAppBar"),
//      //标题是否居中
//      centerTitle: true,
//      //右侧按钮
//      actions: <Widget>[
//        Icon(Icons.share),
//      ],
//      //阴影高度
//      elevation: 0.0,
//      //是否显示阴影
//      forceElevated: false,
//      //背景颜色
//      backgroundColor: Colors.transparent,
//      /**
//       * light: 白底黑字
//       * dark: 黑底白字
//       */
//      brightness: Brightness.dark,
//      //图表风格
//      iconTheme: IconThemeData(
//        color: Colors.white,
//        size: 30.0,
//        opacity: 1,
//      ),
//      //字体样式
//      textTheme: TextTheme(
//        title: TextStyle(
//          color: Colors.white,
//        ),
//      ),
//      /**
//       * appbar是否显示在屏幕最上面？
//       * true:显示在状态栏下方
//       * false:置顶
//       */
//      primary: true,
//      //标题两边的空白区域
//      titleSpacing: 16.0,
//      //默认高度是状态栏和导航的高度，如果有滚动视差的话就需要大于前二者
//      expandedHeight: 200.0,
//      //滑到最上面，再滑动是否隐藏导航栏的文字和标题等具体内容
//      floating: false,
//      //是否固定导航栏位置
//      pinned: false,
//      /**
//       * false:线性的展开隐藏
//       * true:下拉展开，上滑隐藏，触发式非线性
//       */
//      snap: false,
//      flexibleSpace: new FlexibleSpaceBar(
////        title: Text(
////          detail.huxiu_news.title,
////          style: TextStyle(
////            fontSize: 16.0,
////            color: Colors.white,
////          ),
////        ),
//        background: Container(
//          child: Hero(
//            tag: detail.huxiu_news.news_id,
//            child: Image.network(
//              detail.huxiu_news.image_link,
//              fit: BoxFit.cover,
//            ),
//          ),
//        ),
//        centerTitle: true,
//        collapseMode: CollapseMode.pin,
//      ),
//    );
  }

  //构建内容列表
  List<Widget> buildContentList(List<Content> contents) {
    List<Widget> widgets = [];

    contents.asMap().keys.forEach((int index) {
      widgets.add(buildContentItem(index, contents[index]));
    });

    return widgets;
  }

  //构建内容条目
  Widget buildContentItem(int index, Content content) {
    List<Item> items = content.content_details;
    items.forEach((item) {
      item.content_detail = stringToDBC(item.content_detail);
    });

    DetailContainerType containerType =
        DetailContainerType.values[content.content_container_type];

    //如果是正常文本
    if (content.content_container_type == DetailContainerType.Img.index) {
      return Container(
        width: double.infinity,
//        height: 300.0,
        child: Image.network(
          content.content_details[0].extra,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(
            top: index == 0 ? 8.0 : 0.0,
            bottom: index == 0 ? 8.0 : 0.0,
            left: 10.0,
            right: 10.0),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(
            content.content_container_type == DetailContainerType.Normal.index
                ? 0.0
                : 5.0),
        decoration: BoxDecoration(
          //显示北京
          border: Border(
              left: BorderSide(
                  color: content.content_container_type ==
                          DetailContainerType.Normal.index
                      ? Colors.white
                      : Colors.grey,
                  width: content.content_container_type ==
                          DetailContainerType.Normal.index
                      ? 0.0
                      : 5.0)),
        ),
        child: RichText(
          softWrap: true,
          text: TextSpan(
            children: items.asMap().keys.map((i) {
              String itemStr = items[i]
                  .content_detail
                  .replaceAll("</br>", " ")
                  .replaceAll(" ", "");
              if (i == 0) {
                itemStr = itemStr;
              }
              return TextSpan(
                text: itemStr,
                style: buildItemTextStyle(items[i].text_style, containerType),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  //根据不同的类型构建不同的文本样式
  TextStyle buildItemTextStyle(
      int text_style, DetailContainerType containerType) {
    TextStyle style = TextStyle(
      fontSize: TextFontsize_Normal,
      color: Colors.black87,
      letterSpacing: 0.8,
    );
    DetailTextType textType = DetailTextType.values[text_style];
    switch (textType) {
      case DetailTextType.Normal:
        break;
      case DetailTextType.ImgNote:
        style = style.copyWith(
          fontSize: TextFontsize_Imgnote,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        );
        break;
      case DetailTextType.ParagraphTitle:
        style = style.copyWith(
          fontSize: TextFontsize_ParagraphTitle,
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
        );
        break;
      case DetailTextType.Br:
        break;
      case DetailTextType.Img:
        break;
      case DetailTextType.Span:
        style = style.copyWith(
          fontSize: TextFontsize_Span,
          color: Colors.grey,
          fontStyle: FontStyle.normal,
        );
        break;
      case DetailTextType.Link:
        style = style.copyWith(
          fontSize: TextFontsize_Normal,
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
        );
        break;
      case DetailTextType.Bold:
        style = style.copyWith(
          fontSize: TextFontsize_Normal,
          fontWeight: FontWeight.bold,
        );
        break;
    }
    if (containerType == DetailContainerType.Blockquote) {
      style = style.copyWith(
        fontSize: TextFontsize_Blockquote,
        color: Colors.grey,
        fontStyle: FontStyle.italic,
      );
    }
    return style;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  String stringToDBC(String s) {
    List<int> cArr = s.codeUnits;
    List<int> temp = [];
    for (int i = 0; i < cArr.length; i++) {
      if (cArr[i] == 12288) {
        temp.add(32);
        continue;
      }
      if (cArr[i] > 65280 && cArr[i] < 65375) {
        temp.add(cArr[i] - 65248);
      } else {
        temp.add(cArr[i]);
      }
    }
    String tempStr = String.fromCharCodes(temp);
    return tempStr;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({this.minHeight, this.maxHeight, this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

String getHuxiuDetailUrl(String newsId) {
  String url = "http://49.234.76.105:80/spider/detail/huxiu_detail/$newsId";
  print(url);
  return url;
}
