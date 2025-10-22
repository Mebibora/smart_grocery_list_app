import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/grocery_item.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'grocery_list.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE groceries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT,
        quantity INTEGER,
        purchased BOOL
      )
    ''');
  }

  Future<int> insertItem(GroceryItem item) async {
    final db = await database;
    return await db.insert('groceries', item.toMap());
  }

  Future<List<GroceryItem>> getItems() async {    // quantity for the items 
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('groceries');
    return List.generate(maps.length, (i) => GroceryItem.fromMap(maps[i]));
  }

  Future<int> updateItem(GroceryItem item) async {
    final db = await database;
    return await db.update(
      'groceries',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(
      'groceries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete('groceries');
  }
}
