import 'package:flutter/material.dart';
import 'package:bitbuddy/data/news_data.dart';
import 'package:bitbuddy/modules/news_article_presenter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

class PortfolioView extends StatefulWidget {
  @override
  _PortfolioViewState createState() => new _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("Coming soon..."),
      )
    );
  }
}
