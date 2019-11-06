import 'package:spider_display/Views/news/mvp_base/i_view.dart';

/**
 * View
 */
abstract class IComicChapterView<E> extends IView {
  void loadDataSuccess(E e);
  void loadDataFailed();
  void loadDataWaiting();

  //切换设置界面
  void toggleSetupView();

  void jumpPage(int index, bool reverse);
}
