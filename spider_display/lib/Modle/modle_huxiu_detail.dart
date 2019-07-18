import 'dart:convert' show json;

import 'package:spider_display/Modle/modle_huxiu.dart';


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
  HuxiuNews huxiu_news;

  HuxiuDetail(this.contents, this.huxiu_news);

  HuxiuDetail.fromParams({this.contents, this.huxiu_news});

  HuxiuDetail.fromJson(jsonRes) {
    contents = jsonRes['contents'] == null ? null : [];

    for (var contentsItem in contents == null ? [] : jsonRes['contents']) {
      contents.add(
          contentsItem == null ? null : new Content.fromJson(contentsItem));
    }

    huxiu_news = jsonRes['huxiu_news'] == null
        ? null
        : new HuxiuNews.fromJson(jsonRes['huxiu_news']);
  }

  @override
  String toString() {
    return '{"contents": $contents,"huxiu_news": $huxiu_news}';
  }
}

class Content {
  int content_container_type;
  List<Item> content_details;

  Content.fromParams({this.content_container_type, this.content_details});

  Content.fromJson(jsonRes) {
    content_container_type = jsonRes['content_container_type'];
    content_details = jsonRes['content_details'] == null ? null : [];

    for (var content_detailsItem
        in content_details == null ? [] : jsonRes['content_details']) {
      content_details.add(content_detailsItem == null
          ? null
          : new Item.fromJson(content_detailsItem));
    }
  }

  @override
  String toString() {
    return '{"content_container_type": $content_container_type,"content_details": $content_details}';
  }
}

class Item {
  int content_type;
  int text_style;
  String content_detail;
  String extra;

  Item.fromParams(
      {this.content_type, this.text_style, this.content_detail, this.extra});

  Item.fromJson(jsonRes) {
    content_type = jsonRes['content_type'];
    text_style = jsonRes['text_style'];
    content_detail = jsonRes['content_detail'];
    extra = jsonRes['extra'];
  }

  @override
  String toString() {
    return '{"content_type": $content_type,"text_style": $text_style,"content_detail": ${content_detail != null ? '${json.encode(content_detail)}' : 'null'},"extra": ${extra != null ? '${json.encode(extra)}' : 'null'}}';
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
