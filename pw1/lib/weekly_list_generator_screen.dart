import 'dart:math';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/grocery_item.dart';

class WeeklyListGeneratorScreen extends StatefulWidget {
  const WeeklyListGeneratorScreen({super.key});

  @override
  State<WeeklyListGeneratorScreen> createState() =>
      _WeeklyListGeneratorScreenState();
}

class _WeeklyListGeneratorScreenState
    extends State<WeeklyListGeneratorScreen> {
  List<GroceryItem> weeklyList = [];

  // 🧩 Generate a random weekly list of items
  Future<void> _generateWeeklyList() async {
    final dbItems = await DBHelper.instance.getItems();
    final random = Random();

    // Shuffle and take 5 random items
    final selected = (dbItems.toList()..shuffle()).take(5).toList();

    // Assign random quantities and priorities
    final priorities = ["I don't need", "I kinda need", "I need now"];
    for (var item in selected) {
      item.quantity = random.nextInt(5) + 1; // Quantity 1–5
      item.priority = priorities[random.nextInt(priorities.length)];
    }

    setState(() {
      weeklyList = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly List Generator')),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Button to generate list
          ElevatedButton(
            onPressed: _generateWeeklyList,
            child: const Text('Generate Weekly List'),
          ),

          const SizedBox(height: 20),

          // Display generated list
          Expanded(
            child: weeklyList.isEmpty
                ? const Center(child: Text('No weekly list yet.'))
                : ListView.builder(
                    itemCount: weeklyList.length,
                    itemBuilder: (context, index) {
                      final item = weeklyList[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Qty: ${item.quantity} | Priority: ${item.priority}',
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Go back to home screen
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
