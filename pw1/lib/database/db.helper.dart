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
        price REAL,
        description TEXT,
        quantity INTEGER,
        purchased BOOL,
        image TEXT,
        approved TEXT,
        priority TEXT
      )
    ''');  
  }

  await _initialdata(db);
}

Future<void> _initialdata(Database db) async{
    final sample = [
        {
        'name': 'Banana',
        'category': 'Fruits',
        'quantity': 6,
        'price': 2.99,
        'description': 'Banana is high in potassium, and a great source of fiber.',
        'image': 'assets/images/bananas.png',
        'purchased': 0,
        },
        {
        'name': 'Yogurt',
        'category': 'Dairy',
        'quantity': 4,
        'price': 1.99,
        'description': 'Creamy, rich, smooth, great source of calcium, helps with digestion.',
        'image': 'assets/images/yogurt.png',
        'purchased': 0,
        },
        {
        'name': 'Bread',
        'category': 'Bakery',
        'quantity': 1,
        'price': 2.49,
        'description': 'Whole wheat sandwich bread loaf.',
        'image': 'assets/images/bread.png',
        'purchased': 0,
        },
        {
        'name': 'Bread',
        'category': 'Bakery',
        'quantity': 1,
        'price': 4.99,
        'description': 'Whole oat bread, good for deli sandwhiches, and pb & js.',
        'image': 'assets/images/bread.png',
        'purchased': 0,
        },
        {
        'name': 'Eggs',
        'category': 'Poultry',
        'quantity': 12,
        'price': 4.99,
        'description': 'One dozen large free-range eggs, organic.',
        'image': 'assets/images/eggs.png',
        'purchased': 0,
        },
        {
        'name': 'Chicken Breast',
        'category': 'Meat',
        'quantity': 4,
        'price': 10.99,
        'description': 'Boneless skinless chicken breasts (1 lb).',
        'image': 'assets/images/chicken.png',
        'purchased': 0,
        },
        {
        'name': 'Rice',
        'category': 'Grain',
        'quantity': 1,
        'price': 4.49,
        'description': 'Long grain white rice, 5 lb bag.',
        'image': 'assets/images/rice.png',
        'purchased': 0,
        },
        {
        'name': 'Apple Cider',
        'category': 'Beverages',
        'quantity': 1,
        'price': 3.59,
        'description': 'Freshly squeezed apple cider, gallon.',
        'image': 'assets/images/applecider.png',
        'purchased': 0,
        },
        {
        'name': 'Brocolli Crowns',
        'category': 'Vegetable',
        'quantity': 2,
        'price': 1.99,
        'description': 'Great green, high in sulfur, and great with blue cheese.',
        'image': 'assets/images/brocolli.png',
        'purchased': 0,
        },
        {
        'name': 'Alfredo Sauce',
        'category': 'Pantry',
        'quantity': 1,
        'price': 2.29,
        'description': 'Classic Italian-style Alfredo, 24 oz jar.',
        'image': 'assets/images/sauce.png',
        'purchased': 0,
        },
        {
        'name': 'Clorox Bleach',
        'category': 'Cleaning_Supplies',
        'quantity': 1,
        'price': 10.99,
        'description': 'Bottle of foam bleach, good for removing mold, bacteria.',
        'image': 'assets/images/clorox.png',
        'purchased': 0,
        }

    ];
}

for (var in in sample){
    await db.insert('groceries', item.toMap());
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