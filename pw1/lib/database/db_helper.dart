import 'dart:math'; // 👈 Added for random price generation
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/grocery_item.dart';

// Generates a random price between $1.00 and $20.99
double generateRandomPrice() {
  final random = Random();

  // Random whole number between 1–20
  int base = random.nextInt(20) + 1;

  // Randomly decide whether to add .99 or not
  bool addCents = random.nextBool();

  // Calculate final price
  double price = addCents ? base + 0.99 : base.toDouble();

  // Return value rounded to 2 decimal places
  return double.parse(price.toStringAsFixed(2));
}

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
    // You can change the db name if you want to reset pre-populated data
    String path = join(await getDatabasesPath(), 'grocery_app_v2.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTable(db);
        await _insertSampleData(db); // Prepopulate data
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

  // Prepopulate 10 sample grocery items
  Future<void> _insertSampleData(Database db) async {
    final sampleItems = [
      GroceryItem(
        name: 'Apples',
        category: 'Produce',
        quantity: 4,
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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
        price: generateRandomPrice(),
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

  // CRUD methods
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
