import 'package:flutter/material.dart';

class Item {
  String name;
  String category;
  String price;
  String quantity;

  // Controllers untuk kebutuhan UI
  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController quantityController;

  Item({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    TextEditingController? nameController,
    TextEditingController? priceController,
    TextEditingController? quantityController,
  })  : nameController = nameController ?? TextEditingController(text: name),
        priceController = priceController ?? TextEditingController(text: price),
        quantityController =
            quantityController ?? TextEditingController(text: quantity);

  // Perbarui data dari controllers
  void updateFromControllers() {
    name = nameController.text;
    price = priceController.text;
    quantity = quantityController.text;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['item_name'],
      category: json['category'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    // Perbarui nilai dari controllers terlebih dahulu
    updateFromControllers();

    return {
      'item_name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
    };
  }

  // Fungsi untuk dispose controllers
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }
}
