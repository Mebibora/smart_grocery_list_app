import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/grocery_item.dart';
import 'edit_item_screen.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  List<GroceryItem> groceryItems = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  //  Fetch items from DB
  Future<void> _loadItems() async {
    final items = await DBHelper.instance.getItems();
    setState(() {
      groceryItems = items;
    });
  }

  // Helper: choose color based on priority
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "I need now":
        return Colors.redAccent;
      case "I kinda need":
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter items according to search
    final filteredItems = groceryItems
        .where((item) => item.name.toLowerCase().contains(_searchQuery))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Grocery List')),
      body: Column(
        children: [
          // Search Bar
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

          //List of Items
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(child: Text('No items found.'))
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        color: item.approved
                            ? _getPriorityColor(item.priority).withOpacity(0.15)
                            : null,
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
                            '${item.category} • ${item.priority} • \$${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: _getPriorityColor(item.priority),
                            ),
                          ),

                          //Approval switch + purchased icon
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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

      // back to the home screen 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
