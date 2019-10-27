import 'package:spider_display/Views/news/mvp_base/i_view.dart';

/**
 * View
 */
abstract class INewsView<E> extends IView {
  void loadDataSuccess(E e);
  void loadDataFailed();
  void loadDataWaiting();

  void setLoadMoreDataList(list);
  void setRefreshDataList(list);
}
