import 'dart:convert' show json;


import 'modle_huxiu.dart';

class HuxiuDetailBean {
  int err_code;
  String error;
  List<HuxiuDetail> data;

  HuxiuDetailBean.fromParams({this.err_code, this.error, this.data});

  factory HuxiuDetailBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new HuxiuDetailBean.fromJson(json.decode(jsonStr))
          : new HuxiuDetailBean.fromJson(jsonStr);

  HuxiuDetailBean.fromJson(jsonRes) {
    err_code = jsonRes['err_code'];
    error = jsonRes['error'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new HuxiuDetail.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"err_code": $err_code,"error": ${error != null ? '${json.encode(error)}' : 'null'},"data": $data}';
  }
}

class HuxiuDetail {
  List<Content> contents;
  NewsBean huxiuNews;

  int getLength() {
    if (contents == null) {
      return 0;
    } else {
      return contents.length;
    }
  }

  HuxiuDetail(this.contents, this.huxiuNews);

  HuxiuDetail.fromParams({this.contents, this.huxiuNews});

  HuxiuDetail.fromJson(jsonRes) {
    contents = jsonRes['contents'] == null ? null : [];

    for (var contentsItem in contents == null ? [] : jsonRes['contents']) {
      contents.add(
          contentsItem == null ? null : new Content.fromJson(contentsItem));
    }

    huxiuNews = jsonRes['huxiu_news'] == null
        ? null
        : new NewsBean.fromJson(jsonRes['huxiu_news']);
  }

  @override
  String toString() {
    return '{"contents": $contents,"huxiu_news": $huxiuNews}';
  }
}

class Content {
  int contentContainerType;
  List<Item> contentDetails;

  Content.fromParams({this.contentContainerType, this.contentDetails});

  Content.fromJson(jsonRes) {
    contentContainerType = jsonRes['content_container_type'];
    contentDetails = jsonRes['content_details'] == null ? null : [];

    for (var content_detailsItem
        in contentDetails == null ? [] : jsonRes['content_details']) {
      contentDetails.add(content_detailsItem == null
          ? null
          : new Item.fromJson(content_detailsItem));
    }
  }

  @override
  String toString() {
    return '{"content_container_type": $contentContainerType,"content_details": $contentDetails}';
  }
}

class Item {
  int contentType;
  int textStyle;
  String contentDetail;
  String extra;

  Item.fromParams(
      {this.contentType, this.textStyle, this.contentDetail, this.extra});

  Item.fromJson(jsonRes) {
    contentType = jsonRes['content_type'];
    textStyle = jsonRes['text_style'];
    contentDetail = jsonRes['content_detail'];
    extra = jsonRes['extra'];
  }

  @override
  String toString() {
    return '{"content_type": $contentType,"text_style": $textStyle,"content_detail": ${contentDetail != null ? '${json.encode(contentDetail)}' : 'null'},"extra": ${extra != null ? '${json.encode(extra)}' : 'null'}}';
  }
}

enum DetailContainerType {
  Normal,
  Blockquote,
  Img,
  ImgNote,
}

enum DetailTextType {
  Normal,
  ImgNote,
  ParagraphTitle,
  Br,
  Img,
  Span,
  Link,
  Bold,
}

enum DetailType {
  TEXT,
  IMG,
}
