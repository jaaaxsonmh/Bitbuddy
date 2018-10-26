import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bitbuddy/data/crypto_data.dart';

class CryptoDataProducer implements CryptoStore {
  String coinMarketCapAPI =
      "https://api.coinmarketcap.com/v2/ticker/?limit=50";

  @override
  Future<List<CryptoData>> getCryptoCurrency() async {
    http.Response response = await http.get(coinMarketCapAPI);

    final List responseBody = json.decode(response.body)['data'];
    final httpStatusCode = response.statusCode;
    print(responseBody);
    if (httpStatusCode != 200 || httpStatusCode == null) {
      throw new GetDataException("Error Status Code: $httpStatusCode");
    }
    return responseBody.map((c) => new CryptoData.fromMap(c)).toList();
  }
}
