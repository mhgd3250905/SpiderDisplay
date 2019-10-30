import 'package:spider_display/Views/news/mvp_base/i_view.dart';

/**
 * View
 */
abstract class IComicChapterView<E> extends IView {
  void loadDataSuccess(E e);
  void loadDataFailed();
  void loadDataWaiting();

  //显示操作界面
  void showSetupView();
  //隐藏操作界面
  void hideSetupView();

  void jumpPage(int index, bool reverse);
}
