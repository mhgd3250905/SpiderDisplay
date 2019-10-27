/**
 * 数据Model
 */
abstract class INewsModel<T> {
  Future<T> getData(String url, NetworkCallback<T> callback);
}

class NetworkCallback<T> {
  Function(T) onSuccess;
  Function() onFailed;
  Function onWaiting;

  NetworkCallback(this.onSuccess, this.onFailed, this.onWaiting);
}
