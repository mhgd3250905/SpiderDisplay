
import 'package:spider_display/Modle/model_comic.dart';

import 'i_comic_book_model.dart';
import 'i_comic_book_presenter.dart';

class ComicBookPresenter extends IComicBookPresenter {
  @override
  void showData(String url) {
    this.model.getData(
        url,
        new NetworkCallback<ComicList>((ComicList data) {
          //加载成功
          if (this.view != null) {
            this.view.loadDataSuccess(data);
          }
        }, () {
          //加载失败
          if (this.view != null) {
            this.view.loadDataFailed();
          }
        }, () {
          //等待
          if (this.view != null) {
            this.view.loadDataWaiting();
          }
        }));
  }
}
