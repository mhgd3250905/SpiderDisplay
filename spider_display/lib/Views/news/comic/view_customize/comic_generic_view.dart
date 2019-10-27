import 'package:flutter/material.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/news/comic/comic_chapter_list_page/view_comic_chapter_list.dart';

import 'clip_image_view.dart';

/**
 * 构建用于展示漫画的 左图片 右描述的 item 布局
 */
Widget getComicDescItemView(BuildContext context, Book book) {
  return Container(
    color: Colors.white,
    height: 150.0,
    width: double.infinity,
    child: GestureDetector(
      onTap: () {
        NavigatorRouterUtils.pushToPage(
          context,
          ComicChapterListPage(
            book: book,
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Hero(
            tag: "${book.name}-${book.image_link}",
            child: Container(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              width: 100.0,
              child: ClipImageView(
                book.image_link,
                BorderRadius.circular(4.0),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    book.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 5.0),
                    child: Text(
                      book.desc,
                      softWrap: true,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
