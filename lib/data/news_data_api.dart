import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bitbuddy/data/news_data.dart';

class NewsDataAPI implements NewsStore {
  String newsArticleAPI =
      "https://newsapi.org/v2/everything?q=bitcoin&language=en&sortBy=publishedAt&apiKey=0cc390e5c10b4bccbec21fabedd2322e";

  @override
  Future<List<NewsData>> getNewsArticle() async {
    http.Response response = await http.get(newsArticleAPI);

    final List responseBody = jsonDecode(response.body)['articles'];
    final httpStatusCode = response.statusCode;
    print(responseBody);
    if (httpStatusCode != 200 || httpStatusCode == null) {
      throw new GetDataException("Error Status Code: $httpStatusCode");
    }
    return responseBody.map((news) => new NewsData.fromMap(news)).toList();
  }
}
