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

    if ((change) >= 0) {
      changeTextWidget = new TextSpan(
          text: changeWidget,
          style: new TextStyle(color: Colors.green, fontSize: 18.0));
    } else {
      changeTextWidget = new TextSpan(
          text: changeWidget,
          style: new TextStyle(color: Colors.red, fontSize: 18.0));
    }

    return new RichText(
        text: new TextSpan(children: [priceWidget, changeTextWidget]));
  }
}