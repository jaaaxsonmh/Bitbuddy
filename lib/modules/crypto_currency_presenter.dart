import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bitbuddy/data/crypto_data.dart';
import 'package:bitbuddy/API_injector/crypto_injector.dart';
import 'package:path_provider/path_provider.dart';

abstract class CryptoCurrencyListViewContract {
  void onLoadCryptoComplete(List<CryptoData> items);

  void onLoadCryptoError();
}

class CryptoCurrencyListPresenter {
  CryptoCurrencyListViewContract _view;
  CryptoStore _store;
  List data;

  CryptoCurrencyListPresenter(this._view) {
    _store = new CryptoInjector().cryptoCurrencyStore;
  }

  void loadCurrency() {
    _store
        .getCryptoCurrency()
        .then((crypto) => _view.onLoadCryptoComplete(crypto))
        .catchError((onError) => _view.onLoadCryptoError());
  }

  Future<File> getCacheFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/crypo_cache.txt');
  }

  Future<bool> getDataFromCache() async {
    try {
      File file = await getCacheFile();
      String c = await file.readAsString();
      data = json.decode(c);
      _view.onLoadCryptoComplete(data);
      return true;
    } catch (FileSystemException) {
      return false;
    }
  }

  Future<bool> getData() async {
    if (!(await getDataFromCache())) {
      loadCurrency();
    }
    return true;
  }

  Future loadData() async {
    loadCurrency();
    await getData();
  }
}
