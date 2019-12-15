import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ClipImageView extends StatelessWidget {
  final String imgUrl;
  final BorderRadius borderRadius;

  ClipImageView(this.imgUrl, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ClipRRect(
      child: new FadeInImage.memoryNetwork(
        fit: BoxFit.cover,
        placeholder: kTransparentImage,
        image: imgUrl,
      ),
      borderRadius: borderRadius,
    );
  }
}

class ClipRadiusShadowImage extends StatelessWidget {
  final String url;
  BorderRadius borderRadius = BorderRadius.circular(5.0);

  ClipRadiusShadowImage({
    @required this.url,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
          ),
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
          )
        ],
      ),
      child: ClipImageView(
        url,
        borderRadius,
      ),
    );
  }
}
