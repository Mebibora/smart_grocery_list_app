class GroceryItem {
  final int? id;
  final String name;
  final String category;
  int quantity;
  final double price;
  final String description;
  final String image;
  bool purchased;
  bool approved;
  String priority;

  GroceryItem({
    this.id,
    required this.name,
    required this.category,
    this.quantity = 1,
    required this.price,
    required this.description,
    required this.image,
    this.purchased = false,
    this.approved = false,
    this.priority = "I don’t need",
  });

  // Convert object to map
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'category': category,
        'quantity': quantity,
        'price': price,
        'description': description,
        'image': image,
        'purchased': purchased ? 1 : 0,
        'approved': approved ? 1 : 0,
        'priority': priority,
      };

  // Convert map to object
  factory GroceryItem.fromMap(Map<String, dynamic> map) => GroceryItem(
        id: map['id'],
        name: map['name'],
        category: map['category'],
        quantity: map['quantity'],
        price: map['price'],
        description: map['description'],
        image: map['image'],
        purchased: map['purchased'] == 1,
        approved: map['approved'] == 1,
        priority: map['priority'] ?? "I don’t need",
      );
}
