import 'package:flutter/material.dart';
import 'package:spider_display/CustomView/clip_widgets.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Utils/navigator_router_utils.dart';
import 'package:spider_display/Views/news/comic/comic_chapter_page/view_comic_chapter.dart';
import 'package:spider_display/CustomView/comic_generic_view.dart';

class ComicChapterListPage extends StatelessWidget {
  final Book book;

  ComicChapterListPage({@required this.book});

  @override
  Widget build(BuildContext context) {
    book.chapters=book.chapters.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(book.name),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            getComicDescItemView(context, book),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                ),
                itemCount: book.chapters.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    child: new ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        alignment: Alignment.center,
                        height: 20.0,
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          book.chapters[i].name,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                            shadows: [
                              Shadow(
                                  color: Colors.black87,
                                  offset: Offset(0.2, 0.2))
                            ],
                          ),
                        ),
                      ),
                      borderRadius: new BorderRadius.circular(3.0),
                    ),
                    onTap: () {
                      NavigatorRouterUtils.pushToPage(
                        context,
                        ComicChapterPage(
                          chapters: book.chapters,
                          index: i,
                          reverse: false,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded get getBookInfoView {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 5.0, bottom: 5.0),
        child: Column(
          children: <Widget>[
            /// Title
            Container(
              width: double.infinity,
              child: Text(
                book.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),

            /// Title Top Desc
            Container(
              margin: EdgeInsets.only(top: 5.0, right: 5.0),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                book.desc,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container get getBookImageView {
    return Container(
      width: 100.0,
      child: ClipImageView(
        book.image_link,
        BorderRadius.circular(4.0),
      ),
    );
  }
}
