import 'package:flutter/material.dart';

typedef SliderValueChanged<T> = void Function(T);

class ChapterSetupView extends StatefulWidget {
  double sliderValue;
  double sliderMax;
  SliderValueChanged<double> sliderValueChanged;
  GestureTapCallback tapPrevious;
  GestureTapCallback tapNext;
  bool reverse;

  ChapterSetupView({
    @required this.sliderValue,
    @required this.sliderMax,
    @required this.sliderValueChanged,
    @required this.tapPrevious,
    @required this.tapNext,
    @required this.reverse,
  });

  @override
  _ChapterSetupViewState createState() => new _ChapterSetupViewState();
}

class _ChapterSetupViewState extends State<ChapterSetupView> {
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print("screen width is ${screenSize.width}");
    screenWidth = screenSize.width;
    return Container(
      color: Colors.grey[500],
      width: screenWidth,
      child: Column(
        children: <Widget>[
          buildSliderContainer(context),
        ],
      ),
    );
  }

  Container buildSliderContainer(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: widget.tapPrevious,
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Listener(
              onPointerDown: (e) {},
              onPointerUp: (e) {
                widget.sliderValueChanged(widget.sliderValue);
              },
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTickMarkColor: Colors.black87,
                  inactiveTrackColor: Colors.white,
                  thumbColor: Colors.blue,
                  valueIndicatorColor: Colors.yellow,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Slider(
                  label: "${widget.sliderValue.toInt()}"
                      "/${widget.sliderMax.toInt()}",
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
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/**
 * 构建图片
 */
Widget buildImageItemView(
    String path, String pageStr, int lengthStr, double screenWidth) {
  return Container(
    width: screenWidth,
    child: Stack(
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 4.0,
            backgroundColor: Colors.blue,
            // value: 0.2,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        Center(
          child: Image.network(
              "http://49.234.76.105:80/spider/comic/chapter/image?path=${path}"),
        ),
        Positioned(
          child: Text(
            pageStr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
          ),
          right: 10.0,
          bottom: 10.0,
        ),
      ],
    ),
  );
}
