import 'package:flutter/material.dart';
import 'package:bitbuddy/home.dart';
import 'package:bitbuddy/utils/routers.dart';
import 'package:bitbuddy/API_injector/crypto_injector.dart';
import 'package:bitbuddy/API_injector/news_injector.dart';
import 'package:bitbuddy/utils/root.dart';
import 'package:bitbuddy/settings_page.dart';
import 'package:bitbuddy/utils/auth.dart';

var routes = <String, WidgetBuilder>{
  Routers.home: (BuildContext context) => Home(),
  Routers.settings: (BuildContext context) => Settings()
};

void main() async {
  CryptoInjector.configure(CryptoFlavour.API);
  NewsInjector.configure(NewsFlavour.API);
  runApp(new Bitbuddy());
}

class Bitbuddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        title: 'Bit Buddy',
        home: new Root(auth: new Auth()),
        routes: routes);
  }
}


