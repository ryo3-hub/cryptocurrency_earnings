import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/crypto_currency_add_view_model.dart';

class CryptoCurrencyAdd extends StatelessWidget {
  CryptoCurrencyAdd({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cryptoCurrencyAddVM = context.read<CryptoCurrencyAddViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('仮想通貨追加')),
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: searchController,
                  decoration: customSearchInputDecoration(
                    hintText: '検索したいタイトルを入力',
                    labelText: '',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  cryptoCurrencyAddVM
                      .searchCurrencyByAddress(searchController.text);
                },
                child: Text('click'),
              )
            ],
          ),
          Flexible(
            child: Consumer<CryptoCurrencyAddViewModel>(
              builder: (context, model, snapshot) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration customSearchInputDecoration(
      {required String labelText, required String hintText}) {
    return InputDecoration(
      prefixIcon: Icon(Icons.search),
      fillColor: Colors.white,
      focusedBorder: _outlineInputBorder(Colors.blue, radius: 15),
      enabledBorder:
          _outlineInputBorder(Color.fromRGBO(0, 0, 0, 0.2), radius: 15),
      isCollapsed: true,
      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      // border: OutlineInputBorder(),
      alignLabelWithHint: true,
      // labelText: "テキストボックス",
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 0.3),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color,
      {required double radius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        width: 2,
        color: color,
      ),
    );
  }
}
