import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bitbuddy/HomeScreen/home.dart';
import 'package:bitbuddy/utils/routers.dart';
import 'package:bitbuddy/utils/root.dart';

var routes = <String, WidgetBuilder>{
  Routers.home: (BuildContext context) => Home(),
};

void main() async {
  List currency = await getCryptoCurrency();
  print(currency);
  runApp(new Bitbuddy(currency));
}

class Bitbuddy extends StatelessWidget {
  final List _currency;
  Bitbuddy(this._currency);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        title: 'Bitbuddy',
        home: new Root(_currency),
        routes: routes);
  }
}


