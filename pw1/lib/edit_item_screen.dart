import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../database/db_helper.dart';



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
  String? _selectedPriority;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    categoryController = TextEditingController(text: widget.item.category);
    quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    priceController =
        TextEditingController(text: widget.item.price.toString());
    descriptionController =
        TextEditingController(text: widget.item.description);
    purchased = widget.item.purchased;
    _selectedPriority = widget.item.priority;
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

  //table to return a price estimation depending on the category of an item
  void estimatePrice(category){ 
    setState(() {
      switch(category){
        case "Fruits":
          priceController.text = "0.50";  
          break;
        case "Dairy":
          priceController.text = "1.00"; 
          break;
        case "Bakery":
          priceController.text = "3.99"; 
          break;
        case "Poultry":
          priceController.text = "3.99"; 
          break;
        case "Meat":
          priceController.text = "12.49"; 
          break;
        case "Grain":
          priceController.text = "3.99"; 
          break;
        case "Beverages":
          priceController.text = "2.99"; 
          break;
        case "Vegetable":
          priceController.text = "0.79"; 
          break;
        case "Pantry":
          priceController.text = "2.00"; 
          break;
        case "Cleaning_Supplies":
          priceController.text = "15.59"; 
          break;
        default:
          priceController.text = "0";
      }
    });  
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
      priority: _selectedPriority ?? "I don't need",
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
            const SizedBox(height: 10),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                estimatePrice(categoryController.text);},
              child: Text("Estimate Price")
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price (\$)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              decoration: const InputDecoration(labelText: 'Priority Level'),
              items: const [
                DropdownMenuItem(
                    value: "I don't need", child: Text("I don't need")),
                DropdownMenuItem(
                    value: "I kinda need", child: Text("I kinda need")),
                DropdownMenuItem(
                    value: "I need now", child: Text("I need now")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value;
                });
              },
            ),
            const SizedBox(height: 20),
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
