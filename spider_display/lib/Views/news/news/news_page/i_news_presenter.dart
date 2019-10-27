
import 'package:spider_display/Views/news/mvp_base/i_presenter.dart';

import 'i_news_view.dart';
import 'model_news.dart';

abstract class INewsPresenter extends IPresenter<INewsView> {
  NewsModel model;

  INewsPresenter() {
    model = new NewsModel();
  }

  void showData(String url);
}
