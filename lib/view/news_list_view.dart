import 'package:flutter/material.dart';
import 'package:bitbuddy/data/news_data.dart';
import 'package:bitbuddy/modules/news_article_presenter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => new _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView>
    implements NewsArticleListViewContract {
  NewsArticleListPresenter _presenter;
  List<NewsData> _news;
  bool _isLoading;
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();

  _NewsListViewState() {
    _presenter = new NewsArticleListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCurrency();
  }

  @override
  void onLoadNewsComplete(List<NewsData> items) {
    setState(() {
      _news = items;
      _isLoading = false;
      print(_news.length);
    });
  }

  @override
  void onLoadNewsError() {
    // TODO: implement onLoadCryptoError
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _isLoading
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : _newsHolder(),
    );
  }

  Widget _newsHolder() {
    return new Container(
        child: new Column(
      children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          itemCount: _news.length,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (BuildContext context, int index) {
            final NewsData news = _news[index];

            return _buildListItem(news);
          },
        )),
      ],
    ));
  }

  Widget _buildListItem(NewsData newsList) {
    return new Card(
      child: new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new Column(
          children: [
            new Row(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Text(
                    timeago.format(DateTime.parse(newsList.publishedAt)),
                    style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Text(
                    newsList.name,
                    style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  child: new GestureDetector(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Padding(
                          padding: new EdgeInsets.only(
                              left: 4.0, right: 8.0, bottom: 8.0, top: 8.0),
                          child: new Text(
                            newsList.title,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                              left: 4.0, right: 8.0, bottom: 4.0),
                          child: new Text(
                            newsList.description,
                            style: new TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      flutterWebviewPlugin.launch(newsList.url);
                    },
                  ),
                ),
                new Column(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0),
                      child: new SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: _getImageFromURL(newsList.urlToImage)),
                    ),
                    new Row(
                      children: <Widget>[
                        new GestureDetector(
                          child: new Padding(
                              padding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              child: new Icon(
                                Icons.share,
                                color: Color.fromRGBO(115, 222, 255, 1.0),
                              )),
                          onTap: () {
                            //TODO: input published link.
                            Share.share(
                                "Check out the latest news on Cryptocurrency! \n\nSent from Bit Buddy \n " +
                                    newsList.url);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getImageFromURL(String url) {
    Image imageFromUrl;

    if ((url) != null) {
      imageFromUrl = Image.network(
        url,
        fit: BoxFit.cover,
      );
    } else {
      imageFromUrl = Image.asset(
        'images/bitbuddylogo.jpg',
        fit: BoxFit.cover,
      );
    }

    return imageFromUrl;
  }
}
