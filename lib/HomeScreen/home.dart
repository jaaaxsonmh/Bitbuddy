import 'package:flutter/material.dart';
import 'package:bitbuddy/main.dart';

class Home extends StatefulWidget {
  Home({this.currency});

  final List currency;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //null object error triggered here
  List currency;

  @override
  Widget build(BuildContext context) {
    print(widget.currency);
    print(widget.currency.length);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Bitbuddy"),
        centerTitle: true,
      ),
      body: _cryptoHolder(),
    );
  }

  Widget _cryptoHolder() {
    return new Container(
        child: new Column(
      children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          itemCount: widget.currency.length,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (BuildContext context, int index) {
            final Map currencyMap = widget.currency[index];

            return _buildListItem(context, currencyMap);
          },
        )),
      ],
    ));
  }

  Widget _buildListItem(BuildContext context, Map currencyList) {

    int rank = currencyList['rank'];
    double supply = currencyList['total_supply'] - currencyList['circulating_supply'];

    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
                leading: new CircleAvatar(
                  child: new Text(currencyList['name'][0]),
                ),
                title: new Text(currencyList['name'],
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                subtitle: new Text("Rank: $rank \nCoins not in circulation: $supply")

                /*_getPriceToSubtitle(
                  currencyList['rank'], currencyList['total_supply']),
              isThreeLine: true,
              */
                )
          ],
        ),
      ),
    );
  }

  Widget _getPriceToSubtitle(int price, int change) {
    TextSpan priceWidget = new TextSpan(
        text: "Rank: price\n",
        style: new TextStyle(color: Color.fromRGBO(115, 222, 255, 1.0)));
    String changeWidget = "total supply: $change";
    TextSpan changeTextWidget;

    /* if (double.parse(change) >= 0) {
      changeTextWidget = new TextSpan(
          text: changeWidget, style: new TextStyle(color: Colors.green));
    } else {
      changeTextWidget = new TextSpan(
          text: changeWidget, style: new TextStyle(color: Colors.red));
    }*/

    return new RichText(
        text: new TextSpan(children: [priceWidget, changeTextWidget]));
  }
}
