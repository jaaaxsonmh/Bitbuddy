
import 'package:flutter/material.dart';
import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/widgets/price_formated.dart';

class CurrencyFullDetail extends StatefulWidget {
  final CryptoData currencyList;
  CurrencyFullDetail(this.currencyList);

@override
CurrencyFullDetailState createState() => new CurrencyFullDetailState();
}

class CurrencyFullDetailState extends State<CurrencyFullDetail> {

  CryptoData currencyList;

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
        title: new Text("Currency Summary",
            style: new TextStyle(color: Colors.white, fontSize: 28.0)),
        centerTitle: true,
      ),
      body: new Container(
        child: _buildHeaderCard(currencyList) +  _buildConverterCalculator(currencyList),
      ),
    );
  }

  Widget _buildHeaderCard(CryptoData currencyList) {
    return new Container(
      child: new Card(
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
                            ".png") /*new Text(currencyList['symbol'], style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18.0),),*/
                ),
                title: new Text(currencyList.name,
                    style: new TextStyle(color: Colors.black, fontSize: 24.0)),
                subtitle:  new PriceFormatted(price: currencyList.price, change: currencyList.percentChange1h),
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
      ),
    );
  }

  Widget _buildConverterCalculator(CryptoData currencyList) {
    new Container(
        margin: new EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),

        decoration: new BoxDecoration(
          color: new Color(0xFFFFFFFF),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: new Color(0xFFee0979),
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
        ),

        child: new Column(children: <Widget>[
        new Stack(
        alignment: const Alignment(1.0, 0.5),
        children: <Widget>[
          new TextField(
            controller: _controllerCrypto,
            maxLines: 1,
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              setState(() {
                cryptoString = newValue.trim();
                if(fiatString.length==0){
                  _controllerFiat.text = " ";
                }
                _controllerFiat.text = (double.parse(cryptoString)*double.parse(widget.crypto.priceUsd)).toString();
              });
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              hintStyle: Theme.TextStyles.commonTextStyle,
              labelStyle: Theme.TextStyles.commonTextStyle,
              labelText: currencyList.symbol,
            ),
            textAlign: TextAlign.center,
          ),
          new FlatButton(
              onPressed: () {
                _controllerCrypto.clear();
                _controllerFiat.clear();
              },
              child: new Icon(Icons.clear, color: Colors.black,)
          ),
        ]
    ),
  }
}