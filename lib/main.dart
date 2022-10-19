import 'package:cryptocurrency_earnings/view/crypto_currency_list.dart';
import 'package:cryptocurrency_earnings/view_model/crypto_currency_add_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'entity/cryptocurrency.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // taskScheduler();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CryptoCurrencyViewModel>(
          create: (_) => CryptoCurrencyViewModel(),
        ),
        ChangeNotifierProvider<CryptoCurrencyAddViewModel>(
          create: (_) => CryptoCurrencyAddViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CryptoCurrencyList(),
      ),
    );
  }

  void _responseCheck(http.Response response) {
    switch (response.statusCode) {
      case 200:
        print('成功');
        break;
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   bool isFirst = false;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   void getRequests() async {
//     setState(() {
//       isFirst = true;
//     });
//
//     // final url = Uri.parse('https://api.coingecko.com/api/v3/coins/list');
//     //
//     // // var endpoint = "/coins/list";
//     // var r = await http.post(url, body: {
//     //   'key': 'value',
//     // });
//
//     var response = await http.get(Uri.https(
//         'api.coingecko.com',
//         '/api/v3/coins/list',
//         {'q': '{Flutter}', 'maxResults': '40', 'langRestrict': 'ja'},),);
//
//     final jsonResponse = _response(response);
//     // print(jsonResponse);
//
//     // r.raiseForStatus();
//     // String body = r.content();
//     // var symbol = ['btc', 'eth', 'grt', 'xrp', 'ltc', 'mona'];
//     // var a = body.split("}");
//     // for (var i in r.json()) {
//     //   // if (symbol.contains(i["symbol"])) {
//     //   print('${i['symbol']} ⇒ ${i['id']}');
//     //   // }
//     // }
//     for (var i in jsonResponse) {
//       // if (symbol.contains(i["symbol"])) {
//       // print(i);
//       // }
//       if (i["symbol"] == "anta") {
//         print(i);
//       }
//     }
//
//     // print("getRequests Start");
//     // print(body.toString());
//   }
//
//   dynamic _response(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
//         return responseJson;
//       case 400:
//         // 400 Bad Request : 一般的なクライアントエラー
//         throw Exception('一般的なクライアントエラーです');
//       case 401:
//         // 401 Unauthorized : アクセス権がない、または認証に失敗
//         throw Exception('アクセス権限がない、または認証に失敗しました');
//       case 403:
//         // 403 Forbidden ： 閲覧権限がないファイルやフォルダ
//         throw Exception('閲覧権限がないファイルやフォルダです');
//       case 500:
//         // 500 何らかのサーバー内で起きたエラー
//         throw Exception('何らかのサーバー内で起きたエラーです');
//       default:
//         // それ以外の場合
//         throw Exception('何かしらの問題が発生しています');
//     }
//   }
//
//   getCoinGeco() async {
//     setState(() {
//       isFirst = true;
//     });
//     final api = CoinGeckoApi();
//     // final result = await api.coins.getCoinOHLC(
//     //   id: 'bitcoin',
//     //   vsCurrency: 'usd',
//     //   days: 7,
//     // );
//
//     final CoinGeckoResult<List<CoinShort>> result = await api.coins.listCoins();
//
//     if (!result.isError) {
//       print('getCoinOHLC() results:${result}');
//       for (var i in result.data) {
//         // if (symbol.contains(i["symbol"])) {
//         // print(i);
//         // }
//         if (i.symbol == "anta") {
//           print(i);
//         }
//       }
//       print('Test method completed successfully.');
//     } else {
//       print('getCoinOHLC() method returned error:');
//       print('${result.errorCode}: ${result.errorMessage}');
//       print('Test method failed.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     if (!isFirst) {
//       getCoinGeco();
//     }
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> _memo = [];
//
//   bool _isLoading = true;
//
//   void _refreshJournals() async {
//     final data = await NoteViewModel.getNotes();
//     setState(() {
//       _memo = data;
//       _isLoading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _refreshJournals();
//   }
//
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//
//   void _showForm(int? id) async {
//     if (id != null) {
//       final existingJournal =
//           _memo.firstWhere((element) => element['id'] == id);
//       _titleController.text = existingJournal['title'];
//       _descriptionController.text = existingJournal['description'];
//     }
//
//     showModalBottomSheet(
//         context: context,
//         elevation: 5,
//         isScrollControlled: true,
//         builder: (_) => Container(
//               padding: EdgeInsets.only(
//                 top: 15,
//                 left: 15,
//                 right: 15,
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 120,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   TextField(
//                     controller: _titleController,
//                     decoration: const InputDecoration(hintText: 'Title'),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: _descriptionController,
//                     decoration: const InputDecoration(hintText: 'Description'),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (id == null) {
//                         await _addItem();
//                       }
//
//                       if (id != null) {
//                         await _updateItem(id);
//                       }
//                       _titleController.text = '';
//                       _descriptionController.text = '';
//
//                       Navigator.of(context).pop();
//                     },
//                     child: Text(id == null ? 'Create New' : 'Update'),
//                   )
//                 ],
//               ),
//             ));
//   }
//
//   Future<void> _addItem() async {
//     await NoteViewModel.createItem(
//         _titleController.text, _descriptionController.text);
//     _refreshJournals();
//   }
//
//   Future<void> _updateItem(int id) async {
//     await NoteViewModel.updateItem(
//         id, _titleController.text, _descriptionController.text);
//     _refreshJournals();
//   }
//
//   void _deleteItem(int id) async {
//     await NoteViewModel.deleteItem(id);
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Successfully deleted a journal!'),
//     ));
//     _refreshJournals();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notes'),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: _memo.length,
//               itemBuilder: (context, index) => Card(
//                 color: Colors.deepPurple[200],
//                 margin: const EdgeInsets.all(15),
//                 child: ListTile(
//                     title: Text(_memo[index]['title']),
//                     subtitle: Text(_memo[index]['description']),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             onPressed: () => _showForm(_memo[index]['id']),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () => _deleteItem(_memo[index]['id']),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () => _showForm(null),
//       ),
//     );
//   }
// }
