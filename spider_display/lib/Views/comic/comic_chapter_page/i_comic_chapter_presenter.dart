
import 'package:spider_display/Views/comic/comic_book_page/i_comic_book_view.dart';
import 'package:spider_display/Views/comic/mvp_base/i_presenter.dart';

import 'model_comic_chapter.dart';

abstract class IComicChapterPresenter extends IPresenter<IComicBookView> {
  ComicChapterModel model;

  IComicChapterPresenter() {
    model = new ComicChapterModel();
  }

  void showData(String url);
}
