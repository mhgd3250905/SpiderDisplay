import 'dart:convert' show json;

class HuxiuNewsList {
  int err_code;
  String error;
  List<HuxiuNews> data;

  HuxiuNewsList.fromParams({this.err_code, this.error, this.data});

  factory HuxiuNewsList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new HuxiuNewsList.fromJson(json.decode(jsonStr))
          : new HuxiuNewsList.fromJson(jsonStr);

  HuxiuNewsList.fromJson(jsonRes) {
    err_code = jsonRes['err_code'];
    error = jsonRes['error'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new HuxiuNews.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"err_code": $err_code,"error": ${error != null ? '${json.encode(error)}' : 'null'},"data": $data}';
  }
}

class HuxiuNews {
  String create_time;
  String desc;
  String image_link;
  String news_id;
  String news_link;
  String title;
  List<Category> category;
  Author author;

  HuxiuNews.fromParams(
      {this.create_time,
      this.desc,
      this.image_link,
      this.news_id,
      this.news_link,
      this.title,
      this.category,
      this.author});

  HuxiuNews.fromJson(jsonRes) {
    create_time = jsonRes['create_time'];
    desc = jsonRes['desc'];
    image_link = jsonRes['image_link'];
    news_id = jsonRes['news_id'];
    news_link = jsonRes['news_link'];
    title = jsonRes['title'];
    category = jsonRes['category'] == null ? null : [];

    for (var categoryItem in category == null ? [] : jsonRes['category']) {
      category.add(
          categoryItem == null ? null : new Category.fromJson(categoryItem));
    }

    author = jsonRes['author'] == null
        ? null
        : new Author.fromJson(jsonRes['author']);
  }

  @override
  String toString() {
    return '{"create_time": ${create_time != null ? '${json.encode(create_time)}' : 'null'},"desc": ${desc != null ? '${json.encode(desc)}' : 'null'},"image_link": ${image_link != null ? '${json.encode(image_link)}' : 'null'},"news_id": ${news_id != null ? '${json.encode(news_id)}' : 'null'},"news_link": ${news_link != null ? '${json.encode(news_link)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"category": $category,"author": $author}';
  }
}

class Author {
  String author_id;
  String author_img;
  String author_name;

  Author.fromParams({this.author_id, this.author_img, this.author_name});

  Author.fromJson(jsonRes) {
    author_id = jsonRes['author_id'];
    author_img = jsonRes['author_img'];
    author_name = jsonRes['author_name'];
  }

  @override
  String toString() {
    return '{"author_id": ${author_id != null ? '${json.encode(author_id)}' : 'null'},"author_img": ${author_img != null ? '${json.encode(author_img)}' : 'null'},"author_name": ${author_name != null ? '${json.encode(author_name)}' : 'null'}}';
  }
}

class Category {
  String category_id;
  String category_name;

  Category.fromParams({this.category_id, this.category_name});

  Category.fromJson(jsonRes) {
    category_id = jsonRes['category_id'];
    category_name = jsonRes['category_name'];
  }

  @override
  String toString() {
    return '{"category_id": ${category_id != null ? '${json.encode(category_id)}' : 'null'},"category_name": ${category_name != null ? '${json.encode(category_name)}' : 'null'}}';
  }
}
