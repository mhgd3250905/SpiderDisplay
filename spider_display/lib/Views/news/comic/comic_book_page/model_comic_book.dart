import 'package:dio/dio.dart';
import 'package:spider_display/Modle/model_comic.dart';
import 'package:spider_display/Views/news/comic/comic_book_page/i_comic_book_model.dart';

class ComicBookModel extends IComicBookModel<ComicList> {
  @override
  getData(String url, NetworkCallback<ComicList> callback) async {
    callback.onWaiting;
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      ComicList bean = ComicList(response.data.toString());
      callback.onSuccess(bean);
      dio.clear();
    } on Error catch (e) {
      callback.onFailed();
      dio.clear();
    }
    return null;
  }
}
