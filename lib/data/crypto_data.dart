import 'dart:async';

class CryptoData {
  int id;
  String name;
  String symbol;
  String websiteSlug;
  int rank;
  double circulatingSupply;
  double totalSupply;
  double maxSupply;
  double price;
  double volume_24hour;
  double marketCap;
  double percentChange1h;
  double percentChange12h;
  double percentChange24h;

  CryptoData(
      {this.id,
      this.name,
      this.symbol,
      this.websiteSlug,
      this.rank,
      this.circulatingSupply,
      this.totalSupply,
      this.maxSupply,
      this.price,
      this.volume_24hour,
      this.marketCap,
      this.percentChange1h,
      this.percentChange12h,
      this.percentChange24h});

  CryptoData.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        symbol = map['symbol'],
        websiteSlug = map['website_slug'],
        rank = map['rank'],
        circulatingSupply = map['circulating_supply'],
        totalSupply = map['total_supply'],
        price = map['quotes']['USD']['price'],
        volume_24hour = map['quotes']['USD']['volume_24hour'],
        marketCap = map['quotes']['USD']['market_cap'],
        percentChange1h = map['quotes']['USD']['percent_change_1h'],
        percentChange12h = map['quotes']['USD']['percent_change_12h'],
        percentChange24h = map['quotes']['USD']['percent_change_24h'];
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
