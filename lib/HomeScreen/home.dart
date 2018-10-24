import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List currency ;

  @override
  void initState(){
    super.initState();
    currency = await getCryptoCurrency();
  }

  Future<List> getCryptoCurrency() async{
      String currencyURL = "https://api.coinmarketcap.com/v2/ticker/1/";
      http.Response response = await http.get(currencyURL);
      retrun
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Bitbuddy")
      ),
      body: _cryptoHolder(),
    );
  }

  Widget _cryptoHolder()
  {
    return new Container(
      child: new Flexible(
        child: new ListView.builder(
            itemCount: 0,
            itemBuilder: (BuildContext context, int index) {

            },
        )
      )
    );
  }
}
