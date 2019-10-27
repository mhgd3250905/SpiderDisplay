import 'package:spider_display/Views/news/mvp_base/i_presenter.dart';

import 'i_comic_book_view.dart';
import 'model_comic_book.dart';

abstract class IComicBookPresenter extends IPresenter<IComicBookView> {
  ComicBookModel model;

  IComicBookPresenter() {
    model = new ComicBookModel();
  }

  void showData(String url);
}
