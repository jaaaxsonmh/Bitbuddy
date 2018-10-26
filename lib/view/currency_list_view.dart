import 'package:flutter/material.dart';
import 'package:bitbuddy/widgets/fancyfab.dart';
import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/modules/crypto_currency_presenter.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: Image.asset("images/bitbuddylogo.jpg"),
        backgroundColor: Color.fromRGBO(115, 222, 255, 1.0),
        title: new Text("Bit Buddy",
        style: new TextStyle(color:  Colors.white, fontSize: 28.0)),
        centerTitle: true,
      ),
      body: _cryptoHolder(),
      floatingActionButton: FancyFab(),
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
    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
                leading: new CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Color.fromRGBO(115, 222, 255, 1.0),
                  child: Image.network("https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@0b37b127fbec5091a47921deeba2dce2c1f8eb16/128/color/"+currencyList['symbol'].toLowerCase()+".png")/*new Text(currencyList['symbol'], style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18.0),),*/
                ),
                title: new Text(currencyList['name'],
                    style: new TextStyle(color:  Colors.black, fontSize: 24.0)),
                subtitle:
                _getPriceToSubtitle(
                  currencyList['quotes']['USD']['price'], currencyList['quotes']['USD']['percent_change_1h']),
              isThreeLine: false,
              trailing: new Text(currencyList['symbol'], style: new TextStyle(fontWeight: FontWeight.bold, color:  Color.fromRGBO(115, 222, 255, 1.0), fontSize: 24.0),),
                )
          ],
        ),
      ),
    );
  }

  Widget _getPriceToSubtitle(double price, double change) {
    String priceFormated = price.toStringAsFixed(2);
    TextSpan priceWidget = new TextSpan(
        text: "\$$priceFormated",
        style: new TextStyle(color: Colors.black, fontSize: 18.0));
    String changeWidget = " $change%";
    TextSpan changeTextWidget;

     if (change >= 0) {
      changeTextWidget = new TextSpan(
          text: changeWidget, style: new TextStyle(color: Colors.green, fontSize: 18.0));
    } else {
      changeTextWidget = new TextSpan(
          text: changeWidget, style: new TextStyle(color: Colors.red, fontSize: 18.0));
    }

    return new RichText(
        text: new TextSpan(children: [priceWidget, changeTextWidget]));
  }
}
