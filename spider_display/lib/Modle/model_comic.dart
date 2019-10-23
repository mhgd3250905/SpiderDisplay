/**
 * created by
 * on 2019/10/23
 * note
 **/
import 'dart:convert' show json;

class ComicList {

  int err_code;
  String error;
  List<Book> data;

  ComicList.fromParams({this.err_code, this.error, this.data});

  factory ComicList(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ComicList.fromJson(json.decode(jsonStr)) : new ComicList.fromJson(jsonStr);

  ComicList.fromJson(jsonRes) {
    err_code = jsonRes['err_code'];
    error = jsonRes['error'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new Book.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"err_code": $err_code,"error": ${error != null?'${json.encode(error)}':'null'},"data": $data}';
  }
}

class Book {

  String desc;
  String id;
  String image_link;
  String name;
  List<Chapter> chapters;

  Book.fromParams({this.desc, this.id, this.image_link, this.name, this.chapters});

  Book.fromJson(jsonRes) {
    desc = jsonRes['desc'];
    id = jsonRes['id'];
    image_link = jsonRes['image_link'];
    name = jsonRes['name'];
    chapters = jsonRes['chapters'] == null ? null : [];

    for (var chaptersItem in chapters == null ? [] : jsonRes['chapters']){
      chapters.add(chaptersItem == null ? null : new Chapter.fromJson(chaptersItem));
    }
  }

  @override
  String toString() {
    return '{"desc": ${desc != null?'${json.encode(desc)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"image_link": ${image_link != null?'${json.encode(image_link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"chapters": $chapters}';
  }
}

class Chapter {

  String chapter_id;
  String chapter_url;
  String name;

  Chapter.fromParams({this.chapter_id, this.chapter_url, this.name});

  Chapter.fromJson(jsonRes) {
    chapter_id = jsonRes['chapter_id'];
    chapter_url = jsonRes['chapter_url'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"chapter_id": ${chapter_id != null?'${json.encode(chapter_id)}':'null'},"chapter_url": ${chapter_url != null?'${json.encode(chapter_url)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}


class ChapterDetail {

  int err_code;
  String error;
  List<String> data;

  ChapterDetail.fromParams({this.err_code, this.error, this.data});

  factory ChapterDetail(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ChapterDetail.fromJson(json.decode(jsonStr)) : new ChapterDetail.fromJson(jsonStr);

  ChapterDetail.fromJson(jsonRes) {
    err_code = jsonRes['err_code'];
    error = jsonRes['error'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem);
    }
  }

  @override
  String toString() {
    return '{"err_code": $err_code,"error": ${error != null?'${json.encode(error)}':'null'},"data": $data}';
  }
}

