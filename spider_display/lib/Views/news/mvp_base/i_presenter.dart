
import 'i_view.dart';

abstract class IPresenter<V extends IView> {
  V view;

  void attach(V v) {
    this.view = v;
  }

  void dettach() {
    this.view = null;
  }
}
