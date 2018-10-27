import 'package:bitbuddy/data/news_data.dart';
import 'package:bitbuddy/data/news_data_api.dart';


enum NewsFlavour { API }

class NewsInjector {
  static final NewsInjector _singleton = new NewsInjector._internal();
  static NewsFlavour _flavour;

  static void configure(NewsFlavour flavour){
    _flavour = flavour;
  }

  factory NewsInjector() {
    return _singleton;
  }

  NewsInjector._internal();

  NewsStore get newsArticleStore {
    return new NewsDataAPI();
  }
}