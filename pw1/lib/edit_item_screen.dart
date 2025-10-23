import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../db/db_helper.dart';

class EditItemScreen extends StatefulWidget {
  final GroceryItem item;
  const EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  bool purchased = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    categoryController = TextEditingController(text: widget.item.category);
    quantityController = TextEditingController(text: widget.item.quantity.toString());
    priceController = TextEditingController(text: widget.item.price.toString());
    descriptionController = TextEditingController(text: widget.item.description);
    purchased = widget.item.purchased;
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    quantityController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final updatedItem = GroceryItem(
      id: widget.item.id,
      name: nameController.text,
      category: categoryController.text,
      quantity: int.tryParse(quantityController.text) ?? 1,
      price: double.tryParse(priceController.text) ?? 0.0,
      description: descriptionController.text,
      image: widget.item.image,
      purchased: purchased,
    );

    await DBHelper.instance.updateItem(updatedItem);
    Navigator.pop(context, true); // Return true so we know to refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Item")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price (\$)'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SwitchListTile(
              title: const Text('Purchased'),
              value: purchased,
              onChanged: (val) => setState(() => purchased = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
