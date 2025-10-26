import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/grocery_item.dart';
import 'edit_item_screen.dart';
import 'globals.dart'; 

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> with ChangeNotifier {
  String _searchQuery = '';
  double _scale = 1.0; // Variable for bounce animation

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  // Fetch items from DB
  Future<void> _loadItems() async {
    final items = await DBHelper.instance.getItems();
    setState(() {
      groceryItems = items;
    });
  }

  // Helper: choose color based on priority
  Color _getPriorityColor(String priority, bool purchased) {
    if (purchased) {
      return Colors.green;
    } else {
      switch (priority) {
        case "I need now":
          return Colors.redAccent;
        case "I kinda need":
          return Colors.orangeAccent;
        default:
          return Colors.grey;
      }
    }
  }

  // Bounce animation for approval switch
  void _swell() async {
    if (!animationsEnabled) return; // Disable bounce if animations turned off

    setState(() => _scale = 1.1);
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _scale = 1.0);
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

          // List of Items
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(child: Text('No items found.'))
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return AnimatedScale(
                        // Scale animation respects the toggle
                        scale: animationsEnabled ? _scale : 1.0,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut,
                        child: Card(
                          color: item.approved
                              ? _getPriorityColor(item.priority, item.purchased)
                                  .withOpacity(0.15)
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${item.category} • ${item.priority} • \$${item.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: _getPriorityColor(
                                    item.priority, item.purchased),
                              ),
                            ),

                            // Approval switch + purchased icon
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Switch(
                                  value: item.approved,
                                  onChanged: (value) async {
                                    item.approved = value;
                                    await DBHelper.instance.updateItem(item);
                                    _swell(); // Bounce if enabled
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // Back to home screen button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
