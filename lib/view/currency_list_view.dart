import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/modules/crypto_currency_presenter.dart';
import 'package:bitbuddy/utils/MyNavigator.dart';
import 'package:bitbuddy/widgets/price_formated.dart';

class CurrencyListView extends StatefulWidget {
  @override
  _CurrencyListViewState createState() => new _CurrencyListViewState();
}

class _CurrencyListViewState extends State<CurrencyListView>
    implements CryptoCurrencyListViewContract {
  CryptoCurrencyListPresenter _presenter;
  List<CryptoData> _currency;
  bool _isLoading;

  _CurrencyListViewState() {
    _presenter = new CryptoCurrencyListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadCurrency();
    _isLoading = true;
  }

  @override
  Future onLoadCryptoComplete(List<CryptoData> items) async {
    setState(() {
      _currency = items;
      _isLoading = false;
      print(_currency.length);
    });
  }

  @override
  void onLoadCryptoError() {
    // TODO: implement onLoadCryptoError
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _isLoading ? new Center(child: new CircularProgressIndicator()) : _cryptoHolder()
      );
  }

  //gets from api not cache
  Future _refresh() async {
    _presenter.loadCurrency();
  }

  Widget _cryptoHolder() {
    return new Container(
        child: new RefreshIndicator(
            onRefresh: _refresh,
            child: new Column(
              children: <Widget>[
                new Flexible(
                    child: new ListView.builder(
                  itemCount: _currency.length,
                  padding: const EdgeInsets.all(5.0),
                  itemBuilder: (BuildContext context, int index) {
                    final CryptoData currency = _currency[index];

                    return _buildListItem(currency);
                  },
                )),
              ],
            )));
  }

  Widget _buildListItem(CryptoData currencyList) {
    return new Container(
      child: new Card(
        child: new GestureDetector(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new CircleAvatar(
                    radius: 30.0,
                    child: Image.network(
                        "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@0b37b127fbec5091a47921deeba2dce2c1f8eb16/32@2x/color/" +
                            currencyList.symbol.toLowerCase() +
                            "@2x.png") /* new Text(currencyList[symbol], style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18.0),),*/
                    ),
                title: new Text(currencyList.name,
                    style: new TextStyle(color: Colors.black, fontSize: 24.0)),
                subtitle: new PriceFormatted(
                    price: currencyList.price,
                    change: currencyList.percentChange1h),
                isThreeLine: false,
                trailing: new Text(
                  currencyList.symbol,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(115, 222, 255, 1.0),
                      fontSize: 24.0),
                ),
              )
            ],
          ),
          onTap: () => _openCurrencyDetailPage(context, currencyList),
        ),
      ),
    );
  }

  _openCurrencyDetailPage(BuildContext context, CryptoData currencyList) {
    MyNavigator.goToCurrencyDetailPage(context, currencyList);
  }
}
