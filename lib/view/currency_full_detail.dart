import 'package:flutter/material.dart';
import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/widgets/price_formated.dart';

class CurrencyFullDetail extends StatefulWidget {
  final CryptoData currencyList;

  CurrencyFullDetail(this.currencyList);

  @override
  CurrencyFullDetailState createState() =>
      new CurrencyFullDetailState(currencyList);
}

class CurrencyFullDetailState extends State<CurrencyFullDetail> {
  final CryptoData currencyList;

  CurrencyFullDetailState(this.currencyList);

  final TextEditingController _controllerCrypto = new TextEditingController();
  final TextEditingController _controllerFiat = new TextEditingController();

  String cryptoString = "";
  String fiatString = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: Image.asset("images/bitbuddylogo.jpg"),
        backgroundColor: Color.fromRGBO(115, 222, 255, 1.0),
        title: new Text(currencyList.name + " Summary",
            style: new TextStyle(color: Colors.white, fontSize: 28.0)),
        centerTitle: true,
      ),
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
              child: new Text("Currency Ticker",
                  style: new TextStyle(
                    fontSize: 32.0,
                    color: Color.fromRGBO(115, 222, 255, 1.0),

                  )),
            ),
            _buildHeaderCard(currencyList),
            new Padding(padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
              child: new Text("Currency Converter",
                  style: new TextStyle(
                    fontSize: 32.0,
                    color: Color.fromRGBO(115, 222, 255, 1.0),

                  )),
            ),
            _buildConverterCalculator(currencyList),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(CryptoData currencyList) {
    return new Container(
      padding: EdgeInsets.only(top: 16.0),
      child: new GestureDetector(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Color.fromRGBO(115, 222, 255, 1.0),
                    child: Image.network(
                        "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@0b37b127fbec5091a47921deeba2dce2c1f8eb16/128/color/" +
                            currencyList.symbol.toLowerCase() +
                            ".png")),
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
        ),
    );
  }

  Widget _buildConverterCalculator(CryptoData currencyList) {
    return new Container(

      margin: new EdgeInsets.all(5.0),
      child: new Column(
        children: <Widget>[
          new Stack(alignment: const Alignment(1.0, 0.5), children: <Widget>[
            new TextField(
              controller: _controllerCrypto,
              maxLines: 1,
              keyboardType: TextInputType.number,
              onChanged: (newValue) {
                setState(() {
                  cryptoString = newValue.trim();
                  if (fiatString.length == 0) {
                    _controllerFiat.text = "Nothing here yet";
                  }
                  _controllerFiat.text =
                      "\$" + (double.parse(cryptoString) * (currencyList.price))
                          .toString();
                });
              },
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                labelText: currencyList.symbol,
                hintText: "Enter Crypto Currency Amount",

              ),
              textAlign: TextAlign.center,
            ),
            clearField(),
          ]),
          new Divider(color: Color.fromRGBO(115, 222, 255, 1.0)),
          new Stack(alignment: const Alignment(1.0, 0.5), children: <Widget>[
            new TextField(
              controller: _controllerFiat,
              maxLines: 1,
              keyboardType: TextInputType.number,
              onChanged: (newValue) {
                setState(() {
                  fiatString = newValue.trim();
                  if (cryptoString.length == 0) {
                    _controllerCrypto.text = "Nothing here yet";
                  }
                  if ((double.parse(fiatString) /
                      (currencyList.price))
                      .toString()
                      .length >=
                      10) {
                    _controllerCrypto.text = (double.parse(fiatString) /
                        (currencyList.price))
                        .toString();
                  } else {
                    _controllerCrypto.text = (double.parse(fiatString) /
                        (currencyList.price))
                        .toString();
                  }
                });
              },
              decoration: new InputDecoration(
                border: InputBorder.none,
                contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                labelText: "USD",
                hintText: "Enter Fiat Currency Amount",
              ),
              textAlign: TextAlign.center,
            ),
            clearField()
          ]),
        ],
      ),
    );
  }

  FlatButton clearField() {
    return new FlatButton(
        onPressed: () {
          _controllerCrypto.clear();
          _controllerFiat.clear();
        },
        child: new Icon(
          Icons.clear,
          color: Colors.black,
        ));
  }
}
