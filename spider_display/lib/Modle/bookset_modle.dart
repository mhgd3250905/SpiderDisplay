import 'dart:convert' show json;

class BookList {
  int err_code;
  String error;
  List<Book> data;

  BookList.fromParams({this.err_code, this.error, this.data});

  factory BookList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new BookList.fromJson(json.decode(jsonStr))
          : new BookList.fromJson(jsonStr);

  BookList.fromJson(jsonRes) {
    err_code = jsonRes['err_code'];
    error = jsonRes['error'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new Book.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"err_code": $err_code,"error": ${error != null ? '${json.encode(error)}' : 'null'},"data": $data}';
  }
}

class Book {
  String author;
  String author_link;
  String book_link;
  String image;
  String title;

  Book({this.author, this.author_link, this.book_link, this.image, this.title});

  Book.fromParams(
      {this.author, this.author_link, this.book_link, this.image, this.title});

  Book.fromJson(jsonRes) {
    author = jsonRes['author'];
    author_link = jsonRes['author_link'];
    book_link = jsonRes['book_link'];
    image = jsonRes['image'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"author": ${author != null ? '${json.encode(author)}' : 'null'},"author_link": ${author_link != null ? '${json.encode(author_link)}' : 'null'},"book_link": ${book_link != null ? '${json.encode(book_link)}' : 'null'},"image": ${image != null ? '${json.encode(image)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}

class BookDetailList {
  int err_code;
  String error;
  List<BookDetail> data;

  BookDetailList.fromParams({this.err_code, this.error, this.data});

  factory BookDetailList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new BookDetailList.fromJson(json.decode(jsonStr))
          : new BookDetailList.fromJson(jsonStr);

  BookDetailList.fromJson(jsonRes) {
    err_code = jsonRes['err_code'];
    error = jsonRes['error'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new BookDetail.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"err_code": $err_code,"error": ${error != null ? '${json.encode(error)}' : 'null'},"data": $data}';
  }
}

class BookDetail {
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

  BookDetail.fromParams(
      {this.double_score_c_ount,
      this.douban_score,
      this.author,
      this.douban_link,
      this.download_link_azw3,
      this.download_link_epub,
      this.download_link_mobi,
      this.image,
      this.introduction,
      this.time,
      this.title});

  BookDetail.fromJson(jsonRes) {
    double_score_c_ount = jsonRes['double_score_c_ount'];
    douban_score = jsonRes['douban_score'];
    author = jsonRes['author'];
    douban_link = jsonRes['douban_link'];
    download_link_azw3 = jsonRes['download_link_azw3'];
    download_link_epub = jsonRes['download_link_epub'];
    download_link_mobi = jsonRes['download_link_mobi'];
    image = jsonRes['image'];
    introduction = jsonRes['introduction'];
    time = jsonRes['time'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"double_score_c_ount": $double_score_c_ount,"douban_score": $douban_score,"author": ${author != null ? '${json.encode(author)}' : 'null'},"douban_link": ${douban_link != null ? '${json.encode(douban_link)}' : 'null'},"download_link_azw3": ${download_link_azw3 != null ? '${json.encode(download_link_azw3)}' : 'null'},"download_link_epub": ${download_link_epub != null ? '${json.encode(download_link_epub)}' : 'null'},"download_link_mobi": ${download_link_mobi != null ? '${json.encode(download_link_mobi)}' : 'null'},"image": ${image != null ? '${json.encode(image)}' : 'null'},"introduction": ${introduction != null ? '${json.encode(introduction)}' : 'null'},"time": ${time != null ? '${json.encode(time)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}
