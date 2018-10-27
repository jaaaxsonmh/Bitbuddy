import 'package:bitbuddy/data/news_data.dart';
import 'package:bitbuddy/API_injector/news_injector.dart';

abstract class NewsArticleListViewContract {
  void onLoadNewsComplete(List<NewsData> items);
  void onLoadNewsError();
}

class NewsArticleListPresenter {
  NewsArticleListViewContract _view;
  NewsStore _store;

  NewsArticleListPresenter(this._view) {
    _store = new Injector().newsArticleStore;
  }

  void loadCurrency() {
    _store
        .getNewsArticle()
        .then((news) => _view.onLoadNewsComplete(news))
        .catchError((onError) => _view.onLoadNewsError());
  }
}
