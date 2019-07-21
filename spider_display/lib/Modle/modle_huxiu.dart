import 'dart:convert' show json;

class HuxiuNewsList {
  int errCode;
  String error;
  List<HuxiuNews> data;

  HuxiuNewsList.fromParams({this.errCode, this.error, this.data});

  factory HuxiuNewsList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new HuxiuNewsList.fromJson(json.decode(jsonStr))
          : new HuxiuNewsList.fromJson(jsonStr);

  HuxiuNewsList.fromJson(jsonRes) {
    errCode = jsonRes['err_code'];
    error = jsonRes['error'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new HuxiuNews.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"err_code": $errCode,"error": ${error != null ? '${json.encode(error)}' : 'null'},"data": $data}';
  }
}

class HuxiuNews {
  String createTime;
  String desc;
  String imageLink;
  String newsId;
  String newsLink;
  String title;
  List<Category> category;
  Author author;

  HuxiuNews.fromParams(
      {this.createTime,
      this.desc,
      this.imageLink,
      this.newsId,
      this.newsLink,
      this.title,
      this.category,
      this.author});

  HuxiuNews.fromJson(jsonRes) {
    createTime = jsonRes['create_time'];
    desc = jsonRes['desc'];
    imageLink = jsonRes['image_link'];
    newsId = jsonRes['news_id'];
    newsLink = jsonRes['news_link'];
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
    return '{"create_time": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"desc": ${desc != null ? '${json.encode(desc)}' : 'null'},"image_link": ${imageLink != null ? '${json.encode(imageLink)}' : 'null'},"news_id": ${newsId != null ? '${json.encode(newsId)}' : 'null'},"news_link": ${newsLink != null ? '${json.encode(newsLink)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"category": $category,"author": $author}';
  }
}

class Author {
  String authorId;
  String authorImg;
  String authorName;

  Author.fromParams({this.authorId, this.authorImg, this.authorName});

  Author.fromJson(jsonRes) {
    authorId = jsonRes['author_id'];
    authorImg = jsonRes['author_img'];
    authorName = jsonRes['author_name'];
  }

  @override
  String toString() {
    return '{"author_id": ${authorId != null ? '${json.encode(authorId)}' : 'null'},"author_img": ${authorImg != null ? '${json.encode(authorImg)}' : 'null'},"author_name": ${authorName != null ? '${json.encode(authorName)}' : 'null'}}';
  }
}

class Category {
  String categoryId;
  String categoryName;

  Category.fromParams({this.categoryId, this.categoryName});

  Category.fromJson(jsonRes) {
    categoryId = jsonRes['category_id'];
    categoryName = jsonRes['category_name'];
  }

  @override
  String toString() {
    return '{"category_id": ${categoryId != null ? '${json.encode(categoryId)}' : 'null'},"category_name": ${categoryName != null ? '${json.encode(categoryName)}' : 'null'}}';
  }
}
