import 'dart:math';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/grocery_item.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  List<GroceryItem> weeklyList = [];

  Future<void> _generateWeeklyList() async {
    final dbItems = await DBHelper.instance.getItems();
    final random = Random();

    // 🧠 Shuffle and take a few items (e.g., 5)
    final selected = (dbItems.toList()..shuffle()).take(5).toList();

    // 🛒 Assign random quantity & priority
    final priorities = ["I don't need", "I kinda need", "I need now"];
    for (var item in selected) {
      item.quantity = random.nextInt(5) + 1; // random 1–5
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
          ElevatedButton(
            onPressed: _generateWeeklyList,
            child: const Text('Generate Weekly List'),
          ),
          const SizedBox(height: 20),
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
