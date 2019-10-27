import 'package:spider_display/Views/news/mvp_base/i_view.dart';

/**
 * View
 */
abstract class IComicBookView<E> extends IView {
  void loadDataSuccess(E e);
  void loadDataFailed();
  void loadDataWaiting();
}
