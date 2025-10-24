class GroceryItem {
  final int? id;
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String description;
  final String image;
  final bool purchased;

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
  });

  // Convert to map for saving to database
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'category': category,
        'quantity': quantity,
        'price': price,
        'description': description,
        'image': image,
        'purchased': purchased ? 1 : 0, // SQLite stores bools as 0/1\
        'approved' : approved ? 1 : 0,
      };

  // Convert map from database to GroceryItem object
  factory GroceryItem.fromMap(Map<String, dynamic> map) => GroceryItem(
        id: map['id'],
        name: map['name'],
        category: map['category'],
        quantity: map['quantity'],
        price: map['price'],
        description: map['description'],
        image: map['image'],
        purchased: map['purchased'] == 1,
        approved: approved['approved'] == 1,
      );
}
