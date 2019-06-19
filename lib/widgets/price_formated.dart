import 'package:flutter/material.dart';

class PriceFormatted extends StatelessWidget {
  const PriceFormatted({
    Key key,
    @required this.price,
    @required this.change,
  }) : super(key: key);

  final double price;
  final double change;

  @override
  Widget build(BuildContext context) {
    String priceFormatted = price.toStringAsFixed(2);
    TextSpan priceWidget = new TextSpan(
        text: "\$$priceFormatted",
        style: new TextStyle(color: Colors.black, fontSize: 18.0));
    String changeWidget = " $change%";
    TextSpan changeTextWidget;
    Color colourIndication;
    if ((change) >= 0) {
      colourIndication = Colors.green;
    } else {
      colourIndication = Colors.red;
    }

    changeTextWidget = new TextSpan(
        text: changeWidget,
        style: new TextStyle(color: colourIndication, fontSize: 18.0));

    return new RichText(
        text: new TextSpan(children: [priceWidget, changeTextWidget]));
  }
}