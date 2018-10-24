
import 'package:flutter/material.dart';
import 'package:bitbuddy/HomeScreen/home.dart';

class Root extends StatefulWidget {

  Root(this.currency);
  final List currency;
  @override
  State<StatefulWidget> createState() => new _RootState();
}

class _RootState extends State<Root>{

  @override
  Widget build(BuildContext context) {
    return new Home(currency: widget.currency);
  }
}