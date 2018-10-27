import 'dart:async';

class NewsData {
  /*
  Example API data.

  "source": {
			"id": "crypto-coins-news",
			"name": "Crypto Coins News"
		},
		"author": "Yashu Gola",
		"title": "Net Neutrality Killer Ajit Pai Casts an Eye over Regulating Blockchain",
		"description": "The man who killed net neutrality in the US is racing-up with innovations like blockchain to effectively regulate them. Ajit Pai, the chairman of the US Federal Communications Commission (FCC), said that his office would be looking into the emerging technolog…",
		"url": "https://www.ccn.com/net-neutrality-killer-ajit-pai-casts-an-eye-over-regulating-blockchain/",
		"urlToImage": "https://www.ccn.com/wp-content/uploads/2018/10/Ajit-Pai-1024x683.jpg",
		"publishedAt": "2018-10-26T18:21:28Z",
		"content": "The man who killed net neutrality in the US is racing-up with innovations like blockchain to effectively regulate them. Ajit Pai, the chairman of the US Federal Communications Commission (FCC), said that his office would be looking into the emerging technolog… [+3674 chars]"
		},
		*/

  String id;
  String name;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  NewsData({this.id,
    this.name,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content});

  NewsData.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        author = map['author'],
        title = map['title'],
        description = map['description'],
        url = map['url'],
        urlToImage = map['urlToImage'],
        publishedAt = map['publishedAt'],
        content = map['content'];
}

abstract class NewsStore {
  Future<List<NewsData>> getNewsArticle();
}

class GetDataException implements Exception {
  final _exception;

  GetDataException([this._exception]);

  String toString() {
    if (_exception == null) return "Unknown";
    return " Exception $_exception";
  }
}
