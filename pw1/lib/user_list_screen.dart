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

  String _searchQuery = ''; // ✅ holds the text for the search feature

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
    // Filter the grocery items based on search query
    final filteredItems = groceryItems
        .where((item) => item.name.toLowerCase().contains(_searchQuery))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Grocery List')),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // 🧾 Filtered Item List
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(child: Text('No items found.'))
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        color: item.approved ? Colors.lightGreen[100] : null,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: ListTile(
                          leading: Image.asset(
                            item.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            item.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${item.category} • \$${item.price.toStringAsFixed(2)}'),
                          
                          // ✅ Approval Toggle + Purchase Icon
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Approval toggle switch
                              Switch(
                                value: item.approved,
                                onChanged: (value) async {
                                  item.approved = value;
                                  await DBHelper.instance.updateItem(item);
                                  setState(() {});
                                },
                              ),
                              Icon(
                                item.purchased
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: item.purchased
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ],
                          ),

                          // Tap to edit item
                          onTap: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditItemScreen(item: item),
                              ),
                            );
                            if (updated == true) _loadItems();
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
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
