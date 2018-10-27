import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/API_injector/crypto_injector.dart';

abstract class CryptoCurrencyListViewContract {
  void onLoadCryptoComplete(List<CryptoData> items);

  void onLoadCryptoError();
}

class CryptoCurrencyListPresenter {
  CryptoCurrencyListViewContract _view;
  CryptoStore _store;

  CryptoCurrencyListPresenter(this._view) {
    _store = new CryptoInjector().cryptoCurrencyStore;
  }

  void loadCurrency() {
    _store
        .getCryptoCurrency()
        .then((crypto) => _view.onLoadCryptoComplete(crypto))
        .catchError((onError) => _view.onLoadCryptoError());
  }
}
