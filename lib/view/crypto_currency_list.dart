import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/cryptocurrency.dart';
import 'crypto_currency_add.dart';

class CryptoCurrencyList extends StatelessWidget {
  const CryptoCurrencyList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CryptoCurrencyViewModel>().selectAllCryptoCurrency();
    return Scaffold(
      appBar: AppBar(title: const Text('仮想通貨一覧')),
      body: Consumer<CryptoCurrencyViewModel>(
        builder: (context, model, snapshot) {
          return ListView.builder(
            itemCount: model.cryptoCurrencyList.length,
            itemBuilder: (BuildContext itemContext, int index) {
              return Text(model.cryptoCurrencyList[index].name);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // ＋ボタンを下に表示する
        child: const Icon(Icons.add), // ボタンの形を指定
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => CryptoCurrencyAdd(),
            ),
          );
        },
      ),
    );
  }

  // 追加処理の呼び出し
  Future<void> createCryptoCurrency() async {
    final cryptoCurrency = CryptoCurrency(
      id: 'aaa',
      name: 'bbb',
      symbol: 'ccc',
    );
    await CryptoCurrencyViewModel.instance
        .insert(cryptoCurrency); // catの内容で追加する
  }
}
