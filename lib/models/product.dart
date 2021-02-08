// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product(
      {this.price,
      this.imageUrl,
      this.name,
      this.description,
      this.id,
      this.category,
      this.properties,
      this.createdAt,
      this.rank});

  int price;
  int rank;
  String imageUrl;
  String name;
  String description;
  String id;
  String category;
  Properties properties;
  DateTime createdAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        price: json["price"],
        rank: json["rank"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        description: json["description"],
        id: json["id"],
        category: json["category"],
        createdAt: json['createdAt'].toDate(),
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "imageUrl": imageUrl,
        "name": name,
        "description": description,
        "id": id,
        "category": category,
        "properties": properties.toJson(),
      };
}

class Properties {
  Properties({
    this.gpuClass,
    this.cpuClass,
    this.storage,
  });

  int gpuClass;
  int cpuClass;
  String storage;

  bool compare(Properties object) {
    if (object.gpuClass > gpuClass &&
        object.cpuClass > cpuClass &&
        object.storage == storage) {
      return true;
    } else {
      return false;
    }
  }

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        gpuClass: json["gpu_class"],
        cpuClass: json["cpu_class"],
        storage: json["storage"],
      );

  Map<String, dynamic> toJson() => {
        "gpu_class": gpuClass,
        "cpu_class": cpuClass,
        "storage": storage,
      };
}
