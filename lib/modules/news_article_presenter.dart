import 'package:bitbuddy/data/news_data.dart';
import 'package:bitbuddy/news_injector.dart';

abstract class NewsArticleListViewContract {
  void onLoadNewsComplete(List<NewsData> items);
  void onLoadNewsError();
}

class CryptoCurrencyListPresenter {
  NewsArticleListViewContract _view;
  NewsStore _store;

  CryptoCurrencyListPresenter(this._view) {
    _store = new Injector().cryptoCurrencyStore;
  }

  void loadCurrency() {
    _store
        .getNewsArticle()
        .then((news) => _view.onLoadNewsComplete(news))
        .catchError((onError) => _view.onLoadNewsError());
  }
}
