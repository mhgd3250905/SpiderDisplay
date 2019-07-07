import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/search_delegate.dart';
import 'package:spider_display/Modle/bookset_modle.dart';
import 'package:spider_display/Modle/test_content.dart';
import 'package:spider_display/Views/bookset_list_page.dart';

class SearchPage extends CustomSearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    //设置搜索框右侧图标
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
      Container(
        margin: const EdgeInsets.only(top: 14.0, bottom: 14.0),
        color: Colors.white,
        width: 1.5,
        height: double.infinity,
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //左侧指引按钮
    return IconButton(
      //设置一个具有动画效果的返回键
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Book> bookList =
        BookList.fromJson(json.decode(BOOK_LIST_JSON_STR)).data;
    //返回结果，在输入的过程中触发
    List<Book> queryBookList = [];
    bookList.forEach((book) {
      if (book.title.contains(query)) {
        queryBookList.add(book);
      }
    });
    return BooksetListPage(queryBookList, null);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> bookList =
        BookList.fromJson(json.decode(BOOK_LIST_JSON_STR)).data;
    //返回建议值，在输入的过程中触发
    List<Book> queryBookList = [];
    bookList.forEach((book) {
      if (book.title.contains(query)) {
        queryBookList.add(book);
      }
    });
    return BooksetListPage(queryBookList, null);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.green,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
//      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
      textTheme: theme.textTheme.copyWith(
        title: theme.textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }
}
