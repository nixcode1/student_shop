// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'product.g.dart';


List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
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

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
