import 'dart:async';

class CryptoData {
  String name;
  String symbol;
  String price;
  String percent_change_1h;
  String percent_change_12h;
  String percent_change_24h;

  CryptoData({this.name, this.price, this.symbol});

  CryptoData.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        symbol = map['symbol'];
}

abstract class CryptoStore {
  Future<List<CryptoData>> getCryptoCurrency();
}

class GetDataException implements Exception {
  final _exception;

  GetDataException([this._exception]);

  String toString() {
    if (_exception == null) {
      return "Unknown";
    } else {
      return " Exception $_exception";
    }
  }
}
