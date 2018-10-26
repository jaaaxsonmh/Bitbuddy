import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bitbuddy/view/currency_list_view.dart';
import 'package:bitbuddy/utils/routers.dart';
import 'package:bitbuddy/utils/root.dart';
import 'package:bitbuddy/crypto_injector.dart';

var routes = <String, WidgetBuilder>{
  Routers.home: (BuildContext context) => Home(),
};

void main() async {
  Injector.configure(Flavour.API);
  runApp(new Bitbuddy());
}

class Bitbuddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        title: 'Bitbuddy',
        home: new Root(),
        routes: routes);
  }
}


