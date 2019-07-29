import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

/**
 * created by ksheng
 * on 2019/7/29
 * note 展示图片
 **/
class ImageDisplayPage extends StatefulWidget {
  final imageLink;

  ImageDisplayPage({@required this.imageLink});

  @override
  _ImageDisplayPageState createState() => new _ImageDisplayPageState();
}

class _ImageDisplayPageState extends State<ImageDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        child: Center(
          child: Container(
            color: Colors.black,
            child: Hero(
              tag: widget.imageLink,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.imageLink,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        color: Colors.black,
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
