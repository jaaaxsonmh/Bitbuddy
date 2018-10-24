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
    return new Scaffold(
      appBar: new AppBar(title: new Text("Bitbuddy"),
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
          itemCount: 5,
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
              subtitle: _getPriceToSubtitle(
                  currencyList['price_usd'], currencyList['percent_change_1h']),
              isThreeLine: true,
            )
          ],
        ),
      ),
    );
  }

  Widget _getPriceToSubtitle(String price, String change) {
    TextSpan priceWidget = new TextSpan(
        text: "\$$price\n",
        style: new TextStyle(color: Color.fromRGBO(115, 222, 255, 1.0)));
    String changeWidget = "60 minute change: $change%";
    TextSpan changeTextWidget;

    if (double.parse(change) >= 0) {
      changeTextWidget = new TextSpan(
          text: changeWidget, style: new TextStyle(color: Colors.green));
    } else {
      changeTextWidget = new TextSpan(
          text: changeWidget, style: new TextStyle(color: Colors.red));
    }

    return new RichText(
        text: new TextSpan(children: [priceWidget, changeTextWidget]));
  }
}
