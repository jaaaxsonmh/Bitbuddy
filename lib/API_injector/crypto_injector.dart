import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/data/currency_data_api.dart';


enum CryptoFlavour { API }

class CryptoInjector {
  static final CryptoInjector _singleton = new CryptoInjector._internal();
  static CryptoFlavour _flavour;

  static void configure(CryptoFlavour flavour){
    _flavour = flavour;
  }

  factory CryptoInjector() {
    return _singleton;
  }

  CryptoInjector._internal();

  CryptoStore get cryptoCurrencyStore {
        return new CryptoDataAPI();
  }
}