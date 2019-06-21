import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:bitbuddy/data/crypto_data.dart';

class CryptoDataAPI implements CryptoStore {
  String coinMarketCapAPI =
      "https://api.coinmarketcap.com/v2/ticker/?limit=100&structure=array";

  @override
  Future<List<CryptoData>> getCryptoCurrency() async {
    http.Response response = await http.get(coinMarketCapAPI);

    final List responseBody = jsonDecode(response.body)['data'];
    final httpStatusCode = response.statusCode;
    print(responseBody);
    if (httpStatusCode != 200 || httpStatusCode == null) {
      throw new GetDataException("Error Status Code: $httpStatusCode");
    }
    return responseBody.map((crypto) => new CryptoData.fromMap(crypto)).toList();
  }

  Future<File> getCacheFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/crypo_cache.txt');
  }
}
