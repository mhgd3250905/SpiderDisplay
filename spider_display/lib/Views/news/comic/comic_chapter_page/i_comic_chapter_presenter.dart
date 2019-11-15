
import 'package:spider_display/Views/news/mvp_base/i_presenter.dart';

import 'i_comic_chapter_view.dart';
import 'model_comic_chapter.dart';

abstract class IComicChapterPresenter extends IPresenter<IComicChapterView> {
  ComicChapterModel model;
  //是否显示设置界面
  bool isShowSetupView = false;
  //是否显示章节列表
  bool isShowChapterListView = false;
  //切换明暗模式
  bool isDarkMode = false;
  //切换横纵模式
  bool isHorizontal = true;

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
   * 切换章节列表的显示
   */
  void toggleChapterListView();

  /**
   * 切换明暗模式
   */
  void toggleDarkMode();

  /**
   * 切换明暗模式
   */
  void toggleDirection();

  /**
   * 跳转到直接章节
   */
  void jumpPage(int index, bool reverse);
}
