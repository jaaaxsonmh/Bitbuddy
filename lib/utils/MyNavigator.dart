import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/routers.dart';
import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/view/currency_full_detail.dart';

class MyNavigator{
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, Routers.home);
  }

  static void goToCurrencyDetailPage(BuildContext context, CryptoData currencyList) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrencyFullDetail(currencyList)),
    );
  }
}