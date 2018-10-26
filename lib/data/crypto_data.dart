import 'dart:async';

class CryptoData {
  String name;
  String symbol;
  double price;
  double percent_change_1h;
  double percent_change_12h;
  double percent_change_24h;

  CryptoData(
      {this.name,
      this.price,
      this.symbol,
      this.percent_change_1h,
      this.percent_change_12h,
      this.percent_change_24h});

  CryptoData.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        price = map['quotes']['USD']['price'],
        percent_change_1h = map['quotes']['USD']['percent_change_1h'],
        percent_change_12h = map['quotes']['USD']['percent_change_12h'],
        percent_change_24h = map['quotes']['USD']['percent_change_24h'],
        symbol = map['symbol'];
}

abstract class CryptoStore {
  Future<List<CryptoData>> getCryptoCurrency();
}

class GetDataException implements Exception {
  final _exception;

  GetDataException([this._exception]);

  String toString() {
    if (_exception == null) return "Unknown";
      return " Exception $_exception";
  }
}
