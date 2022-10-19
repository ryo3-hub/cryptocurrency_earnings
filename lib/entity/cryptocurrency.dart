import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CryptoCurrency {
  CryptoCurrency({required this.id, required this.symbol, required this.name});

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) => CryptoCurrency(
        id: json['id'] as String,
        symbol: json['symbol'] as String,
        name: json['name'] as String,
      );
  String id = '';
  String symbol = '';
  String name = '';
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'name': name,
    };
  }
}

// cryptoCurrencyテーブルのカラム名を設定
const String columnId = 'id';
const String columnSymbol = 'symbol';
const String columnName = 'name';

// cryptoCurrencyテーブルのカラム名をListに設定
const List<String> columns = [
  columnId,
  columnSymbol,
];

// cryptoCurrencyテーブルへのアクセスをまとめたクラス
class CryptoCurrencyViewModel with ChangeNotifier {
  CryptoCurrencyViewModel();

  CryptoCurrencyViewModel._createInstance();
  List<CryptoCurrency> cryptoCurrencyList = [];
  // DbHelperをinstance化する
  static final instance = CryptoCurrencyViewModel._createInstance();
  static Database? _database;

  // databaseをオープンしてインスタンス化する
  Future<Database> get database async {
    return _database ??= await _initDB(); // 初回だったら_initDB()=DBオープンする
  }

  // データベースをオープンする
  Future<Database> _initDB() async {
    final path = join(
      await getDatabasesPath(),
      'crypto_currency.db',
    );

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate, // cryptoCurrency.dbがなかった時の処理を指定する（DBは勝手に作られる）
    );
  }

  // データベースがなかった時の処理
  Future<void> _onCreate(Database database, int version) async {
    //cryptoCurrencyテーブルをcreateする
    await database.execute('''
      CREATE TABLE crypto_currency(
        id TEXT PRIMARY KEY,
        symbol TEXT,
        name TEXT
      )
    ''');
  }

  Future<void> selectAllCryptoCurrency() async {
    final db = await instance.database;
    final cryptoCurrencyData =
        await db.query('crypto_currency'); // 条件指定しないでcryptoCurrencyテーブルを読み込む

    cryptoCurrencyList =
        cryptoCurrencyData.map(CryptoCurrency.fromJson).toList();
    notifyListeners();
  }

  Future<CryptoCurrency> getCurrency(int id) async {
    final db = await instance.database;
    final currency = await db.query(
      'crypto_currency',
      columns: columns,
      where: 'id = ?', // 渡されたidをキーにしてcryptoCurrencyテーブルを読み込む
      whereArgs: [id],
    );
    return CryptoCurrency.fromJson(currency.first); // 1件だけなので.toListは不要
  }

  Future<void> insert(CryptoCurrency cryptoCurrency) async {
    final db = await database;
    await db.insert('crypto_currency', cryptoCurrency.toJson());
  }

  Future<void> update(CryptoCurrency cryptoCurrency) async {
    final db = await database;
    await db.update(
      'crypto_currency',
      cryptoCurrency.toJson(),
      where: 'id = ?', // idで指定されたデータを更新する
      whereArgs: [cryptoCurrency.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await instance.database;
    await db.delete(
      'crypto_currency',
      where: 'id = ?', // idで指定されたデータを削除する
      whereArgs: [id],
    );
  }
}
