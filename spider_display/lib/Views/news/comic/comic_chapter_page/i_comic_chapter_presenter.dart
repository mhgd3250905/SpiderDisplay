
import 'package:spider_display/Views/news/mvp_base/i_presenter.dart';

import 'i_comic_chapter_view.dart';
import 'model_comic_chapter.dart';

abstract class IComicChapterPresenter extends IPresenter<IComicChapterView> {
  ComicChapterModel model;
  bool isShowSetupView = false;

  IComicChapterPresenter() {
    model = new ComicChapterModel();
  }

  /**
   * 根据url获取数据并显示
   */
  void showData(String url);

  /**
   * 切换设置界面的显示
   */
  void toggleSetupView();

  /**
   * 跳转到直接章节
   */
  void jumpPage(int index, bool reverse);
}
