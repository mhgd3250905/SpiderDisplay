import 'package:flutter/material.dart';
import 'package:spider_display/Modle/modle_huxiu_detail.dart';

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

class HuxiuDetailPage extends StatelessWidget {
  HuxiuDetail detail;

  HuxiuDetailPage(this.detail);

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
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          //左侧按键
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            /**
             * 如果没有leading,automaticallyImplyLeading为true,默认显示返回箭头
             * 如果没有leading,且设置为false,则没有箭头，空间留给title
             * 如果有leading，这个参数无效
             */
            automaticallyImplyLeading: true,
            //标题
//          title: Text("Test SliverAppBar"),
            //标题是否居中
            centerTitle: true,
            //右侧按钮
            actions: <Widget>[
              Icon(Icons.share),
            ],
            //阴影高度
            elevation: 0.0,
            //是否显示阴影
            forceElevated: false,
            //背景颜色
            backgroundColor: Colors.transparent,
            /**
             * light: 白底黑字
             * dark: 黑底白字
             */
            brightness: Brightness.dark,
            //图表风格
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 30.0,
              opacity: 1,
            ),
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
            titleSpacing: 16.0,
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
              title: Text(
                detail.huxiu_news.title,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              background: Container(
                child: Hero(
                  tag: detail.huxiu_news.image_link,
                  child: Image.network(
                    detail.huxiu_news.image_link,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 10.0, top: 8.0, bottom: 8.0, right: 10.0),
              child: Column(
                children: buildContentList(detail.contents),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //构建内容列表
  List<Widget> buildContentList(List<Content> contents) {
    List<Widget> widgets = [];

    contents.forEach((Content content) {
      widgets.add(buildContentItem(content));
    });

    return widgets;
  }

  //构建内容条目
  Widget buildContentItem(Content content) {
    List<Item> items = content.content_details;
    DetailContainerType containerType =
        DetailContainerType.values[content.content_container_type];
    //如果是正常文本
    if (content.content_container_type == DetailContainerType.Img.index) {
      return Container(
        width: double.infinity,
        height: 300.0,
        child: Image.network(
          content.content_details[0].extra,
        ),
      );
    } else {
      return Container(
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

  TextStyle buildItemTextStyle(
      int text_style, DetailContainerType containerType) {
    TextStyle style = TextStyle(
      fontSize: 16.0,
      color: Colors.black87,
    );
    DetailTextType textType = DetailTextType.values[text_style];
    switch (textType) {
      case DetailTextType.Normal:
        break;
      case DetailTextType.ImgNote:
        style = style.copyWith(
          fontSize: 14.0,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        );
        break;
      case DetailTextType.ParagraphTitle:
        style = style.copyWith(
          fontSize: 20.0,
          color: Colors.deepOrange,
        );
        break;
      case DetailTextType.Br:
        break;
      case DetailTextType.Img:
        break;
      case DetailTextType.Span:
        style = style.copyWith(
          fontSize: 16.0,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        );
        break;
      case DetailTextType.Link:
        style = style.copyWith(
          fontSize: 16.0,
          color: Colors.blueAccent,
        );
        break;
      case DetailTextType.Bold:
        style = style.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
        break;
    }
    if (containerType == DetailContainerType.Blockquote) {
      style = style.copyWith(
        fontSize: 16.0,
        color: Colors.grey,
        fontStyle: FontStyle.italic,
      );
    }
    return style;
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
