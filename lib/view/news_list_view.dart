import 'package:flutter/material.dart';
import 'package:bitbuddy/data/news_data.dart';
import 'package:bitbuddy/modules/news_article_presenter.dart';

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => new _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView>
    implements NewsArticleListViewContract {
  NewsArticleListPresenter _presenter;
  List<NewsData> _news;
  bool _isLoading;

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
    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: new Text(newsList.title),
            )
          ],
        ),
      ),
    );
  }
}
