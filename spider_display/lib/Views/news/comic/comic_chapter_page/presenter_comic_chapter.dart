import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Views/news/comic/comic_book_page/i_comic_book_model.dart';

import 'i_comic_chapter_presenter.dart';

class ComicChapterPresenter extends IComicChapterPresenter {
  @override
  void showData(String url) {
    this.model.getData(
        url,
        new NetworkCallback<ChapterDetail>((ChapterDetail data) {
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

  @override
  void toggleSetupView() {
    if (isShowSetupView) {
      this.isShowSetupView = false;
      this.view.hideSetupView();
    } else {
      this.isShowSetupView = true;
      this.view.showSetupView();
    }
  }

  @override
  void jumpPage(int index, bool reverse) {
    //重置提示信息flag
    isShowSetupView = false;
    this.view.jumpPage(index, reverse);
  }
}
