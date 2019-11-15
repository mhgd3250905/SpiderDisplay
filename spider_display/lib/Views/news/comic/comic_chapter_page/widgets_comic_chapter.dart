import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/view_toggle_widget.dart';
import 'package:spider_display/Modle/model_comic.dart';

typedef SliderValueChanged<T> = void Function(T);
typedef onChapterItemTap = void Function(int index, bool reverse);

class ChapterSetupView extends StatefulWidget {
  bool show;
  String chapterName;
  double sliderValue;
  double sliderMax;
  SliderValueChanged<double> sliderValueChanged;
  GestureTapCallback tapPrevious;
  GestureTapCallback tapNext;
  bool reverse;
  List<IconInfoBean> iconInfoBean;

  ChapterSetupView({
    @required this.show,
    @required this.chapterName,
    @required this.sliderValue,
    @required this.sliderMax,
    @required this.sliderValueChanged,
    @required this.tapPrevious,
    @required this.tapNext,
    @required this.reverse,
    @required this.iconInfoBean,
  });

  @override
  _ChapterSetupViewState createState() => new _ChapterSetupViewState();
}

class _ChapterSetupViewState extends State<ChapterSetupView>
    with TickerProviderStateMixin {
  double screenWidth;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: Duration(milliseconds: 200), vsync: this);
//    _animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
      controller.forward();
    } else {
      controller.reverse();
    }
    Size screenSize = MediaQuery.of(context).size;
//    print("screen width is ${screenSize.width}");
    screenWidth = screenSize.width;
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0.0, 1.0),
        end: Offset(0.0, 0.0),
      ).animate(controller),
      child: Container(
        color: Colors.black.withAlpha(200),
        width: screenWidth,
        child: buildSliderContainer(context),
      ),
    );
  }

  Container buildSliderContainer(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildInfoRow(),
          buildSliderRow(context),
          buildButtonRow(),
        ],
      ),
    );
  }

  /**
   * 构建漫画信息行
   */
  Widget buildInfoRow() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(10.0),
      child: Text(
        "${widget.chapterName} ${buildSliderLabel}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /**
   * 构建按钮图标行
   */
  Widget buildButtonRow() {
    return Row(
      children: widget.iconInfoBean.asMap().keys.map((i) {
        return buildButtonRowItem(
          widget.iconInfoBean[i].iconData,
          widget.iconInfoBean[i].onPressed,
          widget.iconInfoBean[i].enable,
        );
      }).toList(),
    );
  }

  /**
   * 构建可以点击的图标
   */
  Expanded buildButtonRowItem(
      IconData iconData, VoidCallback onPressed, bool enable) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: 60.0,
          child: AnimatedSwitcher(
            duration: Duration(
              milliseconds: 200,
            ),
            transitionBuilder: (child, anim) {
              return ScaleTransition(
                scale: anim,
                child: child,
              );
            },
            child: Icon(
              iconData,
              key: ValueKey(iconData),
              color: Colors.white,
            ),
          ),
        ),
      ),
//        IconButton(
//          icon: Icon(
//            iconData,
//            color: enable ? Colors.blue : Colors.white,
//          ),
//          onPressed: onPressed),
      flex: 1,
    );
  }

  /**
   * 构建包含Slider的一行
   * 功能是拖动跳转页面
   */
  Widget buildSliderRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: widget.tapPrevious,
            child: Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          Expanded(
            child: Listener(
              onPointerDown: (e) {},
              onPointerUp: (e) {
                widget.sliderValueChanged(widget.sliderValue);
              },
              child: SliderTheme(
                data: buildSliderTheme(context),
                child: Slider(
                  label: buildSliderLabel,
                  divisions: widget.sliderMax.toInt(),
                  value: widget.sliderValue,
                  max: widget.sliderMax,
                  min: 1,
                  onChanged: (value) {
                    setState(() {
                      widget.sliderValue = value;
                    });
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: widget.tapNext,
            child: Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 构建滑块滑动提示文字
   */
  String get buildSliderLabel {
    return "${widget.sliderValue.toInt()}"
        "/${widget.sliderMax.toInt()}";
  }

  /**
   * 构建Slider主题
   */
  SliderThemeData buildSliderTheme(BuildContext context) {
    return SliderTheme.of(context).copyWith(
      activeTickMarkColor: Colors.black87,
      inactiveTrackColor: Colors.white,
      thumbColor: Colors.blue,
      valueIndicatorColor: Colors.yellow,
      valueIndicatorTextStyle: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ChapterAppbarView extends StatefulWidget {
  final String title;
  final bool show;

  ChapterAppbarView({
    @required this.title,
    @required this.show,
  });

  @override
  _ChapterAppbarViewState createState() => new _ChapterAppbarViewState();
}

class _ChapterAppbarViewState extends State<ChapterAppbarView>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: Duration(milliseconds: 200), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
      controller.forward();
    } else {
      controller.reverse();
    }

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0.0, -1.0),
        end: Offset(0.0, 0.0),
      ).animate(controller),
      child: Container(
        width: screenWidth,
        child: AppBar(
          iconTheme: IconTheme.of(context).copyWith(
            color: Colors.white,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black.withAlpha(200),
        ),
      ),
    );
  }
}

/**
 * 构建图片
 */
Widget buildImageItemView(bool isHorizontal, String path, bool isDarkMode,
    String pageStr, int lengthStr, double screenWidth, double screenHeight) {
  return Container(
    margin: EdgeInsets.only(bottom: isHorizontal ? 0.0 : 10.0),
    width: screenWidth,
    child: Stack(
      children: <Widget>[
        Container(
          height: isHorizontal ? screenHeight : screenHeight / 2,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              backgroundColor: Colors.blue,
              // value: 0.2,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
        Center(
          child: Image.network(path),
        ),
        Visibility(
          visible: isDarkMode,
          child: GestureDetector(
            onTap: null,
            child: Container(
              color: Colors.black.withAlpha(80),
            ),
          ),
        ),
        Positioned(
          child: Visibility(
            visible: isHorizontal,
            child: Text(
              pageStr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          right: 10.0,
          bottom: 10.0,
        ),
      ],
    ),
  );
}

/**
 * 构建章节展示弹框
 */
Widget buildChapterListContainer(
    int curIndex,
    bool show,
    List<Chapter> chapters,
    GestureTapCallback onTap,
    onChapterItemTap onItemTap) {
  return ToggleWidgetView(
    child: buildChapterListView(curIndex, chapters, onTap, onItemTap),
    show: show,
    begin: Offset(0.0, 1.0),
    end: Offset(0.0, 0.0),
  );
}

Widget buildChapterListView(int curIndex, List<Chapter> chapters,
    GestureTapCallback onBgTap, onChapterItemTap onItemTap) {
  return GestureDetector(
    onTap: onBgTap,
    child: Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 400.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.black.withAlpha(200),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                ),
                itemCount: chapters.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    child: new ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        alignment: Alignment.center,
                        height: 20.0,
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          chapters[i].name,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.white, offset: Offset(0.2, 0.2))
                            ],
                          ),
                        ),
                      ),
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    onTap: () {
                      onItemTap(i, curIndex > i);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/**
 * 管理底部按钮状态的类
 */
class IconInfoBean {
  IconData iconData;
  VoidCallback onPressed;
  bool enable;

  IconInfoBean(
      {@required this.iconData,
      @required this.onPressed,
      @required this.enable});
}
