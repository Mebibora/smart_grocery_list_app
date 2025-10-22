class { 
    final String name;
    final String category;
    final int quantity;
    bool purchased;

    GroceryItem({
        require this.name;
        require this.category,
        this.quantity = 1;
        this.purchased = false,
    });

    // in order to save our items values we use a map or dictionary 
    Map<String, dynamic> toMap() => {
        'name' : name,
        'category' : category,
        'quantity' : quantity, 
        'purchased' : purchased,
    };

    //to covert the map back to an object to load 
    factory GroceryItem.fromMap(Map<String, dynamic> Map) => GroceryItem(
        name : map["name"],
        category : category["category"],
        quantity : quantity["quantity"],
        purchased : purchased["purchased"], //probably make this the check box value. 
    );
}
