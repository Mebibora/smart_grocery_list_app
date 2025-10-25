import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/grocery_item.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'grocery_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTable(db);
        await _insertSampleData(db); // prepopulate data
      },
    );
  }

  Future<void> _createTable(Database db) async {
    await db.execute('''
      CREATE TABLE groceries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT,
        quantity INTEGER,
        price REAL,
        description TEXT,
        image TEXT,
        purchased INTEGER,
        approved INTEGER,
        priority TEXT
      )
    ''');
  }

  // 🥬 Prepopulate 10 sample grocery items
  Future<void> _insertSampleData(Database db) async {
    final sampleItems = [
      GroceryItem(
        name: 'Apples',
        category: 'Produce',
        quantity: 4,
        price: 3.99,
        description: 'Fresh red apples',
        image: 'assets/images/apple.png',
        purchased: false,
        approved: false,
        priority: 'I need now',
      ),
      GroceryItem(
        name: 'Bananas',
        category: 'Produce',
        quantity: 6,
        price: 2.49,
        description: 'Ripe yellow bananas',
        image: 'assets/images/bananas.png',
        purchased: false,
        approved: false,
        priority: 'I kinda need',
      ),
      GroceryItem(
        name: 'Milk',
        category: 'Dairy',
        quantity: 1,
        price: 2.89,
        description: '1 Gallon of whole milk',
        image: 'assets/images/milk.png',
        purchased: false,
        approved: false,
        priority: 'I need now',
      ),
      GroceryItem(
        name: 'Bread',
        category: 'Bakery',
        quantity: 1,
        price: 2.19,
        description: 'Whole grain sandwich bread',
        image: 'assets/images/bread.png',
        purchased: false,
        approved: false,
        priority: 'I kinda need',
      ),
      GroceryItem(
        name: 'Eggs',
        category: 'Dairy',
        quantity: 12,
        price: 4.29,
        description: 'Free-range brown eggs (dozen)',
        image: 'assets/images/eggs.png',
        purchased: false,
        approved: false,
        priority: 'I need now',
      ),
      GroceryItem(
        name: 'Orange Juice',
        category: 'Beverages',
        quantity: 1,
        price: 3.59,
        description: '1L of fresh orange juice',
        image: 'assets/images/orange_juice.png',
        purchased: false,
        approved: false,
        priority: 'I kinda need',
      ),
      GroceryItem(
        name: 'Chips',
        category: 'Snacks',
        quantity: 2,
        price: 1.99,
        description: 'Crunchy potato chips',
        image: 'assets/images/chips.png',
        purchased: false,
        approved: false,
        priority: "I don't need",
      ),
      GroceryItem(
        name: 'Toilet Paper',
        category: 'Household',
        quantity: 6,
        price: 6.99,
        description: '6-pack of soft toilet paper',
        image: 'assets/images/toilet_paper.png',
        purchased: false,
        approved: false,
        priority: 'I need now',
      ),
      GroceryItem(
        name: 'Chicken Breast',
        category: 'Meat',
        quantity: 2,
        price: 8.49,
        description: 'Fresh skinless chicken breast',
        image: 'assets/images/chicken.png',
        purchased: false,
        approved: false,
        priority: 'I need now',
      ),
      GroceryItem(
        name: 'Yogurt',
        category: 'Dairy',
        quantity: 4,
        price: 5.49,
        description: 'Greek yogurt assorted flavors',
        image: 'assets/images/yogurt.png',
        purchased: false,
        approved: false,
        priority: 'I kinda need',
      ),
    ];

    for (var item in sampleItems) {
      await db.insert('groceries', item.toMap());
    }
  }

  // ✅ CRUD methods

  Future<int> insertItem(GroceryItem item) async {
    final db = await database;
    return await db.insert('groceries', item.toMap());
  }

  Future<List<GroceryItem>> getItems() async {
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
}
