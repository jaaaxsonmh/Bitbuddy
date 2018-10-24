import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List currency ;

  @override
  void initState() async{
    super.initState();
    currency = await getCryptoCurrency();
  }

  Future<List> getCryptoCurrency() async{
      String coinMarketCapAPI = "https://api.coinmarketcap.com/v2/ticker/?limit=10";
      http.Response response = await http.get(coinMarketCapAPI);
      return json.decode(response.body);
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
            itemCount: currency.length,
            padding: const EdgeInsets.all(5.0),
            itemBuilder: (BuildContext context, int index) {
                final Map currencyMap = currency[index];

                return _buildListItem(currencyMap);
            },
        )
      )
    );
  }

  Widget _buildListItem(Map currencyMap){
    return new Container(
      child: new Card(
        child: new Column(
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: new CircleAvatar(
                child: new Text(currencyMap['name'][0]),
              ),
              title: new Text(currencyMap['name'],
              style: new TextStyle(fontWeight: FontWeight.bold)),

              ),
            )
          ],
        ),
      ),
    );
  }
}
