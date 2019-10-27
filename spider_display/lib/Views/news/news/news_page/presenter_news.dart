import 'package:spider_display/Modle/modle_huxiu.dart';

import 'i_news_model.dart';
import 'i_news_presenter.dart';

class NewsPresenter extends INewsPresenter {
  @override
  void showData(String url) {
    this.model.getData(
        url,
        new NetworkCallback<NewsListBean>((NewsListBean data) {
          //加载成功
          if (this.view != null) {
            print("加载成功！");
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

  void setLoadMoreDataList(list) {
    if (this.view != null) {
      this.view.setLoadMoreDataList(list);
    }
  }

  void setRefreshDataList(list) {
    if (this.view != null) {
      this.view.setRefreshDataList(list);
    }
  }
}
