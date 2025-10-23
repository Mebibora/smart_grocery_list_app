class GroceryItem{ 
    final int? id;
    final String name;
    final String category;
    final int quantity;
    final double price;
    final String description;
    final String image;
    final bool purchased;

    GroceryItem({
        this.id;
        require this.name;
        require this.category,
        this.quantity = 1;
        require this.price,
        this.purchased = false,
        require this.description,
        require this.image,
    });

    // in order to save our items values we use a map or dictionary 
    Map<String, dynamic> toMap() => {
        'id' : id,
        'name' : name,
        'category' : category,
        'quantity' : quantity, 
        'purchased' : purchased,
        'price' : price, 
        'description' : description,
        'image' : image,
        'purchased' : purchased ? 1 : 0, 
    };

    //to covert the map back to an object to load 
    factory GroceryItem.fromMap(Map<String, dynamic> Map) => GroceryItem(
        id : map["id"],
        price : map["price"],
        description : map["description"]
        name : map["name"],
        category : category["category"],
        quantity : quantity["quantity"],
        image : quantity["image"],
        purchased : purchased["purchased"] == 1, //probably make this the check box value. 
    );
}
