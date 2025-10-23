import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/grocery_item.dart';
import 'edit_item_screen.dart'; // <-- make sure this file exists

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  List<GroceryItem> groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  // ✅ Fetch items from DB
  Future<void> _loadItems() async {
    final items = await DBHelper.instance.getItems();
    setState(() {
      groceryItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Grocery List')),
      body: groceryItems.isEmpty
          ? const Center(child: Text('No items found.'))
          : ListView.builder(
              itemCount: groceryItems.length,
              itemBuilder: (context, index) {
                final item = groceryItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: Image.asset(
                      item.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${item.category} • \$${item.price.toStringAsFixed(2)}'),
                    trailing: Icon(
                      item.purchased ? Icons.check_circle : Icons.circle_outlined,
                      color: item.purchased ? Colors.green : Colors.grey,
                    ),
                    onTap: () async {
                      // ✅ Navigate to EditItemScreen
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditItemScreen(item: item),
                        ),
                      );

                      if (updated == true) {
                        _loadItems(); // refresh list after editing
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Back to home screen
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
