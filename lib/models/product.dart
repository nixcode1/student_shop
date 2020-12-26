// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Product({
        this.price,
        this.proprties,
        this.imageUrl,
        this.name,
        this.description,
        this.id,
        this.category,
        this.productClass,
    });

    int price;
    Proprties proprties;
    String imageUrl;
    String name;
    String description;
    String id;
    String category;
    int productClass;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        price: json["price"],
        proprties: Proprties.fromJson(json["proprties"]),
        imageUrl: json["imageUrl"],
        name: json["name"],
        description: json["description"],
        id: json["id"],
        category: json["category"],
        productClass: json["class"],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "proprties": proprties.toJson(),
        "imageUrl": imageUrl,
        "name": name,
        "description": description,
        "id": id,
        "category": category,
        "class": productClass,
    };
}

class Proprties {
    Proprties({
        this.gpuClass,
        this.cpuClass,
        this.storage,
    });

    int gpuClass;
    int cpuClass;
    int storage;

    factory Proprties.fromJson(Map<String, dynamic> json) => Proprties(
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
