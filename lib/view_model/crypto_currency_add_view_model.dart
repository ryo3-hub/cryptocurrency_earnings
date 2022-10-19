import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../entity/cryptocurrency.dart';

class CryptoCurrencyAddViewModel with ChangeNotifier {
  // List<CryptoCurrency> currencyList = <CryptoCurrency>[];
  // List<CryptoCurrency> searchCurrencyList = <CryptoCurrency>[];
  late CryptoCurrency currency;

  // Future<void> searchCurrency(String symbol) async {
  //   searchCurrencyList = currencyList
  //       .where((element) => element.symbol.contains(symbol))
  //       .toList();
  //   print(symbol);
  //   print(searchCurrencyList[0].symbol);
  //   notifyListeners();
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   final coinsListJson = prefs.containsKey('coinsList2');
  //   print(coinsListJson);
  // }

  Future<void> searchCurrencyByAddress(String address) async {
    final coinJson = await getCoinByAddress(address);
    currency = CryptoCurrency.fromJson(coinJson);
    notifyListeners();
  }

  // Future<void> getCoinGeco2() async {
  //   final coinsListJson = prefs.getString('coinsList') ?? await getCoinsJson();
  //   print(coinsListJson);
  //
  //   final coinsListMap = jsonDecode(coinsListJson) as Map<String, dynamic>;
  //   final currency = CryptoCurrency.fromJson(coinsListMap);
  //
  //   currencyList = currency;
  //   // print(currencyList.length);
  //   notifyListeners();
  //   // final api = CoinGeckoApi();
  //   // final result = await api.coins.listCoins();
  //   //
  //   // if (!result.isError) {
  //   //   print('getCoinOHLC() results:$result');
  //   //   currencyList = result.data
  //   //       .map((e) => CryptoCurrency(id: e.id, symbol: e.symbol, name: e.name))
  //   //       .toList();
  //   //   notifyListeners();
  //   //   print('Test method completed successfully.');
  //   // } else {
  //   //   print('getCoinOHLC() method returned error:');
  //   //   print('${result.errorCode}: ${result.errorMessage}');
  //   //   print('Test method failed.');
  //   // }
  // }

  Future<Map<String, dynamic>> getCoinByAddress(String address) async {
    final response = await http.get(
      Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/info?address=$address',
      ),
      headers: {
        'X-CMC_PRO_API_KEY': '868a19d4-9f35-4d73-8fb0-384e06dafdfe',
        'Accept': 'application/json',
      },
    );
    return _response(response);
  }

  Map<String, dynamic> _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body) as Map<String, dynamic>;
      case 400:
        // 400 Bad Request : 一般的なクライアントエラー
        throw Exception('一般的なクライアントエラーです');
      case 401:
        // 401 Unauthorized : アクセス権がない、または認証に失敗
        throw Exception('アクセス権限がない、または認証に失敗しました');
      case 403:
        // 403 Forbidden ： 閲覧権限がないファイルやフォルダ
        throw Exception('閲覧権限がないファイルやフォルダです');
      case 500:
        // 500 何らかのサーバー内で起きたエラー
        throw Exception('何らかのサーバー内で起きたエラーです');
      default:
        // それ以外の場合
        throw Exception('何かしらの問題が発生しています');
    }
  }
}
