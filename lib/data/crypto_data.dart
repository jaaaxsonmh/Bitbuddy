import 'dart:async';

class CryptoData {
  int id;
  String name;
  String symbol;
  String website_slug;
  int rank;
  double circulating_supply;
  double total_supply;
  double max_supply;
  double price;
  double volume_24hour;
  double market_cap;
  double percent_change_1h;
  double percent_change_12h;
  double percent_change_24h;

  CryptoData(
      {this.id,
      this.name,
      this.symbol,
      this.website_slug,
      this.rank,
      this.circulating_supply,
      this.total_supply,
      this.max_supply,
      this.price,
      this.volume_24hour,
      this.market_cap,
      this.percent_change_1h,
      this.percent_change_12h,
      this.percent_change_24h});

  CryptoData.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        symbol = map['symbol'],
        website_slug= map['website_slug'],
        rank = map['rank'],
        circulating_supply = map['circulating_supply'],
        price = map['quotes']['USD']['price'],
        percent_change_1h = map['quotes']['USD']['percent_change_1h'],
        percent_change_12h = map['quotes']['USD']['percent_change_12h'],
        percent_change_24h = map['quotes']['USD']['percent_change_24h'];
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
