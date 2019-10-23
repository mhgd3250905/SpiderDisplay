

import 'package:spider_display/Views/comic/comic_book_page/i_comic_book_view.dart';
import 'package:spider_display/Views/comic/comic_book_page/model_comic_book.dart';
import 'package:spider_display/Views/comic/mvp_base/i_presenter.dart';

abstract class IComicBookPresenter extends IPresenter<IComicBookView> {
  ComicBookModel model;

  IComicBookPresenter() {
    model = new ComicBookModel();
  }

  void showData(String url);
}
