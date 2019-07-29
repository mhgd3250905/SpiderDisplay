import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';
import 'package:spider_display/Modle/modle_huxiu_detail.dart';
import 'package:spider_display/Res/res_text_style.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/page_image_play.dart';
import 'package:transparent_image/transparent_image.dart';

Dio dio;

const TAG_DETAIL_HUXIU = "huxiu_detail";
const TAG_DETAIL_CHULE = "chule_detail";

class NewsDetailPage extends StatefulWidget {
  NewsBean huxiuNews;
  String tag;

  NewsDetailPage(this.huxiuNews, this.tag);

  @override
  _NewsDetailPageState createState() => new _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController;
  HuxiuDetail detail;
  GlobalKey<RefreshIndicatorState> _refreshIndicaterState =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    dio = new Dio();
    super.initState();
    detail = new HuxiuDetail([], widget.huxiuNews);
    getDataDelay();
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
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
            return buildMainContainer(context, detail, true);

          case ConnectionState.done:
            //完成状态
            if (snapshot.hasError) {
              //结果错误
              print("snapshot.hasErrpr: ${snapshot.error}");
            } else {
              detail = snapshot.data;
            }
            return buildMainContainer(context, detail, false);
        }
      },
      future: getData(),
    );
  }

  Scaffold buildMainContainer(
      BuildContext context, HuxiuDetail detail, bool isLoading) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: buildActions,
      ),
      body: RefreshIndicator(
        key: _refreshIndicaterState,
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              buildSliverAppBar(context),
              buildSliverTitle(context),
              buildSliverToBoxAdapter(detail),
            ],
          ),
        ),
        onRefresh: resetData,
      ),
    );
  }

  //构造Appbar 右侧按钮
  List<Widget> get buildActions {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.bookmark_border,
          color: Colors.black87,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.share,
          color: Colors.black87,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.black87,
        ),
        onPressed: () {
//          scrollController.animateTo(offset, duration: null, curve: null)
        },
      ),
    ];
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
    Response response =
        await dio.get(getHuxiuDetailUrl(widget.huxiuNews.newsId, widget.tag));
    HuxiuDetailBean bean =
        HuxiuDetailBean(response.data.toString().replaceAll("\n", ""));
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

  Widget buildSliverToBoxAdapter(HuxiuDetail detail) {
//    ListView listView = ListView.builder(
//      itemBuilder: (BuildContext context, int index) {
//        return buildContentItem(index, detail.contents[index]);
//      },
//      itemCount: detail.contents.length,
//      controller: scrollController,
//    );
    if (detail.contents.length == 0) {
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(top: 30.0),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              backgroundColor: Colors.blue,
              // value: 0.2,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return buildContentItem(index, detail.contents[index]);
        },
        childCount: detail.contents.length,
      ),
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    int timeMillis = int.parse(detail.huxiuNews.createTime);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeMillis * 1000);

//    return SliverPersistentHeader(
//      pinned: true,
//      floating: true,
//      delegate: SliverAppBarDelegate(
//        minHeight: 100.0,
//        maxHeight: 300.0,
//        child: Container(
//          margin: EdgeInsets.only(top: 10.0),
//          width: double.infinity,
//          child: Hero(
//            tag: detail.huxiuNews.newsId,
//            child: Image.network(
//              detail.huxiuNews.imageLink,
//              fit: BoxFit.cover,
//            ),
//          ),
//        ),
//      ),
//    );

    return SliverAppBar(
      /**
       * 如果没有leading,automaticallyImplyLeading为true,默认显示返回箭头
       * 如果没有leading,且设置为false,则没有箭头，空间留给title
       * 如果有leading，这个参数无效
       */
      automaticallyImplyLeading: false,
      leading: null,
      //标题
//          title: Text("Test SliverAppBar"),
      //标题是否居中
//      centerTitle: true,
//      elevation: 0.0,
      //是否显示阴影
      forceElevated: false,
      //背景颜色
      backgroundColor: Colors.transparent,
      /**
       * light: 白底黑字
       * dark: 黑底白字
       */
      brightness: Brightness.light,
      //图表风格
//      iconTheme: IconThemeData(
//        color: Colors.white,
//        size: 30.0,
//        opacity: 1,
//      ),
      //字体样式
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
        ),
      ),
      /**
       * appbar是否显示在屏幕最上面？
       * true:显示在状态栏下方
       * false:置顶
       */
      primary: true,
      //标题两边的空白区域
//      titleSpacing: 16.0,
      //默认高度是状态栏和导航的高度，如果有滚动视差的话就需要大于前二者
      expandedHeight: 200.0,
      //滑到最上面，再滑动是否隐藏导航栏的文字和标题等具体内容
      floating: false,
      //是否固定导航栏位置
      pinned: false,
      /**
       * false:线性的展开隐藏
       * true:下拉展开，上滑隐藏，触发式非线性
       */
      snap: false,
      flexibleSpace: new FlexibleSpaceBar(
//        title: Text(
//          "随内容一起滑动的头部",
//          style: TextStyle(
//            color: Colors.white,
//          ),
//        ),
        //头部图片
        background: Container(
          width: double.infinity,
          child: Hero(
            tag: detail.huxiuNews.newsId + detail.huxiuNews.createTime,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: detail.huxiuNews.imageLink,
              fit: BoxFit.cover,
            ),
          ),
        ),
        centerTitle: true,
        collapseMode: CollapseMode.pin,
      ),
    );
  }

  Widget buildSliverTitle(BuildContext context) {
    int timeMillis = int.parse(detail.huxiuNews.createTime);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeMillis * 1000);

    String timsStr = "${date.year}年${date.month}月${date.day}日 "
        "${date.hour < 10 ? "0" : ""}"
        "${date.hour}:"
        "${date.minute < 10 ? "0" : ""}"
        "${date.minute}";
    if (widget.tag == TAG_DETAIL_CHULE) {
      timsStr = "${date.year}年${date.month}月${date.day}日";
    }

    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: <Widget>[
            //时间
            Container(
              margin: const EdgeInsets.only(left: 10.0, top: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                timsStr,
                style: TextStyle(
                  fontSize: 13.0,
                  letterSpacing: 0.8,
                  decoration: TextDecoration.none,
                  color: Colors.black54,
                ),
              ),
            ),

            //标题
            Container(
              margin: const EdgeInsets.only(left: 10.0, top: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                detail.huxiuNews.title.replaceAll(" ", ""),
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
              margin: const EdgeInsets.only(left: 10.0, top: 15.0),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  detail.huxiuNews.author.authorImg.isEmpty
                      ? Container()
                      : Container(
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(0.5),
                              color: Colors.black54,
                              child: ClipOval(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: detail.huxiuNews.author.authorImg,
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
                      detail.huxiuNews.author.authorName,
                      style: TextStyle(
                        fontSize: 13.0,
                        letterSpacing: 0.8,
                        decoration: TextDecoration.none,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),

//            //头部图片
//            Container(
//              margin: EdgeInsets.only(top: 10.0),
//              width: double.infinity,
//              child: Hero(
//                tag: detail.huxiuNews.newsId,
//                child: Image.network(
//                  detail.huxiuNews.imageLink,
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
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
    List<Item> items = content.contentDetails;
    items.forEach((item) {
      item.contentDetail = stringToDBC(item.contentDetail);
    });

    DetailContainerType containerType =
        DetailContainerType.values[content.contentContainerType];

    //如果是正常文本
    if (content.contentContainerType == DetailContainerType.Img.index) {
//      print(content.contentDetails[0].extra);
      return InkWell(
        child: Hero(
          tag: content.contentDetails[0].extra,
          child: Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: double.infinity,
//        height: 300.0,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: content.contentDetails[0].extra,
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          NavigatorRouterUtils.pushToPage(
            context,
            ImageDisplayPage(
              imageLink: content.contentDetails[0].extra,
            ),
          );
        },
      );
    } else {
      return Container(
        margin: EdgeInsets.only(
            top: index == 0 || widget.tag == TAG_DETAIL_CHULE ? 10.0 : 0.0,
            bottom: index == 0 || widget.tag == TAG_DETAIL_CHULE ? 10.0 : 0.0,
            left: 16.0,
            right: 16.0),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(
            content.contentContainerType == DetailContainerType.Normal.index
                ? 0.0
                : 5.0),
        decoration: BoxDecoration(
          //显示北京
          border: Border(
              left: BorderSide(
                  color: content.contentContainerType ==
                          DetailContainerType.Blockquote.index
                      ? Colors.grey
                      : Colors.white,
                  width: content.contentContainerType ==
                          DetailContainerType.Blockquote.index
                      ? 5.0
                      : 0.0)),
        ),
        child: RichText(
          softWrap: true,
          text: TextSpan(
            children: items.asMap().keys.map((i) {
              String itemStr = items[i]
                  .contentDetail
                  .replaceAll("</br>", " ")
                  .replaceAll(" ", "");
              if (i == 0) {
                itemStr = itemStr;
              }
              return TextSpan(
                text: itemStr,
                style: buildItemTextStyle(items[i].textStyle, containerType),
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

String getHuxiuDetailUrl(String newsId, String tag) {
  String url = "http://49.234.76.105:80/spider/detail/${tag}/$newsId";
//  print(url);
  return url;
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  SliverAppBarDelegate({
    @required this.child,
    @required this.minHeight,
    @required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return new SizedBox.expand(
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
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
