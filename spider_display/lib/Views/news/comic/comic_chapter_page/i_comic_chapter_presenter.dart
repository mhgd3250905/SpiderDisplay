
import 'package:spider_display/Views/news/comic/comic_book_page/i_comic_book_view.dart';
import 'package:spider_display/Views/news/mvp_base/i_presenter.dart';

import 'model_comic_chapter.dart';

abstract class IComicChapterPresenter extends IPresenter<IComicBookView> {
  ComicChapterModel model;

  IComicChapterPresenter() {
    model = new ComicChapterModel();
  }

  void showData(String url);
}
