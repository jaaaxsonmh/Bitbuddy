import 'package:bitbuddy/data/news_data.dart';
import 'package:bitbuddy/data/news_data_api.dart';


enum Flavour { API }

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavour _flavour;

  static void configure(Flavour flavour){
    _flavour = flavour;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  NewsStore get newsArticleStore {
    return new NewsDataAPI();
  }
}