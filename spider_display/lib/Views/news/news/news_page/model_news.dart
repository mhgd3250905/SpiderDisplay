import 'package:dio/dio.dart';
import 'package:spider_display/Modle/modle_huxiu.dart';

import 'i_news_model.dart';

class NewsModel extends INewsModel<NewsListBean> {
  @override
  getData(String url, NetworkCallback<NewsListBean> callback) async {
    callback.onWaiting;
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      NewsListBean bean = NewsListBean(response.data.toString());
      callback.onSuccess(bean);
      dio.clear();
    } on Error catch (e) {
      callback.onFailed();
      dio.clear();
    }
    return null;
  }
}
