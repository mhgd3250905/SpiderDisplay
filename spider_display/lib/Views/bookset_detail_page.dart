import 'package:flutter/material.dart';
import 'package:spider_display/Modle/test_content.dart';

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

class BookDetailPage extends StatelessWidget {
  final pos;

  BookDetailPage(this.pos);

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
            brightness: Brightness.light,
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
                "随内容一起滑动的头部",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              background: Container(
                child: Hero(
                  tag: "IMAGE${pos}",
                  child: Image.network(
                    BOOK_LIST_IMG_URL_ARR[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
            ),
          ),
//          SliverPersistentHeader(
//            pinned: false,
//            floating: true,
//            delegate: _SliverAppBarDelegate(
//              minHeight: 60.0,
//              maxHeight: 180.0,
//              child: Container(
//                child: Image.network(
//                  BOOK_LIST_IMG_URL_ARR[0],
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ),
          SliverToBoxAdapter(
            child: Container(
              child: Text(
                BOOK_DETAIL_JSON_STR,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
