// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.price,
    this.name,
    this.description,
    this.category,
    this.imageUrl,
  });
  String id;
  int price;
  String name;
  String description;
  String category;
  String imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"].toString(),
        price: json["price"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "description": description,
        "category": category,
        "imageUrl": imageUrl,
      };
}
