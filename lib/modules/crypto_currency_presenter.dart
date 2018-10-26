import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/crypto_injector.dart';

abstract class CryptoCurrencyListViewContract {
  void onLoadCryptoComplete(List<CryptoData> items);

  void onLoadCryptoError();
}

class CryptoCurrencyListPresenter {
  CryptoCurrencyListViewContract _view;
  CryptoStore _store;

  CryptoCurrencyListPresenter(this._view) {
    _store = new Injector().cryptoCurrencyStore;
  }

  void loadCurrency() {
    _store
        .getCryptoCurrency()
        .then((c) => _view.onLoadCryptoComplete(c))
        .catchError((onError) => _view.onLoadCryptoError());
  }
}
